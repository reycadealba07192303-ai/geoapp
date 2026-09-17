require('dotenv').config();

const googleApiKey = process.env.GOOGLE_MAPS_API_KEY || '';

module.exports = {
  port: Number(process.env.PORT || 8000),
  googleApiKey,
  placesProvider:
    process.env.PLACES_PROVIDER || (googleApiKey ? 'google' : 'overpass'),
  mongoUri: process.env.MONGODB_URI || 'mongodb://127.0.0.1:27017',
  mongoDbName: process.env.MONGODB_DB || 'geoapp',
  overpassEndpoints: [
    'https://overpass.kumi.systems/api/interpreter',
    'https://overpass.private.coffee/api/interpreter',
    'https://overpass-api.de/api/interpreter',
  ],
};
