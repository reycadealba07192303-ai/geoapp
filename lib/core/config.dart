/// Google Maps Platform key, passed at build time:
/// `flutter run --dart-define-from-file=secrets.json`.
///
/// Empty → Google Places is off and the app uses OpenStreetMap only.
const googleMapsApiKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');

/// Optional backend base URL for place discovery, for example:
/// `flutter run --dart-define=BACKEND_BASE_URL=http://192.168.1.10:8000`.
///
/// Empty -> mobile calls Google Places directly when GOOGLE_MAPS_API_KEY exists,
/// then falls back to OpenStreetMap.
const backendBaseUrl = String.fromEnvironment('BACKEND_BASE_URL');
