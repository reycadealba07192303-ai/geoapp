import 'crowd_level.dart';
import 'forecast_service.dart';
import 'fusion_service.dart';
import 'geo.dart';
import 'place.dart';
import 'recommendation_service.dart';

/// Historical baseline for a place × ISO weekday (1–7) × hour (0–23), 0–1.
typedef BaselineLookup = double Function(Place place, int dayOfWeek, int hour);

/// A crowd report from a user (1 = maluwag … 5 = siksikan).
class LiveReport {
  const LiveReport({
    required this.placeId,
    required this.reportedAt,
    required this.crowdLevel,
  });

  final String placeId;
  final DateTime reportedAt;
  final int crowdLevel;
}

class HourSlot {
  const HourSlot({
    required this.time,
    required this.crowdIndex,
    required this.isOpen,
  });

  final DateTime time;
  final double crowdIndex;
  final bool isOpen;

  CrowdLevel get level => CrowdLevel.fromIndex(crowdIndex);
}

class DayOutlook {
  const DayOutlook({
    required this.date,
    required this.openSlots,
    required this.isPayday,
  });

  final DateTime date;
  final List<HourSlot> openSlots;
  final bool isPayday;

  HourSlot get peak =>
      openSlots.reduce((a, b) => b.crowdIndex > a.crowdIndex ? b : a);

  HourSlot get quietest =>
      openSlots.reduce((a, b) => b.crowdIndex < a.crowdIndex ? b : a);
}

class BestVisit {
  const BestVisit({required this.slot, required this.isToday});

  final HourSlot slot;
  final bool isToday;
}

class Alternative {
  const Alternative({
    required this.place,
    required this.crowdIndex,
    required this.distanceMeters,
  });

  final Place place;
  final double crowdIndex;
  final double distanceMeters;

  CrowdLevel get level => CrowdLevel.fromIndex(crowdIndex);
}

/// Everything the weather-style screen shows for one place.
class PlaceForecast {
  const PlaceForecast({
    required this.place,
    required this.asOf,
    required this.usesFieldData,
    required this.current,
    required this.baseForecast,
    required this.recentReports,
    required this.next24,
    required this.today,
    required this.week,
    required this.best,
    required this.alternatives,
  });

  final Place place;
  final DateTime asOf;

  /// Baseline from field observations (true) or a category estimate (false).
  final bool usesFieldData;

  /// Current hour, fused with recent reports.
  final HourSlot current;

  /// Current hour before fusing reports — shows how much reports moved it.
  final double baseForecast;

  final List<LiveReport> recentReports;
  final List<HourSlot> next24;

  /// Hours 0–23 of today.
  final List<HourSlot> today;

  /// Today + next 6 days.
  final List<DayOutlook> week;

  final BestVisit? best;
  final List<Alternative> alternatives;

  DayOutlook get todayOutlook => week.first;
}

/// Builds a [PlaceForecast] from baselines + the existing domain services.
///
/// Pure Dart — no Flutter imports.
class PlaceForecastBuilder {
  PlaceForecastBuilder({
    required this.baseline,
    this.hasFieldData,
    ForecastService? forecast,
    FusionService? fusion,
    RecommendationService? recommendation,
  }) : _forecast = forecast ?? ForecastService(),
       _fusion = fusion ?? FusionService(),
       _recommendation = recommendation ?? RecommendationService();

  final BaselineLookup baseline;

  /// True when [baseline] comes from field observations for this place
  /// (otherwise it is a category estimate).
  final bool Function(Place place)? hasFieldData;
  final ForecastService _forecast;
  final FusionService _fusion;
  final RecommendationService _recommendation;

  /// Reports older than this are ignored entirely.
  static const reportWindow = Duration(hours: 2);

  /// Sweldo (15th / 30th / end of month) crowds.
  static const paydayMultiplier = 1.15;

  /// An alternative must be at least this much quieter to be suggested.
  static const minImprovement = 0.1;

  /// Alternatives must be within this distance of the place.
  static const alternativeRadiusMeters = 3000.0;

  static bool isPayday(DateTime date) {
    final lastDay = DateTime(date.year, date.month + 1, 0).day;
    return date.day == 15 || date.day == 30 || date.day == lastDay;
  }

  double forecastAt(Place place, DateTime time) {
    if (!place.isOpenAt(time.hour)) return 0;
    return _forecast.predict(
      baseline: baseline(place, time.weekday, time.hour),
      eventMultiplier: isPayday(time) ? paydayMultiplier : 1.0,
    );
  }

  List<LiveReport> recentReports(
    Place place,
    DateTime now,
    List<LiveReport> reports,
  ) {
    return reports
        .where(
          (r) =>
              r.placeId == place.id &&
              now.difference(r.reportedAt) <= reportWindow,
        )
        .toList();
  }

  /// Forecast for the current hour, pulled toward recent reports.
  ///
  /// Opening hours are often a guess, so a recent report from a place we
  /// think is closed wins: it is open, and the reports say how busy.
  double currentIndex(Place place, DateTime now, List<LiveReport> reports) {
    final recent = recentReports(place, now, reports);
    final indexes = [
      for (final r in recent) _forecast.levelToIndex(r.crowdLevel),
    ];
    final ages = [for (final r in recent) now.difference(r.reportedAt)];

    if (!place.isOpenAt(now.hour)) {
      if (recent.isEmpty) return 0;
      var weighted = 0.0;
      var weights = 0.0;
      for (var i = 0; i < recent.length; i++) {
        final w = _fusion.decay(ages[i]);
        weighted += indexes[i] * w;
        weights += w;
      }
      return weights == 0 ? 0 : weighted / weights;
    }

    return _fusion.fuse(
      forecastIndex: forecastAt(place, now),
      reportIndexes: indexes,
      reportAges: ages,
    );
  }

