const reportRepository = require('../repositories/reportRepository');

function validateReport(row) {
  if (!row.placeId || !Number.isInteger(row.crowdLevel)) {
    throw new Error('placeId and integer crowdLevel are required');
  }
  if (row.crowdLevel < 1 || row.crowdLevel > 5) {
    throw new Error('crowdLevel must be 1..5');
  }
}

async function listSince(since) {
  return reportRepository.findSince(since);
}

async function create(row) {
  validateReport(row);
  return reportRepository.upsert(row);
}

module.exports = { listSince, create };
