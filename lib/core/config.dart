/// Google Maps Platform key, passed at build time:
/// `flutter run --dart-define-from-file=secrets.json`.
///
/// Empty → Google Places is off and the app uses OpenStreetMap only.
const googleMapsApiKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');

/// Production backend. Clients can use the app without supplying a build flag.
/// For local development, override it with:
/// `--dart-define=BACKEND_BASE_URL=http://192.168.1.10:8000`.
const backendBaseUrl = String.fromEnvironment(
  'BACKEND_BASE_URL',
  defaultValue: 'https://geoapp-backend-production.up.railway.app',
);
