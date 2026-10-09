import 'package:flutter/material.dart';

import '../widgets/bottom_nav.dart';
import 'lapor_screen.dart';
import 'riwayat_screen.dart';

/// Kerangka utama aplikasi: 2 tab (Lapor & Riwayat) + navigasi bawah.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [LaporScreen(), RiwayatScreen()],
      ),
      bottomNavigationBar: BottomNav(
        active: _index,
        onSelect: (i) => setState(() => _index = i),
      ),
    );
  }
}