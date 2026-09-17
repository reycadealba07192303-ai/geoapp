# GeoApp

For the full system description, architecture, data model, API reference,
forecast logic, deployment instructions, and known limitations, see
[docs/SYSTEM_DOCUMENTATION.md](docs/SYSTEM_DOCUMENTATION.md).

GeoApp is an offline-first Flutter app for finding nearby establishments,
viewing crowd forecasts, and submitting anonymous crowd reports.

Predictions are not live cameras or sensors. Crowd forecasts come from real
user reports when enough data exists; otherwise the app uses a clearly labeled
category estimate.

## Stack

| Layer | Technology |
|---|---|
| Mobile | Flutter, Riverpod, Drift, flutter_map |
| Map tiles | OpenStreetMap |
| Place data | OpenStreetMap and Overpass API |
| Backend | Node.js and MongoDB |
| Local storage | Drift and SQLite |

No Google Maps, Google Places, Mapbox, scraping, or paid place API is required.

## Current implementation status

The application is currently a working prototype. OpenStreetMap place
discovery, map display, local caching, user reporting, forecast lookup, and
category-based estimate fallback are implemented. Historical aggregation is
implemented in the backend, but it only creates field forecasts after MongoDB
contains enough real reports for a specific place, weekday, and hour. The
repository does not include historical or synthetic crowd data.

## Proposal-ready project description

### 1. Introduction

People often decide where to eat or visit without knowing how crowded an
establishment may be at a particular time. This can result in long queues,
limited seating, and wasted travel time, especially during lunch, dinner, and
other busy periods. Small establishments may also have limited ways to share
their current crowd situation with nearby customers.

At present, users commonly rely on personal observation, word of mouth, or
general map applications to choose an establishment. These methods may show a
place's location, but they do not provide a focused view of nearby places,
historical crowd patterns, or anonymous crowd reports for the user's selected
area and time.

The identified gap is the lack of a single lightweight system that combines
nearby establishment discovery with time-based crowd information. GeoApp is
proposed as a mobile Flutter application that displays nearby OpenStreetMap
establishments, accepts anonymous user crowd reports, and provides forecast
estimates or place-specific historical forecasts when sufficient real data has
been collected. The application is supported by a Node.js and MongoDB backend
and uses OpenStreetMap and Overpass as its place-data sources.

### 2. Purpose of the Project

This proposal aims to present a mobile application that will help users find
nearby establishments, understand crowd conditions by time, submit anonymous
crowd reports, and identify more suitable times to visit. It intends to reduce
uncertainty when choosing where and when to go by combining location-based
place information, real user reports, and data-driven forecast estimates in a
single free-to-operate system.

### 3. Objectives

#### 3.1 General Objective

To design and develop an offline-first mobile application that helps users
discover nearby establishments and make time-based visit decisions using
OpenStreetMap place data, real anonymous crowd reports, and explainable crowd
forecasting.

#### 3.2 Specific Objectives

- To develop a mobile map and list interface that displays nearby
  establishments using OpenStreetMap tiles and Overpass place data.
- To allow users to select a nearby search scope of 1 km, 5 km, or 10 km.
- To provide establishment details using available OpenStreetMap information,
  including category, address, opening hours, phone, website, cuisine, and
  supported amenities.
- To allow users to submit anonymous crowd-level reports for a specific
  establishment.
- To store reports locally for offline use and send them to the backend when
  the backend is configured and reachable.
- To aggregate real reports by establishment, weekday, and hour after the
  configured minimum sample threshold is reached.
- To provide a next-24-hours forecast that observes opening hours and ranks
  available hourly crowd values for the selected establishment.
- To distinguish place-specific field forecasts from category-based estimates
  when historical data is insufficient.
- To provide nearby alternatives based on establishment category, distance,
  opening status, and available current crowd signal.
- To use a local Drift/SQLite cache so previously downloaded place information
  remains available when connectivity is limited.

### 4. Project Scope

#### 4.1 In Scope

- Flutter mobile application for Android development and testing.
- GPS-based nearby scope centered on the user's location.
- User-selectable 1 km, 5 km, and 10 km search scopes.
- OpenStreetMap map tiles through `flutter_map`.
- Nearby establishment discovery through OpenStreetMap and Overpass API.
- Cached establishment data stored in a local Drift/SQLite database.
- Establishment categories, address details, opening hours, contact details,
  cuisine, and available OSM amenities.
