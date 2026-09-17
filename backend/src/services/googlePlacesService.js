const config = require('../config');

const categories = {
  fastFood: ['fast_food_restaurant', 'hamburger_restaurant'],
  kainan: ['restaurant', 'filipino_restaurant', 'food_court'],
  coffee: ['cafe', 'coffee_shop', 'tea_house'],
  palengke: ['market'],
  mall: ['shopping_mall'],
  supermarket: ['supermarket', 'grocery_store'],
};

const fieldMask = [
  'places.id',
  'places.displayName',
  'places.location',
  'places.primaryType',
  'places.types',
  'places.shortFormattedAddress',
  'places.photos',
  'places.regularOpeningHours',
  'places.businessStatus',
].join(',');

function categoryFor(primaryType, types, requested) {
  for (const [category, googleTypes] of Object.entries(categories)) {
    if (googleTypes.includes(primaryType)) return category;
  }
  if (types.includes('fast_food_restaurant')) return 'fastFood';
  return requested;
}

function hoursFrom(regularOpeningHours) {
  const periods = regularOpeningHours && regularOpeningHours.periods;
  if (!Array.isArray(periods) || periods.length === 0) return null;
  if (periods.length === 1 && !periods[0].close) return { open: 0, close: 24 };

  const counts = new Map();
  for (const period of periods) {
    if (!period.open || !period.close) continue;
    const open = Number(period.open.hour || 0);
    let close = Number(period.close.hour || 0);
    const closeMinute = Number(period.close.minute || 0);
    if (closeMinute > 0) close += 1;
    if (close === 0 || close === 24) close = 24;
    if (close > 24) close -= 24;
    const key = `${open}:${close}`;
    counts.set(key, (counts.get(key) || 0) + 1);
  }

  let best = null;
  for (const [key, count] of counts.entries()) {
    if (!best || count > best.count) best = { key, count };
  }
  if (!best) return null;
  const [open, close] = best.key.split(':').map(Number);
  return { open, close };
}

function parsePlace(place, requested) {
  const id = place.id;
  const name = place.displayName && String(place.displayName.text || '').trim();
  const lat = place.location && place.location.latitude;
  const lng = place.location && place.location.longitude;
  if (!id || !name || lat == null || lng == null) return null;
  if (
    place.businessStatus === 'CLOSED_PERMANENTLY' ||
    place.businessStatus === 'CLOSED_TEMPORARILY'
  ) {
    return null;
  }

  const photo = Array.isArray(place.photos) ? place.photos[0] : null;
  const author = photo && Array.isArray(photo.authorAttributions)
    ? photo.authorAttributions[0]
    : null;
  const types = Array.isArray(place.types) ? place.types : [];

  return {
    id: `g-${id}`,
    source: 'google',
    name,
    area: place.shortFormattedAddress || '',
    category: categoryFor(place.primaryType, types, requested),
    lat,
    lng,
    hours: hoursFrom(place.regularOpeningHours),
    photoName: photo && photo.name,
    photoAuthor: author && author.displayName,
  };
}

async function searchCategory(category, lat, lng, radius) {
  const response = await fetch(
    'https://places.googleapis.com/v1/places:searchNearby',
    {
      method: 'POST',
      headers: {
        'content-type': 'application/json',
        'x-goog-api-key': config.googleApiKey,
        'x-goog-fieldmask': fieldMask,
      },
      body: JSON.stringify({
        includedTypes: categories[category],
        maxResultCount: 20,
        rankPreference: 'DISTANCE',
        locationRestriction: {
          circle: {
            center: { latitude: lat, longitude: lng },
            radius: Math.max(1, Math.min(50000, radius)),
          },
        },
      }),
    },
  );
  const body = await response.text();
  if (!response.ok) throw new Error(`Google ${response.status}: ${body}`);
  const json = JSON.parse(body);
  return (json.places || [])
    .map((place) => parsePlace(place, category))
    .filter(Boolean);
}

async function nearby(lat, lng, radius) {
  const batches = await Promise.allSettled(
    Object.keys(categories).map((category) =>
      searchCategory(category, lat, lng, radius),
    ),
  );
  const byId = new Map();
  for (const batch of batches) {
    if (batch.status !== 'fulfilled') continue;
    for (const place of batch.value) {
      if (!byId.has(place.id)) byId.set(place.id, place);
    }
  }
  if (byId.size === 0) {
    const failure = batches.find((batch) => batch.status === 'rejected');
    if (failure) throw failure.reason;
  }
  return [...byId.values()];
}

module.exports = { nearby };
