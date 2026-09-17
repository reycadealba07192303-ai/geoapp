const { getDb } = require('../db/mongo');
const forecastRepository = require('../repositories/forecastRepository');

const MIN_SAMPLES = Number(process.env.MIN_FORECAST_SAMPLES || 5);
const LOW_MAX = Number(process.env.LOW_CONFIDENCE_MAX || 14);
const MEDIUM_MAX = Number(process.env.MEDIUM_CONFIDENCE_MAX || 29);

// Keep this conversion identical to Flutter's crowd-level scale.
function crowdLevelToIndex(level) {
  return [0, 0.1, 0.3, 0.5, 0.72, 0.92][level] ?? null;
}

function confidenceFor(count) {
  if (count >= 30) return 0.9;
  if (count > LOW_MAX && count <= MEDIUM_MAX) return 0.6;
  return 0.3;
}

async function aggregate() {
  const reports = await (await getDb()).collection('reports').find({}).toArray();
  const groups = new Map();
  for (const report of reports) {
    const index = crowdLevelToIndex(Number(report.crowdLevel));
    const date = new Date(report.reportedAt);
    if (!report.placeId || index == null || Number.isNaN(date.getTime())) continue;
    const key = `${report.placeId}|${date.getDay() || 7}|${date.getHours()}`;
    const group = groups.get(key) || {
      placeId: String(report.placeId), dayOfWeek: date.getDay() || 7,
      hour: date.getHours(), indexes: [], lastUpdated: date,
    };
    group.indexes.push(index);
    if (date > group.lastUpdated) group.lastUpdated = date;
    groups.set(key, group);
  }

  const rows = [];
  for (const group of groups.values()) {
    const sampleCount = group.indexes.length;
    if (sampleCount < MIN_SAMPLES) {
      console.log(`[ForecastAggregation] Skipping field forecast: placeId=${group.placeId} day=${group.dayOfWeek} hour=${group.hour} samples=${sampleCount} minimum=${MIN_SAMPLES}`);
      continue;
    }
    const crowdIndex = group.indexes.reduce((sum, value) => sum + value, 0) / sampleCount;
    rows.push({
      placeId: group.placeId, dayOfWeek: group.dayOfWeek, hour: group.hour,
      crowdIndex, confidence: confidenceFor(sampleCount), sampleCount,
      source: 'field', lastUpdated: group.lastUpdated,
    });
    console.log(`[ForecastAggregation] Forecast upserted: placeId=${group.placeId} hour=${group.hour} crowdIndex=${crowdIndex.toFixed(3)} samples=${sampleCount}`);
  }
  await forecastRepository.upsertMany(rows);
  console.log(`[ForecastAggregation] Reports found: ${reports.length}; groups=${groups.size}; forecasts=${rows.length}`);
  return { reports: reports.length, groups: groups.size, forecasts: rows.length };
}

module.exports = { aggregate, MIN_SAMPLES };
