import 'package:flutter/material.dart';

import '../../domain/crowd_level.dart';

/// Minimalist claymorphism palette, one for dark and one for light.
///
/// `final clay = ClayPalette.of(context);`
@immutable
class ClayPalette extends ThemeExtension<ClayPalette> {
  const ClayPalette._({
    required this.brightness,
    required this.background,
    required this.surface,
    required this.ink,
    required this.muted,
    required this.line,
    required this.accent,
    required this.accentSoft,
    required this.onAccent,
    required this.dropShadow,
    required this.dropShadowAlpha,
    required this.rimLight,
    required this.innerLight,
    required this.innerShade,
    required List<Color> crowdSurfaces,
    required List<Color> crowdInks,
    required this.closedSurface,
    required this.closedAccent,
    required this.closedInk,
  }) : _crowdSurfaces = crowdSurfaces,
       _crowdInks = crowdInks;

  static const dark = ClayPalette._(
    brightness: Brightness.dark,
    background: Color(0xFF171923),
    surface: Color(0xFF242735),
    ink: Color(0xFFF2F3F8),
    muted: Color(0xFF9399AE),
    line: Color(0xFF32364A),
    accent: Color(0xFF8B7CFF),
    accentSoft: Color(0xFF2F2A58),
    onAccent: Colors.white,
    dropShadow: Colors.black,
    dropShadowAlpha: 0.55,
    rimLight: Color(0x0DFFFFFF),
    innerLight: 0.08,
    innerShade: 0.35,
    crowdSurfaces: [
      Color(0xFF173A2E),
      Color(0xFF172F4A),
      Color(0xFF3B3113),
      Color(0xFF43261A),
      Color(0xFF44192A),
    ],
    crowdInks: [
      Color(0xFF7EE8B9),
      Color(0xFF8CC4FF),
      Color(0xFFFFD66B),
      Color(0xFFFFB38A),
      Color(0xFFFF9AAE),
    ],
    closedSurface: Color(0xFF2A2D3A),
    closedAccent: Color(0xFF5C6175),
    closedInk: Color(0xFFA5AABB),
  );

  static const light = ClayPalette._(
    brightness: Brightness.light,
    background: Color(0xFFF2F3F8),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1F2233),
    muted: Color(0xFF8A90A6),
    line: Color(0xFFE6E8F0),
    accent: Color(0xFF6D5DFC),
    accentSoft: Color(0xFFE9E6FF),
    onAccent: Colors.white,
    dropShadow: Color(0xFF5A5F85),
    dropShadowAlpha: 0.22,
    rimLight: Color(0xE6FFFFFF),
    innerLight: 0.8,
    innerShade: 0.08,
    crowdSurfaces: [
      Color(0xFFC8F3DF),
      Color(0xFFD2E9FF),
      Color(0xFFFFEDB5),
      Color(0xFFFFDCC7),
      Color(0xFFFFD3DA),
    ],
    crowdInks: [
      Color(0xFF11684A),
      Color(0xFF1A5690),
      Color(0xFF7A5700),
      Color(0xFF9A4214),
      Color(0xFFA01F3C),
    ],
    closedSurface: Color(0xFFE6E8F0),
    closedAccent: Color(0xFFB4BACB),
    closedInk: Color(0xFF5F6578),
  );

  static ClayPalette of(BuildContext context) =>
      Theme.of(context).extension<ClayPalette>() ?? light;

  final Brightness brightness;
  final Color background;
  final Color surface;
  final Color ink;
  final Color muted;
  final Color line;
  final Color accent;
  final Color accentSoft;
  final Color onAccent;
  final Color dropShadow;
  final double dropShadowAlpha;

  /// Soft glow on the top-left outside edge.
  final Color rimLight;

  /// Opacity of the inner top-left highlight / bottom-right shade.
  final double innerLight;
  final double innerShade;

  final List<Color> _crowdSurfaces;
  final List<Color> _crowdInks;
  final Color closedSurface;
  final Color closedAccent;
  final Color closedInk;

  bool get isDark => brightness == Brightness.dark;

  static const _crowdAccents = [
    Color(0xFF34C38F),
    Color(0xFF4C9DF5),
    Color(0xFFF2B93B),
    Color(0xFFFF8A50),
    Color(0xFFFF5C7A),
  ];

  /// Tinted card fill for a crowd level.
  Color crowdSurface(CrowdLevel level) => _crowdSurfaces[level.index];

  /// Bright color for bars, dots and icon blobs (same in both themes).
  Color crowdAccent(CrowdLevel level) => _crowdAccents[level.index];

  /// Readable text on [crowdSurface].
  Color crowdInk(CrowdLevel level) => _crowdInks[level.index];

  Color surfaceFor(bool isOpen, CrowdLevel level) =>
      isOpen ? crowdSurface(level) : closedSurface;

  Color accentFor(bool isOpen, CrowdLevel level) =>
      isOpen ? crowdAccent(level) : closedAccent;

  Color inkFor(bool isOpen, CrowdLevel level) =>
      isOpen ? crowdInk(level) : closedInk;

  @override
  ClayPalette copyWith() => this;

  @override
  ClayPalette lerp(ClayPalette? other, double t) =>
      other == null || t < 0.5 ? this : other;
}

