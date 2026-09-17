# GeoApp System Documentation

**System:** GeoApp
**Version:** 1.0.0+1
**Document status:** Current implementation reference
**Last reviewed:** 17 September 2026

## 1. System overview

GeoApp is a Flutter mobile application for discovering establishments near a
user's current location and understanding the expected crowd level at different
times. It combines OpenStreetMap place data, Overpass API search, local mobile
caching, anonymous crowd reports, and a Node.js/MongoDB backend.

The system is designed to remain useful when connectivity is limited. Places,
reports, settings, and forecast rows can be retained locally. When the backend
is reachable, place data and reports are synchronized through the deployed API.

Crowd values are not produced by cameras or physical sensors. The app labels a
forecast as field data only when it comes from enough real reports for the same
place, weekday, and hour. Until then, it uses an explainable category-and-time
estimate and labels it as an estimate.

## 2. Background and problem addressed

Users commonly use a map to find where an establishment is located, but a map
does not normally answer whether a place is likely to be busy at a particular
time. Users may need to travel, inspect several places manually, or depend on
word of mouth before choosing where to go.

There is also a data-coverage problem. Commercial map applications may contain
places or business details that are not mapped in OpenStreetMap. GeoApp therefore
does not promise complete coverage. It displays the information actually
available from OpenStreetMap and clearly handles missing optional fields.

GeoApp addresses these gaps through a location-based mobile interface, a
selectable nearby scope, OSM establishment details, anonymous reports, and
place-specific forecasts that improve as real observations are collected.

## 3. Purpose

The purpose of GeoApp is to help users decide where and when to visit nearby
establishments by showing available place information, the current crowd signal,
hourly outlooks, and quieter nearby alternatives in one free-to-operate mobile
system.

## 4. Objectives

### General objective

To develop an offline-first mobile application that supports nearby
establishment discovery and explainable, time-based crowd guidance using
OpenStreetMap data and real anonymous user reports.

### Specific objectives

1. Display establishments around the user's GPS location on an OpenStreetMap
   map and in a sorted list.
2. Allow the user to choose a 1 km, 5 km, or 10 km search scope.
3. Show available OSM establishment information such as category, address,
   opening hours, contact details, cuisine, and amenities.
4. Accept anonymous crowd reports using a 1-to-5 crowd scale.
5. Preserve place and report information locally for offline continuity.
6. Synchronize reports and retrieve place-specific forecast rows through the
   Node.js backend when online.
7. Aggregate real reports by place, weekday, and hour only after the minimum
   sample threshold is reached.
8. Generate next-24-hour and seven-day views while considering opening status.
9. Recommend quieter times and nearby alternatives using calculated crowd
   values, not randomized or hardcoded differences.
10. Keep the operational architecture free by using OpenStreetMap, Overpass,
    the existing backend, and MongoDB.

## 5. Intended users and roles

### Mobile user

- Grants location permission.
- Chooses the search radius.
- Browses nearby places on the map or list.
- Opens a place's forecast and details.
- Submits an anonymous crowd report.
- Changes language, theme, and nearby scope.

### Backend/development operator

- Configures the backend environment.
- Monitors Railway and MongoDB service health.
- Reviews logs and forecast aggregation counts.
- Runs tests, imports only real field observations when applicable, and
  maintains the application.

There is currently no separate end-user account system, administrator dashboard,
moderation dashboard, or role-based access control.

## 6. Functional modules

### 6.1 Location and coverage

The app requests fine or coarse location permission through `geolocator`. It
uses the latest known position first, then requests a current position when
necessary. A location stream updates the search center as the device moves.

The selectable scope is persisted in app settings:

| Option | Radius |
|---|---:|
| Near | 1 km |
| Nearby | 5 km |
| Wide | 10 km |

Places are filtered by actual distance from the center and sorted nearest first.
If location is unavailable, the app uses its configured default study area
until a GPS fix becomes available.

### 6.2 Map and list

The map uses `flutter_map` with OpenStreetMap tiles. The map and list share the
same filtered place provider, so category filtering and search-scope changes
apply consistently to both views.

The main navigation currently contains:

- Forecast: selected or nearest place forecast.
- Map: establishments displayed on the map.
- Places/List: nearby establishments sorted by distance.
- Report: crowd-report form.
- Settings: language, theme, and scope controls.

