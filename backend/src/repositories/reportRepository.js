const { getDb } = require('../db/mongo');

async function findSince(sinceIso) {
  const since = sinceIso ? Date.parse(sinceIso) : 0;
  const query = since ? { reportedAt: { $gte: new Date(since) } } : {};
  const rows = await (await getDb())
    .collection('reports')
    .find(query, { projection: { _id: 0 } })
    .sort({ reportedAt: -1 })
    .toArray();

  return rows.map((row) => ({
    ...row,
    reportedAt: row.reportedAt.toISOString(),
  }));
}

async function upsert(row) {
  const id =
    row.id || `report-${Date.now()}-${Math.random().toString(36).slice(2, 10)}`;
  const saved = {
    id,
    placeId: String(row.placeId),
    crowdLevel: row.crowdLevel,
    reportedAt: row.reportedAt ? new Date(row.reportedAt) : new Date(),
    note: row.note || null,
  };

  await (await getDb())
    .collection('reports')
    .updateOne(
      { id },
      { $set: saved, $setOnInsert: { createdAt: new Date() } },
      { upsert: true },
    );

  return { ...saved, reportedAt: saved.reportedAt.toISOString() };
}

module.exports = { findSince, upsert };
