const { MongoClient } = require('mongodb');
const config = require('../config');

const client = new MongoClient(config.mongoUri);
let db;

async function getDb() {
  if (db) return db;

  await client.connect();
  db = client.db(config.mongoDbName);
  await Promise.all([
    db.collection('places').createIndex({ id: 1 }, { unique: true }),
    db.collection('places').createIndex({ category: 1 }),
    db.collection('places').createIndex({ location: '2dsphere' }),
    db.collection('reports').createIndex({ placeId: 1, reportedAt: -1 }),
    db.collection('reports').createIndex({ id: 1 }, { unique: true }),
    db.collection('forecasts').createIndex(
      { placeId: 1, dayOfWeek: 1, hour: 1 },
      { unique: true },
    ),
  ]);

  return db;
}

async function closeDb() {
  await client.close();
  db = null;
}

module.exports = { getDb, closeDb };
