const config = require('../config');
const { getDb } = require('../db/mongo');
const { sendJson } = require('../utils/http');

async function show(_req, res) {
  await getDb();
  sendJson(res, 200, {
    ok: true,
    provider: config.placesProvider,
    mongodb: config.mongoDbName,
  });
}

module.exports = { show };