### 6.3 Establishment discovery

The production backend uses Overpass API. It searches named OSM nodes, ways,
and relations with relevant tags, including cafes, restaurants, fast food,
markets, malls, supermarkets, coffee/tea shops, and selected lodging places.
For ways and relations, Overpass returns a center coordinate.

The backend tries multiple public Overpass mirrors and returns as soon as one
successful mirror answers. The request timeout is 35 seconds. The mobile app
also caches OSM results locally and refreshes stale coverage after 14 days,
with a 3 km buffer around the selected scope.

The backend stores fetched places in MongoDB using an upsert keyed by the OSM
identifier. The mobile app stores OSM place rows in the local Drift/SQLite
database.

### 6.4 Place identity and details

An OSM establishment receives a stable identifier based on its OSM element:

```text
osm-node-123456
osm-way-987654
osm-relation-555555
```

This identifier is used consistently as the backend `placeId`, the local
`Branches.id`/`branchId`, the report foreign key, and the forecast key. There is
no separate manually assigned branch number for a newly discovered OSM place.

The supported OSM values include:

- `name`
- `amenity`
- `shop`
- `cuisine`
- `brand`
- `operator`
- `opening_hours`
- `phone` and `contact:phone`
- `website` and `contact:website`
- `email` and `contact:email`
- `addr:housenumber`
- `addr:street`
- `addr:suburb`
- `addr:city`, `addr:town`, and `addr:municipality`
- `addr:postcode`
- `description`
- `wheelchair`
- `outdoor_seating`
- `internet_access`
- `delivery`
- `takeaway`
- `capacity`
- `contact:facebook`
- `contact:instagram`

The backend returns a readable `area` string and also returns the structured
address object. The Flutter place model carries the supported values through
the backend parser and local cache. Optional rows are hidden in the details UI
when OSM did not provide a value; the UI does not show a long list of empty
database fields.

### 6.5 Crowd reports

The report form asks how crowded a selected establishment is now:

| User level | Meaning | Internal index |
|---:|---|---:|
| 1 | Maluwag / Empty | 0.00 |
| 2 | Kaunti / Light | 0.25 |
| 3 | Katamtaman / Moderate | 0.50 |
| 4 | Mataong / Busy | 0.75 |
| 5 | Siksikan / Packed | 1.00 |

The local report contains an ID, the stable place ID, timestamp, crowd level,
optional note support in the data model, and a synchronization flag. The
current mobile form saves the report locally first. It then attempts to post it
to the backend. If the request fails, the local copy remains available for a
later synchronization pass.

The current backend accepts a report only when `placeId` exists and
`crowdLevel` is an integer from 1 through 5. Reports are stored in MongoDB's
`reports` collection. The backend currently has no login, user identity,
anti-spam limit, or moderation workflow.

### 6.6 Crowd forecast

The forecast screen shows:

- Current crowd percentage and crowd category.
- Whether the value is field data or a category estimate.
- Current recent-report influence, when reports exist.
- Next 24 hourly slots.
- Seven-day outlook.
- Quietest and busiest open periods.
- Nearby alternatives of the same category.
- Opening/closed state based on the parsed opening hours.

The forecast is calculated per place. It is not a claim that a business is
currently crowded unless recent reports are actually available.

### 6.7 Settings and branding

Settings currently include English/Filipino language, Dark/Light/System theme,
and 1 km/5 km/10 km scope. Settings are stored as `settings.json` in the app's
documents directory.

The app includes a branded Flutter splash screen, a GeoApp logo asset, and
Android adaptive launcher icon resources. The production mobile design is
packaged in the Flutter APK; Railway hosts the backend and does not deliver the
mobile UI itself.

## 7. System architecture

```text
                         +----------------------+
                         | OpenStreetMap tiles  |
                         +----------+-----------+
                                    |
+------------------+     HTTPS     v
| Flutter mobile   | <----------> +----------------------+
|                  |               | Node.js backend      |
| - Riverpod       |               | - HTTP controllers   |
| - flutter_map    |               | - Overpass proxy    |
| - Drift/SQLite   |               | - Mongo repositories |
| - forecast logic |               +-----+-----------+----+
+--------+---------+                     |           |
         |                               v           v
         |                        +----------+  +----------+
         |                        | Overpass |  | MongoDB  |
         |                        | API      |  |          |
         |                        +----------+  +----------+
         |
         +---- local place cache, reports, settings, forecast cache
```

