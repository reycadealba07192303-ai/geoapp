const reportService = require('../services/reportService');
const { bodyJson, sendJson } = require('../utils/http');

async function index(_req, res, url) {
  const reports = await reportService.listSince(url.searchParams.get('since'));
  sendJson(res, 200, { reports });
}

async function create(req, res) {
  const report = await reportService.create(await bodyJson(req));
  sendJson(res, 201, { report });
}

module.exports = { index, create };
