/// Kind of place we forecast. Opening hours here are typical defaults, used
/// when the place has no known hours of its own.
///
/// Pure Dart — no Flutter imports.
enum PlaceCategory {
  fastFood('Fast food', openHour: 6, closeHour: 24),
  kainan('Kainan', openHour: 10, closeHour: 22),
  coffee('Coffee shop', openHour: 7, closeHour: 22),
  palengke('Palengke', openHour: 4, closeHour: 19),
  mall('Mall', openHour: 10, closeHour: 21),
  supermarket('Supermarket', openHour: 8, closeHour: 22),
  services('Services', openHour: 8, closeHour: 18);

  const PlaceCategory(
    this.label, {
    required this.openHour,
    required this.closeHour,
  });

  final String label;

  /// First open hour (0–23, inclusive).
  final int openHour;

  /// Closing hour (0–24, exclusive).
  final int closeHour;
}

typedef Hours = ({int open, int close});

/// Where a place's details come from.
enum PlaceSource { google, osm }

class Place {
  const Place({
    required this.id,
    required this.name,
    required this.area,
    required this.category,
    required this.lat,
    required this.lng,
    this.brand,
    this.phone,
    this.website,
    this.operator,
    this.email,
    this.cuisine,
    this.description,
    this.wheelchair,
    this.outdoorSeating,
    this.internetAccess,
    this.delivery,
    this.takeaway,
    this.capacity,
    this.facebook,
    this.instagram,
    this.openingHours,
    this.hours,
    this.source = PlaceSource.osm,
    this.photoName,
    this.photoAuthor,
  });

  /// `g-<Google place id>` or `osm-<type>-<id>`.
  final String id;

  final PlaceSource source;

  /// Google photo resource name (`places/…/photos/…`). Never persisted —
  /// Google's terms forbid caching it.
  final String? photoName;

  /// Photo author to credit wherever the photo is shown.
  final String? photoAuthor;
  final String name;

  /// Street / barangay / city — may be empty when the source has no address.
  final String area;
  final PlaceCategory category;
  final double lat;
  final double lng;
  final String? brand;
  final String? phone;
  final String? website;
  final String? operator;
  final String? email;
  final String? cuisine;
  final String? description;
  final String? wheelchair;
  final String? outdoorSeating;
  final String? internetAccess;
  final String? delivery;
  final String? takeaway;
  final String? capacity;
  final String? facebook;
  final String? instagram;

  /// Raw OpenStreetMap `opening_hours`, kept for caching.
  final String? openingHours;

  /// Parsed [openingHours]; null → category defaults.
  final Hours? hours;

  bool get hasKnownHours => hours != null;

  int get openHour => hours?.open ?? category.openHour;

  /// Exclusive; may be ≤ [openHour] when open past midnight.
  int get closeHour => hours?.close ?? category.closeHour;

  bool get isOpen24Hours => openHour == 0 && closeHour == 24;

  bool isOpenAt(int hour) {
    final open = openHour;
    final close = closeHour;
    return close > open
        ? hour >= open && hour < close
        : hour >= open || hour < close;
  }
}
