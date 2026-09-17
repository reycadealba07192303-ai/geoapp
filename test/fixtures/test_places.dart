import 'package:geoapp/domain/place.dart';

/// Fixed places around Angeles City for tests (no network / database).
const testPlaces = <Place>[
  Place(
    id: 'osm-node-1',
    name: 'Puregold Angeles',
    area: 'Sto. Domingo, Angeles',
    category: PlaceCategory.supermarket,
    lat: 15.1440,
    lng: 120.5870,
  ),
  Place(
    id: 'osm-way-2',
    name: 'SM City Clark',
    area: 'Malabanias, Angeles',
    category: PlaceCategory.mall,
    lat: 15.1696,
    lng: 120.5800,
  ),
  Place(
    id: 'osm-node-3',
    name: 'Jollibee Sto. Rosario',
    area: 'Sto. Rosario, Angeles',
    category: PlaceCategory.fastFood,
    lat: 15.1385,
    lng: 120.5902,
    brand: 'Jollibee',
    openingHours: '24/7',
    hours: (open: 0, close: 24),
  ),
  Place(
    id: 'osm-node-4',
    name: 'Starbucks Marquee',
    area: 'Pulung Maragul, Angeles',
    category: PlaceCategory.coffee,
    lat: 15.1624,
    lng: 120.5891,
    brand: 'Starbucks',
  ),
  Place(
    id: 'osm-way-5',
    name: 'Pampang Public Market',
    area: 'Pampang, Angeles',
    category: PlaceCategory.palengke,
    lat: 15.1473,
    lng: 120.5747,
  ),
];
