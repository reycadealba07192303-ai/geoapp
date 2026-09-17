import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/crowd_style.dart';
import '../../domain/place.dart';
import '../app_state.dart';

/// Google photo of the place (with author credit), or a category
/// illustration when there is no photo / no internet.
///
/// Photos are only held in Flutter's in-memory image cache — Google's terms
/// don't allow storing them.
class PlacePhoto extends ConsumerWidget {
  const PlacePhoto({
    super.key,
    required this.place,
    required this.height,
    this.width,
    this.radius = 28,
    this.showCredit = true,
  });

  final Place place;
  final double height;
  final double? width;
  final double radius;
  final bool showCredit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final google = ref.watch(googlePlacesClientProvider);
    final photoName = place.photoName;
    final pixelWidth =
        ((width ?? MediaQuery.sizeOf(context).width) *
                MediaQuery.devicePixelRatioOf(context))
            .round()
            .clamp(64, 1600);

    final illustration = _Illustration(
      category: place.category,
      compact: height < 90,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: photoName == null || !google.isConfigured
            ? illustration
            : Stack(
                fit: StackFit.expand,
                children: [
                  illustration,
                  Image.network(
                    google.photoUrl(photoName, maxWidthPx: pixelWidth),
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                    frameBuilder: (context, child, frame, _) => AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(milliseconds: 250),
                      child: child,
                    ),
                    errorBuilder: (_, _, _) => illustration,
                  ),
                  if (showCredit && place.photoAuthor != null)
                    Positioned(
                      left: 10,
                      bottom: 10,
                      right: 10,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            '📷 ${place.photoAuthor}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

class _Illustration extends StatelessWidget {
  const _Illustration({required this.category, required this.compact});

  final PlaceCategory category;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = CrowdStyle.categoryGradient(category);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, box) {
          final size = box.biggest.shortestSide;
          return Stack(
            children: [
              // Soft clay bubbles.
              Positioned(
                right: -size * 0.15,
                top: -size * 0.2,
                child: _Bubble(size: size * 0.8),
              ),
              Positioned(
                left: -size * 0.1,
                bottom: -size * 0.3,
                child: _Bubble(size: size * 0.6),
              ),
              Center(
                child: Container(
                  width: compact ? size * 0.34 : size * 0.28,
                  height: compact ? size * 0.34 : size * 0.28,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.28),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    CrowdStyle.categoryIcon(category),
                    size: compact ? size * 0.16 : size * 0.13,
                    color: Colors.white.withValues(alpha: 0.82),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.14),
      ),
    );
  }
}

/// Google Maps text attribution for Places data shown without a Google map.
class GoogleMapsAttribution extends StatelessWidget {
  const GoogleMapsAttribution({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Google Maps',
      style: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: color,
      ),
    );
  }
}
