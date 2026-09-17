const forecastRepository = require('../repositories/forecastRepository');

function normalizeRows(rows) {
  const valid = [];
  for (const row of rows) {
    if (!row.placeId) continue;
    const saved = {
      placeId: String(row.placeId),
      dayOfWeek: Number(row.dayOfWeek),
      hour: Number(row.hour),
      crowdIndex: Number(row.crowdIndex),
      confidence: row.confidence == null ? 0.5 : Number(row.confidence),
    };
    if (
      saved.dayOfWeek < 1 ||
      saved.dayOfWeek > 7 ||
      saved.hour < 0 ||
      saved.hour > 23 ||
      !Number.isFinite(saved.crowdIndex)
    ) {
      continue;
    }
    valid.push(saved);
  }
  return valid;
}

async function list(placeIds) {
  return forecastRepository.findForPlaceIds(placeIds);
}

async function save(rows) {
  return forecastRepository.upsertMany(normalizeRows(rows));
}

module.exports = { list, save };