### Mobile layer

- Flutter UI and navigation.
- Riverpod state providers.
- `geolocator` for GPS.
- `flutter_map` for map rendering.
- Drift/SQLite for local persistence.
- Pure Dart domain services for forecast, fusion, opening hours, and ranking.

### Backend layer

- Native Node.js HTTP server.
- Controllers for health, places, reports, and forecasts.
- Services for Overpass access, place handling, reports, and aggregation.
- MongoDB repositories for `places`, `reports`, and `forecasts`.

### External free data layer

- OpenStreetMap map tiles.
- OpenStreetMap/Overpass establishment data.

The source code still contains optional Google adapter classes for compatibility
with earlier development. Production configuration uses Overpass by default and
does not require a Google key. No Google, Mapbox, scraping, or paid place API is
required by the current free deployment.

## 8. End-to-end data flows

### 8.1 Nearby place flow

```text
GPS position + selected radius
  -> Flutter BackendPlacesClient
  -> GET /places/nearby
  -> backend placeService
  -> Overpass mirror
  -> OSM element parsing and category mapping
  -> MongoDB places upsert
  -> JSON response
  -> Flutter Place model
  -> local Drift cache and map/list UI
```

If the backend is unavailable, the mobile repository can use cached OSM rows
and may use an optional direct provider only when configured. A stale or failed
download does not automatically delete existing cached places.

### 8.2 User report flow

```text
User selects place and crowd level
  -> LiveReportsNotifier creates LiveReport
  -> local Drift UserReports row
  -> POST /reports when backend is reachable
  -> MongoDB reports collection
  -> recent report retrieval
  -> current forecast fusion
```

### 8.3 Historical forecast flow

```text
MongoDB reports
  -> hourly aggregation on backend startup and hourly interval
  -> group by placeId + local weekday + local hour
  -> skip groups below MIN_FORECAST_SAMPLES
  -> average crowd index
  -> MongoDB forecasts upsert
  -> GET /forecasts
  -> Flutter field baseline map
  -> next-24-hour and weekly calculations
  -> recommendation UI
```

The default minimum is five reports per place/weekday/hour. Groups below that
threshold do not become field forecasts. This prevents a single report from
being presented as a reliable historical pattern.

## 9. Forecast and recommendation logic

### 9.1 Baseline selection

For each place and time slot, the mobile app uses this order:

1. A matching backend/local field forecast for the same place, weekday, and
   hour, if available.
2. A category-and-time estimate from `estimateBaseline()` otherwise.

The category estimate has different curves for fast food, restaurants,
coffee shops, markets, malls, supermarkets, and general services. Places in the
same category can therefore share an estimate; this is intentional and is
clearly labeled as an estimate rather than historical place data.

### 9.2 Current crowd

The current slot uses the place's current weekday and hour. Recent reports from
the last two hours are filtered by the same stable place ID. Their influence
decays exponentially with a 45-minute half-life and is blended using an
effective alpha based on report age. With no reports, the baseline is unchanged.

### 9.3 Next 24 hours

The app builds 24 hourly slots beginning at the current hour. Each slot uses its
actual date and time, so the weekday changes correctly after midnight. It
calculates the crowd value for each slot, excludes closed slots from the best
time ranking, and selects the lowest calculated open slot.

### 9.4 Seven-day outlook

The app builds seven dates starting today. Each date evaluates the place's
open hours and the matching weekday/hour baseline. It exposes the quietest and
busiest open slots for each day.

### 9.5 Payday adjustment

The current forecast applies a 1.15 multiplier on the 15th, 30th, or last day
of the month. It is a simple product rule and not a learned holiday model.

### 9.6 Nearby alternatives

Alternatives must be the same category, open at the current hour, within 3 km,
and at least 0.10 crowd-index points quieter than the selected place. They are
sorted from quietest to busiest and limited to three results.

### 9.7 Data honesty

The recommendation is not randomized. If field data is unavailable, many places
in one category may look similar because they intentionally share the same
category estimate. Recommendations become genuinely place-specific only after
the system receives enough real reports for the relevant place/time groups.

