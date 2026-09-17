const { getDb } = require('../db/mongo');

async function saveMany(places) {
  if (places.length === 0) return;

  const db = await getDb();
  await db.collection('places').bulkWrite(
    places.map((place) => ({
      updateOne: {
        filter: { id: place.id },
        update: {
          $set: {
            ...place,
            location: {
              type: 'Point',
              coordinates: [place.lng, place.lat],
            },
            updatedAt: new Date(),
          },
          $setOnInsert: { createdAt: new Date() },
        },
        upsert: true,
      },
    })),
    { ordered: false },
  );
}

module.exports = { saveMany };
