const http = require('node:http');
const { URL } = require('node:url');

const config = require('./src/config');
const { closeDb } = require('./src/db/mongo');
const { sendJson } = require('./src/utils/http');
const healthController = require('./src/controllers/healthController');
const placesController = require('./src/controllers/placesController');
const reportsController = require('./src/controllers/reportsController');
const forecastsController = require('./src/controllers/forecastsController');

async function route(req, res) {
  const url = new URL(req.url, `http://${req.headers.host}`);

  if (url.pathname === '/health' && req.method === 'GET') {
    await healthController.show(req, res, url);
    return;
  }

  if (url.pathname === '/places/nearby' && req.method === 'GET') {
    await placesController.nearby(req, res, url);
    return;
  }

  if (url.pathname === '/reports' && req.method === 'GET') {
    await reportsController.index(req, res, url);
    return;
  }

  if (url.pathname === '/reports' && req.method === 'POST') {
    await reportsController.create(req, res, url);
    return;
  }

  if (url.pathname === '/forecasts' && req.method === 'GET') {
    await forecastsController.index(req, res, url);
    return;
  }

  if (url.pathname === '/forecasts' && req.method === 'POST') {
    await forecastsController.create(req, res, url);
    return;
  }

  if (url.pathname === '/forecasts/aggregate' && req.method === 'POST') {
    await forecastsController.aggregateNow(req, res, url);
    return;
  }

  sendJson(res, 404, { error: 'not found' });
}

const server = http.createServer(async (req, res) => {
  try {
    await route(req, res);
  } catch (error) {
    sendJson(res, 500, {
      error: String(error && error.message ? error.message : error),
    });
  }
});

server.listen(config.port, '0.0.0.0', () => {
  console.log(
    `GeoApp backend listening on http://0.0.0.0:${config.port} ` +
      `(${config.placesProvider}, mongodb=${config.mongoDbName})`,
  );
  const interval = Number(process.env.FORECAST_AGGREGATION_INTERVAL_MS || 3600000);
  const aggregation = require('./src/services/forecastAggregationService');
  aggregation.aggregate().catch((error) => console.error('[ForecastAggregation]', error));
  setInterval(() => aggregation.aggregate().catch((error) => console.error('[ForecastAggregation]', error)), interval);
});

async function shutdown() {
  await closeDb();
  process.exit(0);
}

process.on('SIGINT', shutdown);
process.on('SIGTERM', shutdown);
