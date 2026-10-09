import 'package:flutter/material.dart';

import '../theme.dart';

/// Header brand CleanReport (logo + nama + subtitle + pill Bantuan).
class BrandHeader extends StatelessWidget {
  final String subtitle;

  /// Pill Bantuan yang lebih kecil (dipakai layar Foto & Lapor).
  final bool compact;

  const BrandHeader({super.key, required this.subtitle, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(color: C.bg, boxShadow: shadowHeader),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', width: 32, height: 32),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('CleanReport', style: ty(22, 700, color: C.green, lh: 27.5 / 22)),
              Text(
                subtitle,
                style: ty(16, 500, color: C.slate, ls: 0.16, lh: 16 / 16),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 12, vertical: 10),
            decoration: BoxDecoration(
              color: C.greenLight,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.support_agent, color: C.greenDark, size: 18),
                const SizedBox(width: 4),
                Text(
                  'Bantuan',
                  style: ty(compact ? 12 : 14, 700, color: C.greenDark, ls: 0.16,
                      lh: (compact ? 16 : 20) / (compact ? 12 : 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}