const config = require('../config');

function query(lat, lng, radius) {
  const around = `around:${Math.round(radius)},${lat},${lng}`;
  return `[out:json][timeout:35];
(
  nwr["amenity"~"cafe|fast_food|restaurant|food_court|marketplace"]["name"](${around});
  nwr["shop"~"coffee|tea|mall|department_store|supermarket|convenience|grocery|greengrocer|general|variety_store"]["name"](${around});
  nwr["tourism"]["name"]["tourism"~"hotel|guest_house"](${around});
);
out center tags;`;
}

function osmCategory(tags) {
  const amenity = tags.amenity;
  const shop = tags.shop;
  const name = String(tags.name || '').toLowerCase();
  const cuisine = String(tags.cuisine || '').toLowerCase();
  const servesFood = ['fast_food', 'restaurant', 'cafe'].includes(amenity);
  const looksLikeCoffee =
    name.includes('coffee') ||
    name.includes('cafe') ||
    name.includes('café') ||
    name.includes('kape') ||
    name.includes('tea') ||
    name.includes('milktea') ||
    name.includes('milk tea') ||
    cuisine.includes('coffee') ||
    cuisine.includes('tea') ||
    cuisine.includes('bubble_tea') ||
    cuisine.includes('dessert');

  if (
    amenity === 'cafe' ||
    shop === 'coffee' ||
    shop === 'tea' ||
    (servesFood && looksLikeCoffee) ||
    looksLikeCoffee
  ) {
    return 'coffee';
  }
  if (amenity === 'fast_food') return 'fastFood';
  if (amenity === 'restaurant' || amenity === 'food_court') return 'kainan';
  if (amenity === 'marketplace') return 'palengke';
  if (shop === 'mall' || shop === 'department_store') return 'mall';
  if (
    [
      'supermarket',
      'convenience',
      'grocery',
      'greengrocer',
      'general',
      'variety_store',
    ].includes(shop)
  ) {
    return 'supermarket';
  }
  return 'services';
}

function area(tags) {
  const first = (keys) => {
    for (const key of keys) {
      const value = String(tags[key] || '').trim();
      if (value) return value;
    }
    return '';
  };
  return [
    first(['addr:housenumber']),
    first(['addr:street']),
    first(['addr:suburb', 'addr:village', 'addr:hamlet', 'addr:district']),
    first(['addr:city', 'addr:municipality', 'addr:town']),
  ]
    .filter(Boolean)
    .join(', ');
}

function parseElement(element) {
  const tags = element.tags || {};
  const name = String(tags.name || '').trim();
  const lat = element.lat ?? (element.center && element.center.lat);
  const lng = element.lon ?? (element.center && element.center.lon);
  if (!name || lat == null || lng == null) return null;

  return {
    id: `osm-${element.type}-${element.id}`,
    source: 'osm',
    name,
    area: area(tags),
    category: osmCategory(tags),
    lat,
    lng,
    brand: tags.brand || null,
    phone: tags.phone || tags['contact:phone'] || null,
    website: tags.website || tags['contact:website'] || null,
    operator: tags.operator || null,
    email: tags.email || tags['contact:email'] || null,
    cuisine: tags.cuisine || null,
    description: tags.description || null,
    wheelchair: tags.wheelchair || null,
    outdoorSeating: tags.outdoor_seating || null,
    internetAccess: tags.internet_access || null,
    delivery: tags.delivery || null,
    takeaway: tags.takeaway || null,
    capacity: tags.capacity || null,
    facebook: tags['contact:facebook'] || null,
    instagram: tags['contact:instagram'] || null,
    openingHours: tags.opening_hours || null,
    address: {
      housenumber: tags['addr:housenumber'] || null,
      street: tags['addr:street'] || null,
      city: tags['addr:city'] || tags['addr:town'] || tags['addr:municipality'] || null,
      postcode: tags['addr:postcode'] || null,
    },
  };
}

async function nearby(lat, lng, radius) {
  const body = query(lat, lng, radius);
  const attempts = config.overpassEndpoints.map(async (endpoint) => {
    const response = await fetch(endpoint, {
      method: 'POST',
      headers: {
        'content-type': 'application/x-www-form-urlencoded; charset=utf-8',
        'user-agent': 'GeoAppBackend/1.0',
      },
      body: `data=${encodeURIComponent(body)}`,
    });
    const payload = await response.text();
    if (!response.ok) throw new Error(`Overpass ${response.status}: ${payload}`);
    const json = JSON.parse(payload);
    return (json.elements || []).map(parseElement).filter(Boolean);
  });

  // Return as soon as one Overpass mirror answers. Waiting for every mirror
  // made nearby searches appear frozen when one public server was slow.
  try {
    return await Promise.any(attempts);
  } catch (error) {
    throw error?.errors?.[0] || error;
  }
}

module.exports = { nearby };