## 10. Data storage

### 10.1 MongoDB collections

#### `places`

Stores OSM place objects returned by the backend, including ID, source, name,
area, category, latitude, longitude, OSM detail fields, structured address,
GeoJSON `location`, and timestamps.

Indexes currently include unique `id`, `category`, and a 2dsphere `location`
index.

#### `reports`

Stores crowd reports:

```json
{
  "id": "report-generated-id",
  "placeId": "osm-node-123456",
  "crowdLevel": 1,
  "reportedAt": "2026-09-17T10:00:00.000Z",
  "note": null,
  "createdAt": "2026-09-17T10:00:01.000Z"
}
```

Indexes include unique `id` and `{ placeId, reportedAt }`.

#### `forecasts`

Stores one historical row per place, ISO weekday, and hour:

```json
{
  "placeId": "osm-node-123456",
  "dayOfWeek": 4,
  "hour": 14,
  "crowdIndex": 0.42,
  "confidence": 0.3,
  "sampleCount": 5,
  "source": "field",
  "lastUpdated": "2026-09-17T10:00:00.000Z"
}
```

The unique key is `{ placeId, dayOfWeek, hour }`. This prevents forecast data
from different establishments being combined.

### 10.2 Local Drift/SQLite tables

The mobile database currently contains:

- `Branches`: cached places and OSM detail fields.
- `PlaceFetches`: downloaded coverage boxes and fetch timestamps.
- `Forecasts`: local field forecast rows and source metadata.
- `Observations`: field-observation records for local data workflows.
- `UserReports`: user reports waiting for synchronization or retained locally.

The database schema is version 5. Migrations add place-detail and forecast
metadata columns without deleting existing place data.

## 11. Backend API reference

Base production URL:

```text
https://geoapp-backend-production.up.railway.app
```

### `GET /health`

Checks backend and MongoDB initialization.

Example response:

```json
{
  "ok": true,
  "provider": "overpass",
  "mongodb": "geoapp"
}
```

### `GET /places/nearby`

Query parameters:

```text
lat=<latitude>&lng=<longitude>&radius=<meters>
```

Example:

```text
GET /places/nearby?lat=15.1473&lng=120.5880&radius=1000
```

Returns `{ "places": [...] }`. Invalid or missing latitude/longitude values
return HTTP 400. The endpoint queries Overpass, stores the result in MongoDB,
and returns the parsed place objects.

### `GET /reports`

Optional query parameter:

```text
since=2026-09-17T00:00:00Z
```

Returns `{ "reports": [...] }`, sorted newest first.

### `POST /reports`

Request body:

```json
{
  "placeId": "osm-node-123456",
  "crowdLevel": 3,
  "reportedAt": "2026-09-17T10:00:00Z"
}
```

`placeId` and integer `crowdLevel` from 1 to 5 are required. A valid request
returns HTTP 201 and the saved report.

### `GET /forecasts`

Optional query parameter:

```text
placeIds=osm-node-123456,osm-way-987654
```

Returns `{ "forecasts": [...] }` for the requested place IDs.

### `POST /forecasts`

Accepts `{ "forecasts": [...] }` and validates day-of-week, hour, place ID,
and crowd index before upserting rows. This endpoint is intended for controlled
data workflows; the normal historical pipeline is the report aggregator.

### `POST /forecasts/aggregate`

Runs the real-report aggregation immediately and returns the number of reports,
groups, and forecasts processed. The server also runs aggregation at startup
and every hour by default.

## 12. Deployment and operations

### Mobile

