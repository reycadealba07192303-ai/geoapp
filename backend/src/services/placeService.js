const config = require('../config');
const googlePlaces = require('./googlePlacesService');
const overpass = require('./overpassService');
const placeRepository = require('../repositories/placeRepository');

async function nearby({ lat, lng, radius }) {
  const places =
    config.placesProvider === 'google' && config.googleApiKey
      ? await googlePlaces.nearby(lat, lng, radius)
      : await overpass.nearby(lat, lng, radius);
  await placeRepository.saveMany(places);
  return places;
}

module.exports = { nearby };
