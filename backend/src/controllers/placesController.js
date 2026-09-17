const placeService = require('../services/placeService');
const { sendJson } = require('../utils/http');

async function nearby(_req, res, url) {
  const lat = Number(url.searchParams.get('lat'));
  const lng = Number(url.searchParams.get('lng'));
  const radius = Number(url.searchParams.get('radius') || 10000);
  if (!Number.isFinite(lat) || !Number.isFinite(lng)) {
    sendJson(res, 400, { error: 'lat and lng are required numbers' });
    return;
  }

  const places = await placeService.nearby({ lat, lng, radius });
  sendJson(res, 200, { places });
}

module.exports = { nearby };
