import 'package:flutter/material.dart';

import '../models.dart';
import '../theme.dart';
import '../widgets/brand_header.dart';
import '../widgets/common.dart';
import 'detail_screen.dart';
import 'form_screen.dart';

/// Layar 1: Riwayat Laporan Sampah (daftar laporan + filter).
class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

enum _Filter { all, processing, done }

class _RiwayatScreenState extends State<RiwayatScreen> {
  _Filter _filter = _Filter.all;

  List<Report> get _visible {
    switch (_filter) {
      case _Filter.all:
        return demoReports;
      case _Filter.processing:
        return demoReports
            .where((r) => r.status == ReportStatus.inProgress || r.status == ReportStatus.received)
            .toList();
      case _Filter.done:
        return demoReports.where((r) => r.status == ReportStatus.done).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BrandHeader(subtitle: 'Riwayat'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _hero(),
                const SizedBox(height: 20),
                _filterTabs(),
                const SizedBox(height: 20),
                for (int i = 0; i < _visible.length; i++) ...[
                  _reportCard(_visible[i]),
                  if (i < _visible.length - 1) const SizedBox(height: 20),
                ],
                const SizedBox(height: 20),
                _hint(),
                const SizedBox(height: 20),
                _cta(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _hero() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Laporan Saya', style: ty(28, 700, ls: -0.7, lh: 36 / 28)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: C.greenLight,
                borderRadius: BorderRadius.circular(9999),
                boxShadow: shadowSmall,
              ),
              child: Text(
                '3 Laporan Terkirim',
                style: ty(16, 700, ls: 0.16, lh: 22 / 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Pantau proses pembersihan sampah di\nlingkungan sekitar Anda.',
          style: ty(18, 400, color: C.slate, lh: 28 / 18),
        ),
      ],
    );
  }

  Widget _filterTabs() {
    Widget tab(_Filter f, String label) {
      final selected = _filter == f;
      return Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _filter = f),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? C.green : C.indigo,
              borderRadius: BorderRadius.circular(9999),
              boxShadow: shadowSmall,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: ty(18, selected ? 700 : 600,
                  color: selected ? C.white : C.ink, ls: 0.18, lh: 24 / 18),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        tab(_Filter.all, 'Semua\n(3)'),
        const SizedBox(width: 8),
        tab(_Filter.processing, 'Sedang\nDiproses\n(2)'),
        const SizedBox(width: 8),
        tab(_Filter.done, 'Sudah\nBersih\n(1)'),
      ],
    );
  }

  Widget _reportCard(Report r) {
    return Material(
      color: C.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DetailScreen(report: r)),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: shadowCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusPill(
                    icon: r.status.icon,
                    bg: r.status.pillBg,
                    fg: r.status.pillFg,
                    iconColor: r.status.iconColor,
                    label: r.pillLabel,
                  ),
                  Text(r.id,
                      style: ty(16, 500, color: C.slate, ls: 0.16, lh: 22 / 16)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _thumbnail(r),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r.address,
                            style: ty(22, 700, lh: 30 / 22)),
                        const SizedBox(height: 6),
                        Text(r.reportedText,
                            style: ty(18, 400, color: C.slate, lh: 28 / 18)),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Icon(r.status.icon,
                                  color: r.status.descColor, size: 16),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(r.statusMessage,
                                  style: ty(18, 600,
                                      color: r.status.descColor, lh: 28 / 18)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 12, thickness: 1, color: C.indigo),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(r.footerIcon, color: C.slate, size: 15),
                      const SizedBox(width: 4),
                      Text(r.footerNote,
                          style: ty(16, 600, color: C.slate, ls: 0.16, lh: 22 / 16)),
                    ],
                  ),
                  const Icon(Icons.chevron_right, color: C.green, size: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _thumbnail(Report r) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            r.photoAsset,
            width: 96,
            height: 96,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 96,
              height: 96,
              color: C.indigoPlaceholder,
              child: const Icon(Icons.image, color: C.indigo),
            ),
          ),
        ),
        Positioned(
          right: 6,
          bottom: 6,
          child: Container(
            width: 19,
            height: 15,
            decoration: BoxDecoration(
              color: r.status.badgeBg,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Icon(r.status.icon, color: r.status.badgeIcon, size: 11),
          ),
        ),
      ],
    );
  }

  Widget _hint() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: C.indigoPlaceholder,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: C.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Sentuh kartu mana saja untuk\nmelihat foto bukti dan catatan\npetugas.',
              style: ty(18, 400, color: C.slate, lh: 22.5 / 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cta() {
    return Material(
      color: C.green,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const FormScreen()),
        ),
        child: Container(
          height: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: shadowLift,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, color: C.white, size: 22),
              const SizedBox(width: 8),
              Text('+ Buat Laporan Baru',
                  style: ty(18, 600, color: C.white, ls: 0.18, lh: 24 / 18)),
            ],
          ),
        ),
      ),
    );
  }
}