- Anonymous crowd-level reporting for individual establishments.
- MongoDB storage for reports, places, and generated forecast rows.
- Aggregation of real reports by place ID, weekday, and hour.
- Minimum-sample validation and confidence metadata for field forecasts.
- Current crowd signal based on recent reports.
- Next-24-hours and weekly forecast views.
- Opening-hours filtering for forecast recommendations.
- Category-based estimate fallback when field data is unavailable.
- Dark, light, and system theme settings.
- English and Filipino language options.

#### 4.2 Out of Scope

- Google Maps or Google Places integration.
- Google Maps scraping or copying proprietary Google business data.
- Mapbox or other paid third-party map/place services.
- Live CCTV, camera-based crowd detection, or hardware sensors.
- Guaranteed real-time crowd measurement.
- Automatic verification that a user report is truthful.
- Artificial, randomized, or synthetic crowd reports and forecasts.
- Historical forecasting for a place before it reaches the minimum real-report
  threshold.
- Procurement of hardware, paid hosting, or third-party API licensing.
- Complete coverage of every establishment or every OSM detail field.
- A guarantee that OpenStreetMap contains all places or the same information
  shown by commercial map applications.

## Repository layout

```text
lib/core/database/   Drift tables and DAOs
lib/core/location/   GPS wrapper
lib/domain/          Forecast, fusion, and recommendation logic
lib/features/        Map, forecast, list, report, and settings UI
backend/             Node.js API and MongoDB repositories
docs/field/          Observation guide and data-collection sheets
pipeline/            Historical-data utilities
```

## Run the Flutter app

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
flutter run
```

## Run the backend

MongoDB must be running locally or through a configured MongoDB URI.

```powershell
$env:MONGODB_URI="mongodb://127.0.0.1:27017"
$env:MONGODB_DB="geoapp"
node backend/server.js
```

The released app uses the deployed Railway backend by default. For local
development, a phone connected to the same Wi-Fi can use the laptop LAN IP:

```powershell
flutter run --dart-define=BACKEND_BASE_URL=http://192.168.1.10:8000
```

## Backend endpoints

```text
GET  /health
GET  /places/nearby?lat=15.1&lng=120.5&radius=10000
GET  /reports?since=2026-09-17T00:00:00Z
POST /reports
GET  /forecasts?placeIds=osm-node-1,osm-way-2
POST /forecasts
POST /forecasts/aggregate
```

Example report:

```json
{
  "placeId": "osm-node-123",
  "crowdLevel": 3,
  "reportedAt": "2026-09-17T10:00:00Z"
}
```

## Forecast data flow

```text
User report
  -> local Drift UserReports
  -> POST /reports
  -> MongoDB reports
  -> aggregation by place + weekday + hour
  -> MongoDB forecasts
  -> GET /forecasts
  -> Flutter fieldBaselinesProvider
  -> PlaceForecastBuilder
  -> data-based recommendation
```

The aggregation uses the existing crowd-level-to-index conversion. It groups
only by the stable OSM place ID, ISO weekday, and local hour. Each forecast is
upserted using:

```text
placeId + dayOfWeek + hour
```

This makes aggregation idempotent and prevents data from different places from
being combined.

During development, `MIN_FORECAST_SAMPLES` defaults to `5`. Groups below the
threshold are skipped and continue using `estimateBaseline()`. Confidence is
numeric and corresponds to low, medium, or high reliability based on sample
count. The backend aggregates on startup and every hour while the backend is
running, or manually:

```powershell
Invoke-WebRequest -Method Post http://localhost:8000/forecasts/aggregate
```

Recent reports from the last two hours are a separate current crowd signal.
They influence the current forecast but do not directly overwrite historical
forecast rows. The backend does not automatically convert a single recent
report into a historical forecast; aggregation still enforces the minimum
sample threshold.

## OSM place IDs and details

OSM establishments use stable IDs such as:

```text
osm-node-123456
osm-way-987654
osm-relation-555555
```

The app reads available OSM tags including name, category, cuisine, address,
opening hours, phone, website, email, operator, description, and amenities.
Missing optional tags are hidden in the details UI. OSM coverage varies by
place, so Google Maps may show establishments or details that have not yet
been mapped in OpenStreetMap.

## Field data

Read [docs/field/OBSERVATION_GUIDE.md](docs/field/OBSERVATION_GUIDE.md) before
collecting data. The CSV and pipeline must contain real observations only.
Never generate synthetic reports or forecasts to make recommendations appear
different.

The application falls back to category estimates until enough real reports
exist for a specific establishment, weekday, and hour.
