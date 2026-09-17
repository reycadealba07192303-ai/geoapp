import 'package:flutter/widgets.dart';

import '../../domain/crowd_level.dart';
import '../../domain/place.dart';
import '../settings/app_settings.dart';

/// All user-facing text, in English and Filipino.
///
/// `final tr = Tr.of(context);` then `tr.recommendation`.
class Tr {
  const Tr(this.language);

  final AppLanguage language;

  static Tr of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TrScope>()?.tr ??
      const Tr(AppLanguage.english);

  bool get _fil => language == AppLanguage.filipino;
  String _t(String en, String fil) => _fil ? fil : en;

  // Navigation
  String get tabForecast => 'Forecast';
  String get tabMap => _t('Map', 'Mapa');
  String get tabList => _t('Places', 'Listahan');
  String get report => 'Report';

  // Scope / location
  String nearYou(int km) => _t('Near you · $km km', 'Malapit sa iyo · $km km');
  String get locating =>
      _t('Finding your location…', 'Hinahanap ang lokasyon…');
  String turnOnLocation(String area) =>
      _t('$area · Turn on location', '$area · I-on ang lokasyon');
  String get yourLocation => _t('Your location', 'Iyong lokasyon');
  String get showNearest =>
      _t('Show nearest to me', 'Ipakita ang pinakamalapit');
  String get turnOnLocationSnack => _t(
    'Turn on location to see places near you.',
    'I-on ang lokasyon para makita ang mga lugar malapit sa iyo.',
  );

  // Crowd levels
  String level(CrowdLevel level) => switch (level) {
    CrowdLevel.maluwag => _t('Empty', 'Maluwag'),
    CrowdLevel.kaunti => _t('Light', 'Kaunti'),
    CrowdLevel.katamtaman => _t('Moderate', 'Katamtaman'),
    CrowdLevel.mataong => _t('Busy', 'Mataong'),
    CrowdLevel.siksikan => _t('Packed', 'Siksikan'),
  };

  String advice(CrowdLevel level) => switch (level) {
    CrowdLevel.maluwag => _t('Walk right in', 'Walang pila, dumiretso'),
    CrowdLevel.kaunti => _t('A few people, quick', 'Kaunting tao, mabilis'),
    CrowdLevel.katamtaman => _t('Normal crowd', 'Normal na dami ng tao'),
    CrowdLevel.mataong => _t('Expect a line', 'Asahan ang pila'),
    CrowdLevel.siksikan => _t('Avoid if you can', 'Iwasan kung pwede'),
  };

  String category(PlaceCategory category) => switch (category) {
    PlaceCategory.fastFood => 'Fast food',
    PlaceCategory.kainan => _t('Restaurant', 'Kainan'),
    PlaceCategory.coffee => 'Coffee shop',
    PlaceCategory.palengke => _t('Market', 'Palengke'),
    PlaceCategory.mall => 'Mall',
    PlaceCategory.supermarket => 'Supermarket',
    PlaceCategory.services => _t('Services', 'Serbisyo'),
  };

  String get all => _t('All', 'Lahat');

  // Hero
  String get closed => _t('Closed', 'Sarado');
  String get open => _t('Open', 'Bukas');
  String opensAt(String hour) => _t('Opens $hour', 'Magbubukas $hour');
  String get comeBackLater => _t('Come back later', 'Balik mamaya');
  String quietAt(String hour) => _t('Quiet $hour', 'Maluwag $hour');
  String busyAt(String hour) => _t('Busy $hour', 'Siksikan $hour');
  String liveReports(int n) => n == 1 ? '1 live report' : '$n live reports';
  String get paydayBoost => _t('Payday +15%', 'Sweldo +15%');
  String get estimate => 'Estimate';
  String get fieldData => 'Field data';

  // Recommendation
  String get recommendation => _t('Recommendation', 'Rekomendasyon');
  String get goNow => _t('Go now', 'Pumunta ngayon');
  String goAt(String hour) => _t('Go at $hour', 'Pumunta ng $hour');
  String tomorrowAt(String hour) => _t('Tomorrow, $hour', 'Bukas, $hour');
  String get notQuieterLater =>
      _t("Won't get quieter later", 'Hindi mas maluwag mamaya');
  String get noQuietLeftToday =>
      _t('No quiet hours left today', 'Wala nang maluwag na oras ngayong araw');
  String lessThanNow(int percent) =>
      _t('$percent% less than now', '$percent% mas kaunti kaysa ngayon');
  String get quieterNearby =>
      _t('Quieter nearby right now', 'Mas maluwag na malapit ngayon');
  String get openNearby => _t('Open nearby now', 'Bukas ngayon sa malapit');

  // Sections
  String get next24Hours => _t('Next 24 hours', 'Susunod na 24 oras');
  String get now => _t('Now', 'Ngayon');
  String get best => 'BEST';
  String get todayCurve => _t("Today's crowd", 'Takbo ng dami ngayong araw');
  String get sevenDay => _t('7-day forecast', '7-araw na forecast');
  String get today => _t('Today', 'Ngayon');
  String get tomorrow => _t('Tomorrow', 'Bukas');
  String get payday => _t('payday', 'sweldo');
  String weekday(int isoWeekday) => (_fil
      ? const ['Lun', 'Mar', 'Miy', 'Huw', 'Biy', 'Sab', 'Lin']
      : const [
          'Mon',
          'Tue',
          'Wed',
          'Thu',
          'Fri',
          'Sat',
          'Sun',
        ])[isoWeekday - 1];

