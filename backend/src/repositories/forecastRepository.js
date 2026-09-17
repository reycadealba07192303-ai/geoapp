const { getDb } = require('../db/mongo');

async function findForPlaceIds(placeIds) {
  const wanted = new Set(placeIds.filter(Boolean));
  const query = wanted.size === 0 ? {} : { placeId: { $in: [...wanted] } };
  return (await getDb())
    .collection('forecasts')
    .find(query, { projection: { _id: 0 } })
    .sort({ placeId: 1, dayOfWeek: 1, hour: 1 })
    .toArray();
}

async function upsertMany(rows) {
  if (rows.length > 0) {
    await (await getDb()).collection('forecasts').bulkWrite(
      rows.map((row) => ({
        updateOne: {
          filter: {
            placeId: row.placeId,
            dayOfWeek: row.dayOfWeek,
            hour: row.hour,
          },
          update: {
            $set: { ...row, updatedAt: new Date() },
            $setOnInsert: { createdAt: new Date() },
          },
          upsert: true,
        },
      })),
      { ordered: false },
    );
  }

  return findForPlaceIds([...new Set(rows.map((row) => row.placeId))]);
}

module.exports = { findForPlaceIds, upsertMany };