/// Puffy clay surface: soft drop shadow + inner highlight (top-left) and
/// inner shade (bottom-right). Squishes when tapped.
class ClayBox extends StatefulWidget {
  const ClayBox({
    super.key,
    required this.child,
    this.color,
    this.radius = 28,
    this.padding = const EdgeInsets.all(18),
    this.depth = 1,
    this.width,
    this.height,
    this.onTap,
    this.clip = false,
  });

  final Widget child;

  /// Defaults to the palette surface.
  final Color? color;
  final double radius;
  final EdgeInsetsGeometry padding;

  /// Shadow strength, 0.3 (flat chip) … 1 (floating card).
  final double depth;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  /// Clip the child to the rounded shape (for photos).
  final bool clip;

  @override
  State<ClayBox> createState() => _ClayBoxState();
}

class _ClayBoxState extends State<ClayBox> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null || _pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final color = widget.color ?? clay.surface;
    final depth = widget.depth * (_pressed ? 0.4 : 1);
    final radius = BorderRadius.circular(widget.radius);

    Widget content = Padding(padding: widget.padding, child: widget.child);
    if (widget.clip) {
      content = ClipRRect(borderRadius: radius, child: content);
    }

    final box = AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: clay.dropShadow.withValues(alpha: clay.dropShadowAlpha),
            offset: Offset(0, 12 * depth),
            blurRadius: 28 * depth,
            spreadRadius: -6,
          ),
          BoxShadow(
            color: clay.rimLight,
            offset: Offset(-4 * depth, -4 * depth),
            blurRadius: 12 * depth,
          ),
        ],
      ),
      child: CustomPaint(
        foregroundPainter: widget.clip
            ? _InnerClayPainter(
                radius: widget.radius,
                color: color,
                light: clay.innerLight * 0.4,
                shade: clay.innerShade,
                pressed: _pressed,
              )
            : null,
        painter: widget.clip
            ? null
            : _InnerClayPainter(
                radius: widget.radius,
                color: color,
                light: clay.innerLight,
                shade: clay.innerShade,
                pressed: _pressed,
              ),
        child: content,
      ),
    );

    if (widget.onTap == null) return box;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 140),
        child: box,
      ),
    );
  }
}

class _InnerClayPainter extends CustomPainter {
  const _InnerClayPainter({
    required this.radius,
    required this.color,
    required this.light,
    required this.shade,
    required this.pressed,
  });

  final double radius;
  final Color color;
  final double light;
  final double shade;
  final bool pressed;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    // Light fills (pastel chips on a dark theme) still want a strong glint.
    final glint = color.computeLuminance() > 0.5 ? 0.75 : light;

    canvas.save();
    canvas.clipRRect(rrect);

    // Frame around a shifted hole → blurred glow along the opposite edges.
    void innerShadow(Color tone, Offset shift, double blur) {
      final path = Path()
        ..fillType = PathFillType.evenOdd
        ..addRect(rect.inflate(blur * 3))
        ..addRRect(rrect.shift(shift));
      canvas.drawPath(
        path,
        Paint()
          ..color = tone
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur),
      );
    }

    innerShadow(
      Colors.white.withValues(alpha: glint * (pressed ? 0.5 : 1)),
      const Offset(4, 5),
      6,
    );
    innerShadow(
      Colors.black.withValues(alpha: shade * (pressed ? 1.6 : 1)),
      const Offset(-4, -6),
      8,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(_InnerClayPainter old) =>
      old.radius != radius ||
      old.color != color ||
      old.pressed != pressed ||
      old.light != light ||
      old.shade != shade;
}

/// Plain title above a clay card — keeps sections minimal.
class ClaySection extends StatelessWidget {
  const ClaySection({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.padding = const EdgeInsets.all(18),
  });

  final String title;
  final Widget child;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6, right: 6, bottom: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: clay.ink,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
        ),
        ClayBox(padding: padding, child: child),
      ],
    );
  }
}

class ClayChip extends StatelessWidget {
  const ClayChip({
    super.key,
    required this.label,
    this.icon,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final foreground = selected ? clay.onAccent : clay.ink;

    return ClayBox(
      radius: 999,
      depth: 0.55,
      color: selected ? clay.accent : clay.surface,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: foreground),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}

class ClayIconButton extends StatelessWidget {
  const ClayIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.tooltip,
    this.size = 48,
    this.color,
    this.iconColor,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;
  final double size;
  final Color? color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final button = ClayBox(
      width: size,
      height: size,
      radius: 999,
      depth: 0.7,
      color: color,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Center(
        child: Icon(icon, size: size * 0.46, color: iconColor ?? clay.ink),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip, child: button);
  }
}

/// Big primary action (report, post).
class ClayButton extends StatelessWidget {
  const ClayButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final enabled = onTap != null;
    final foreground = enabled ? clay.onAccent : clay.muted;

    return ClayBox(
      color: enabled ? clay.accent : clay.line,
      radius: 22,
      depth: enabled ? 0.8 : 0.3,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: foreground),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