  /// Just the current hour — cheap enough for every map pin / list row.
  HourSlot currentSlot(Place place, DateTime now, List<LiveReport> reports) {
    return HourSlot(
      time: DateTime(now.year, now.month, now.day, now.hour),
      crowdIndex: currentIndex(place, now, reports),
      isOpen:
          place.isOpenAt(now.hour) ||
          recentReports(place, now, reports).isNotEmpty,
    );
  }

  PlaceForecast build({
    required Place place,
    required DateTime now,
    required List<Place> allPlaces,
    required List<LiveReport> reports,
  }) {
    final current = currentSlot(place, now, reports);

    final next24 = [
      current,
      for (var i = 1; i < 24; i++)
        _slot(place, DateTime(now.year, now.month, now.day, now.hour + i)),
    ];

    final today = [
      for (var h = 0; h < 24; h++)
        h == now.hour
            ? current
            : _slot(place, DateTime(now.year, now.month, now.day, h)),
    ];

    final week = [
      for (var d = 0; d < 7; d++)
        _day(place, DateTime(now.year, now.month, now.day + d)),
    ];

    return PlaceForecast(
      place: place,
      asOf: now,
      usesFieldData: hasFieldData?.call(place) ?? false,
      current: current,
      baseForecast: forecastAt(place, now),
      recentReports: recentReports(place, now, reports),
      next24: next24,
      today: today,
      week: week,
      best: _bestVisitNext24(next24, now),
      alternatives: _alternatives(place, current, now, allPlaces, reports),
    );
  }

  HourSlot _slot(Place place, DateTime time) {
    return HourSlot(
      time: time,
      crowdIndex: forecastAt(place, time),
      isOpen: place.isOpenAt(time.hour),
    );
  }

  BestVisit? _bestVisitNext24(List<HourSlot> slots, DateTime now) {
    final open = [for (final slot in slots) if (slot.isOpen) slot]
      ..sort((a, b) => a.crowdIndex.compareTo(b.crowdIndex));
    if (open.isEmpty) return null;
    final slot = open.first;
    return BestVisit(slot: slot, isToday: slot.time.day == now.day);
  }

  DayOutlook _day(Place place, DateTime date) {
    return DayOutlook(
      date: date,
      openSlots: [
        for (var h = 0; h < 24; h++)
          if (place.isOpenAt(h))
            _slot(place, DateTime(date.year, date.month, date.day, h)),
      ],
      isPayday: isPayday(date),
    );
  }

  BestVisit? _bestVisit(
    List<HourSlot> today,
    DateTime now,
    DayOutlook tomorrow,
  ) {
    // Past the half hour, the current slot is nearly over — look ahead.
    final firstHour = now.minute < 30 ? now.hour : now.hour + 1;
    final remaining = {
      for (final s in today)
        if (s.isOpen && s.time.hour >= firstHour) s.time.hour: s.crowdIndex,
    };

    if (remaining.isNotEmpty) {
      final best = _recommendation.findBestTimeToGo(remaining)!;
      return BestVisit(slot: today[best.hour], isToday: true);
    }

    final best = _recommendation.findBestTimeToGo({
      for (final s in tomorrow.openSlots) s.time.hour: s.crowdIndex,
    });
    if (best == null) return null;
    return BestVisit(
      slot: tomorrow.openSlots.firstWhere((s) => s.time.hour == best.hour),
      isToday: false,
    );
  }

  List<Alternative> _alternatives(
    Place place,
    HourSlot current,
    DateTime now,
    List<Place> allPlaces,
    List<LiveReport> reports,
  ) {
    // When this place is closed, any open place is an alternative.
    final threshold = current.isOpen
        ? current.crowdIndex - minImprovement
        : 1.0;

    // Only same kind of bilihan — a mall shopper won't switch to a palengke.
    final byId = <String, Place>{};
    final candidates = <RankedBranch>[];
    for (final other in allPlaces) {
      if (other.id == place.id ||
          other.category != place.category ||
          !other.isOpenAt(now.hour)) {
        continue;
      }
      final distance = distanceMeters(
        place.lat,
        place.lng,
        other.lat,
        other.lng,
      );
      if (distance > alternativeRadiusMeters) continue;
      final index = currentIndex(other, now, reports);
      if (index > threshold) continue;
      byId[other.id] = other;
      candidates.add(
        RankedBranch(
          branchId: other.id,
          name: other.name,
          brand: other.category.label,
          crowdIndex: index,
          distanceMeters: distance,
        ),
      );
    }

    return [
      for (final ranked in _recommendation.rankQuieterAlternatives(
        candidates,
        limit: 3,
      ))
        Alternative(
          place: byId[ranked.branchId]!,
          crowdIndex: ranked.crowdIndex,
          distanceMeters: ranked.distanceMeters!,
        ),
    ];
  }
}
