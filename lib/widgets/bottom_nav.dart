import 'package:flutter/material.dart';

import '../theme.dart';

/// Navigasi bawah: tab Lapor & Riwayat.
/// [active] = 0 (Lapor), 1 (Riwayat), atau -1 (tidak ada yang aktif,
/// dipakai layar detail & formulir). [onSelect] null = statis.
class BottomNav extends StatelessWidget {
  final int active;
  final ValueChanged<int>? onSelect;

  const BottomNav({super.key, this.active = -1, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(color: C.white, boxShadow: shadowNav),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          _item(0, 'Lapor', Icons.photo_camera, 28),
          _item(1, 'Riwayat', Icons.history, 25),
        ],
      ),
    );
  }

  Widget _item(int index, String label, IconData icon, double iconSize) {
    final isActive = active == index;
    final color = isActive ? C.green : C.slate;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onSelect == null ? null : () => onSelect!(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: iconSize),
            const SizedBox(height: 4),
            Text(label, style: ty(16, 600, color: color, ls: 0.16, lh: 22 / 16)),
          ],
        ),
      ),
    );
  }
}