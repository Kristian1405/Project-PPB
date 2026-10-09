import 'package:flutter/material.dart';

import '../theme.dart';

/// Kartu putih standar dengan radius 12 dan bayangan desain.
class SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double gap;
  final List<BoxShadow>? shadow;

  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.gap = 0,
    this.shadow = shadowCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: C.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: shadow,
      ),
      padding: padding,
      child: gap == 0
          ? child
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [child],
            ),
    );
  }
}

/// Kartu putih dengan column + jarak [gap] antar anak.
class SectionCardColumn extends StatelessWidget {
  final List<Widget> children;
  final double gap;
  final EdgeInsetsGeometry padding;

  const SectionCardColumn({
    super.key,
    required this.children,
    this.gap = 12,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: C.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: shadowCard,
      ),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(height: gap),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// Lingkaran ikon kecil.
class RoundIcon extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final Color fg;
  final double size;
  final double iconSize;

  const RoundIcon({
    super.key,
    required this.icon,
    required this.bg,
    required this.fg,
    this.size = 40,
    this.iconSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Icon(icon, color: fg, size: iconSize),
    );
  }
}

/// Empat tanda sudut putih pada pratinjau kamera.
class CornerBrackets extends StatelessWidget {
  const CornerBrackets({super.key, this.length = 14});

  final double length;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _BracketsPainter(length), size: Size.zero);
  }
}

class _BracketsPainter extends CustomPainter {
  _BracketsPainter(this.length);

  final double length;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final w = size.width;
    final h = size.height;
    const d = 16.0; // jarak dari tepi
    final r = length;
    final p = Path()
      ..moveTo(d, d + r)
      ..lineTo(d, d)
      ..lineTo(d + r, d)
      ..moveTo(w - d - r, d)
      ..lineTo(w - d, d)
      ..lineTo(w - d, d + r)
      ..moveTo(d, h - d - r)
      ..lineTo(d, h - d)
      ..lineTo(d + r, h - d)
      ..moveTo(w - d - r, h - d)
      ..lineTo(w - d, h - d)
      ..lineTo(w - d, h - d - r);
    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(covariant _BracketsPainter old) => old.length != length;
}

/// Pill status pada kartu laporan.
class StatusPill extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final Color fg;

  /// Warna ikon; default sama dengan [fg].
  final Color? iconColor;
  final String label;
  final double fontSize;

  const StatusPill({
    super.key,
    required this.icon,
    required this.bg,
    required this.fg,
    this.iconColor,
    required this.label,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(9999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? fg, size: 17),
          const SizedBox(width: 6),
          Text(label, style: ty(fontSize, 700, color: fg, ls: 0.16, lh: 22 / fontSize)),
        ],
      ),
    );
  }
}