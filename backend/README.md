# GeoApp Backend

Layered Node backend using native HTTP + MongoDB.

## Layers

- `server.js` - HTTP entrypoint and routing only
- `src/config` - environment variables
- `src/db` - MongoDB connection and indexes
- `src/repositories` - MongoDB collection access
- `src/services` - business logic and external APIs
- `src/controllers` - request validation and responses
- `src/utils` - shared HTTP helpers

## Run

Create `backend/.env` from `.env.example`, then:

```bash
node server.js
```

## Endpoints

- `GET /health`
- `GET /places/nearby?lat=15.1&lng=120.5&radius=10000`
- `GET /reports?since=2026-09-17T00:00:00Z`
- `POST /reports`
- `GET /forecasts?placeIds=osm-node-1,osm-way-2`
- `POST /forecasts`

## Forecast Data Flow

Forecasts are made from two backend-backed data streams:

- `forecasts` collection: historical baseline per place, weekday and hour.
- `reports` collection: live crowd reports, fetched by mobile every 30 seconds
  and fused into the current forecast.

Mobile refreshes forecast baselines every 5 minutes while open. Recent reports
are the near-real-time layer.
