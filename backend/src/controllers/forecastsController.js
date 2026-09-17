const forecastService = require('../services/forecastService');
const aggregation = require('../services/forecastAggregationService');
const { bodyJson, sendJson } = require('../utils/http');

async function index(_req, res, url) {
  const placeIds = (url.searchParams.get('placeIds') || '')
    .split(',')
    .map((s) => s.trim())
    .filter(Boolean);
  const forecasts = await forecastService.list(placeIds);
  sendJson(res, 200, { forecasts });
}

async function create(req, res) {
  const body = await bodyJson(req);
  const rows = Array.isArray(body.forecasts) ? body.forecasts : [];
  const forecasts = await forecastService.save(rows);
  sendJson(res, 201, { forecasts });
}

async function aggregateNow(_req, res) {
  const result = await aggregation.aggregate();
  sendJson(res, 200, result);
}

module.exports = { index, create, aggregateNow };