  // Tiles
  String get hours => _t('Hours', 'Oras');
  String get open24Hours => _t('Open 24 hours', 'Bukas 24 oras');
  String typicalHours(String range) =>
      _t('$range (typical)', '$range (karaniwan)');
  String get peakToday => _t('Peak today', 'Peak ngayon');
  String get liveReportsTitle => 'Live reports';
  String get noReportsRecently =>
      _t('No reports in 2 hours', 'Walang report sa 2 oras');
  String minutesAgo(int minutes) => minutes < 1
      ? _t('just now', 'ngayon')
      : _t('$minutes min ago', '$minutes min ang nakalipas');
  String get source => _t('Source', 'Pinagmulan');
  String baseForecast(String percent) => 'Base $percent';
  String fromReports(String shift) =>
      _t('$shift from reports', '$shift dahil sa reports');

  // Recent reports
  String get recentReports => _t('Recent reports', 'Mga bagong report');
  String get anonymous => 'Anonymous';
  String get noReportsYet => _t(
    'No reports yet. Be the first to share how busy it is.',
    'Walang report pa. Maging una sa pag-share kung gaano matao.',
  );

  // Report sheet
  String get reportCrowd => _t('Report crowd', 'I-report ang dami ng tao');
  String get howCrowded => _t('How crowded is it now?', 'Gaano matao ngayon?');
  String get change => _t('Change', 'Palitan');
  String get choosePlace => _t('Choose a place', 'Pumili ng lugar');
  String get postAnonymously => _t('Post anonymously', 'I-post nang anonymous');
  String get anonymousNote => _t(
    'No account needed — reports are anonymous.',
    'Walang account — anonymous ang mga report.',
  );
  String get dataAdded => 'Data added';
  String dataAddedBody(String place) =>
      _t('Posted anonymously · $place', 'Anonymous na naipost · $place');

  // List
  String get places => _t('Places', 'Mga lugar');
  String placeCount(int n) => _t(n == 1 ? '1 place' : '$n places', '$n lugar');
  String get searchHint => _t(
    'Search: Jollibee, Starbucks, market…',
    'Hanapin: Jollibee, Starbucks, palengke…',
  );
  String get noResults => _t('No results', 'Walang nahanap');
  String get hours24Short => _t('24 hours', '24 oras');
  String until(String hour) => _t('Until $hour', 'Hanggang $hour');

  // Status
  String get downloadingTitle =>
      _t('Finding places near you…', 'Hinahanap ang mga lugar…');
  String downloadingBody(int km) => _t(
    'Getting stores, cafes and establishments within $km km.',
    'Kinukuha ang mga tindahan, cafe at establishments sa loob ng $km km.',
  );
  String get offlineTitle => _t('Internet needed', 'Kailangan ng internet');
  String get offlineBody => _t(
    'Places here haven\'t been downloaded yet. Connect once and they\'ll work offline.',
    'Hindi pa naka-download ang mga lugar dito. Kumonekta minsan — pagkatapos ay gumagana offline.',
  );
  String get tryAgain => _t('Try again', 'Subukan muli');
  String emptyTitle(int km) =>
      _t('No places within $km km', 'Walang lugar sa loob ng $km km');
  String get emptyBody => _t(
    'No stores, cafes or establishments found near your location.',
    'Walang tindahan, cafe o establishment na nahanap malapit sa iyong lokasyon.',
  );

  // Map
  String get myLocation => _t('My location', 'Aking lokasyon');
  String get wholeScope => _t('Whole area', 'Buong scope');
  String get downloadingShort =>
      _t('Finding places…', 'Hinahanap ang mga lugar…');
  String get offlineRetry =>
      _t('Offline — tap to retry', 'Offline — tap para subukan muli');
  String get noPlacesHere => _t('No places here', 'Walang lugar dito');
  String fromYou(String distance) =>
      _t('$distance from you', '$distance mula sa iyo');

  // Settings
  String get settings => 'Settings';
  String get languageLabel => _t('Language', 'Wika');
  String get theme => _t('Theme', 'Tema');
  String get dark => _t('Dark', 'Madilim');
  String get light => _t('Light', 'Maliwanag');
  String get system => _t('System', 'Sistema');

  String disclaimer({required bool fieldData, required bool google}) {
    final places = google
        ? _t(
            'Places: Google Maps & OpenStreetMap.',
            'Mga lugar: Google Maps at OpenStreetMap.',
          )
        : _t('Places: OpenStreetMap.', 'Mga lugar: OpenStreetMap.');
    final crowd = fieldData
        ? _t('Crowd % from field data', 'Crowd % mula field data')
        : _t(
            'Crowd % is an estimate from the type of place and time',
            'Crowd % ay estimate batay sa uri ng lugar at oras',
          );
    return '$places $crowd${_t(', adjusted by anonymous reports — not a live camera.', ', ina-adjust ng anonymous na reports — hindi live camera.')}';
  }
}

class TrScope extends InheritedWidget {
  const TrScope({super.key, required this.tr, required super.child});

  final Tr tr;

  @override
  bool updateShouldNotify(TrScope oldWidget) =>
      oldWidget.tr.language != tr.language;
}