Development:

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
flutter run
```

Release APKs:

```powershell
flutter build apk --release --split-per-abi
```

The ARM64 APK is appropriate for the tested RMX3933 device. A split APK is
smaller than a universal APK because it contains one Android architecture.

### Backend

Local development:

```powershell
$env:MONGODB_URI="mongodb://127.0.0.1:27017"
$env:MONGODB_DB="geoapp"
node backend/server.js
```

Syntax verification:

```powershell
cd backend
npm run check
```

Production configuration uses environment variables. Database passwords and
API credentials must never be committed to Git or written in this document.

### Current production status

The backend is deployed on Railway as `geoapp-backend` and uses the production
MongoDB connection configured in Railway. The last verified health response
reported `ok: true`, provider `overpass`, and database `geoapp`.

## 13. Testing and verification

The repository includes tests for:

- App state and coverage.
- Opening-hours parsing.
- Crowd forecast and fusion logic.
- Baseline estimates.
- Place merging.
- Overpass client and OSM parser.
- Google parser compatibility.
- Domain services and widget behavior.

Recommended verification sequence:

1. Run `dart run build_runner build --delete-conflicting-outputs` after Drift
   schema changes.
2. Run `flutter test`.
3. Run `flutter analyze`.
4. Run `npm run check` inside `backend`.
5. Check `GET /health` after deployment.
6. Test place discovery at 1 km, 5 km, and 10 km.
7. Submit a report and confirm it appears locally and in MongoDB.
8. Confirm forecasts remain estimate-based until the real sample threshold is
   reached.

## 14. Security, privacy, and reliability considerations

### Current protections

- No crowd-report login identity is required.
- Local reports are retained if the network is unavailable.
- Database credentials are environment-managed rather than part of the app
  source.
- The backend limits request bodies to approximately 1 MB.
- MongoDB uses unique IDs and forecast compound keys to avoid duplicate rows.

### Current limitations to address before wide public release

- The report API currently has no authentication, rate limiting, or moderation.
- CORS is permissive (`*`) for the current prototype.
- The app does not verify that a report was made physically near the place.
- OSM/Overpass public mirrors can be slow, unavailable, or rate-limited.
- GPS accuracy depends on the phone and permission settings.
- Crowd data is anonymous and may contain inaccurate or malicious reports.

## 15. Known limitations of OSM and Overpass

- An establishment may be missing from OSM even if it appears in another map.
- A place can have a name but no address, phone, website, hours, or logo.
- OSM tags are community-maintained and may be outdated.
- `opening_hours` may contain complex weekday rules that the current parser
  cannot fully interpret; the app uses a best-effort first time range and then
  category defaults when parsing fails.
- OSM does not generally provide official establishment logos. The app's
  category artwork is only a fallback and must not be presented as the
  establishment's official logo.
- Overpass results depend on the selected radius and the tags used by mappers.
- Public Overpass services are not a guaranteed production SLA.

## 16. Current data availability and realistic expectations

At the time of the last backend deployment, the aggregation log showed zero
reports, zero grouped report windows, and zero generated field forecasts. This
means the app can discover OSM places and show category estimates, but it cannot
honestly generate unique historical recommendations for every establishment
until users submit enough real reports.

This behavior is intentional. The system must not create synthetic observations,
randomize recommendations, or copy crowd data between places merely to make the
UI look different.

## 17. Recommended future improvements

1. Add server-side validation that a reported place exists in the `places`
   collection.
2. Add rate limiting, abuse detection, and optional report moderation.
3. Add a privacy-preserving anonymous session/device token rather than storing
   personal identity.
4. Store timezone explicitly during aggregation instead of relying on the
   server's local timezone.
5. Replace the first-range opening-hours parser with a full OSM hours parser.
6. Add a data-quality dashboard showing reports and forecast coverage per place.
7. Add a controlled admin/import workflow for verified real field observations.
8. Add confidence and sample-count explanations directly to the forecast UI.
9. Add place-specific trend and recommendation evaluation tests.
10. Improve OSM logo/photo handling through openly licensed OSM-compatible data,
    while keeping the free architecture and attribution requirements intact.

## 18. Glossary

| Term | Meaning |
|---|---|
| OSM | OpenStreetMap, the community-maintained geographic database. |
| Overpass | Query API used to retrieve selected OSM elements. |
| Place ID | Stable identifier such as `osm-node-123456`. |
| Branch ID | Local database name for the same place identity; currently maps to `placeId`. |
| Crowd index | Normalized crowd value from 0.0 to 1.0. |
| Field data | Forecast baseline generated from enough real reports. |
| Estimate | Category/time curve used when field data is insufficient. |
| Fusion | Blending of a forecast with recent user reports. |
| Scope | User-selected search radius around the current location. |
| Drift | Flutter SQLite persistence library used for local data. |
| Railway | Hosting platform used for the deployed Node.js backend. |
