import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database/app_database.dart';
import 'location/location_service.dart';
import '../domain/forecast_service.dart';
import '../domain/fusion_service.dart';
import '../domain/recommendation_service.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final forecastServiceProvider = Provider<ForecastService>((ref) {
  return ForecastService();
});

final fusionServiceProvider = Provider<FusionService>((ref) {
  return FusionService();
});

final recommendationServiceProvider = Provider<RecommendationService>((ref) {
  return RecommendationService();
});
