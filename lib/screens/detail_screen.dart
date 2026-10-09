import 'package:flutter/material.dart';

import '../models.dart';
import '../theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/brand_header.dart';
import '../widgets/common.dart';

/// Layar 3: Detail tiap laporan (foto bukti, timeline, petugas, peta, aksi).
class DetailScreen extends StatefulWidget {
  final Report report;

  const DetailScreen({super.key, required this.report});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _after = true;

  Report get _r => widget.report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BrandHeader(subtitle: 'Riwayat'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _backPill(context),
                  const SizedBox(height: 20),
                  _summaryCard(),
                  const SizedBox(height: 20),
                  _photosCard(),
                  const SizedBox(height: 20),
                  _timelineCard(),
                  if (_r.status == ReportStatus.done) ...[
                    const SizedBox(height: 20),
                    _petugasCard(),
                  ],
                  const SizedBox(height: 20),
                  _mapCard(),
                  const SizedBox(height: 20),
                  _actions(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(active: -1),
    );
  }

  Widget _backPill(BuildContext context) {
    return Material(
      color: C.indigoSoft,
      borderRadius: BorderRadius.circular(9999),
      child: InkWell(
        borderRadius: BorderRadius.circular(9999),
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9999),
            boxShadow: shadowSmall,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_back, color: C.green, size: 19),
              const SizedBox(width: 8),
              Text('Kembali ke Riwayat', style: ty(22, 600, lh: 30 / 22)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard() {
    return SectionCardColumn(
      gap: 8,
      children: [
        Row(
          children: [
            const Icon(Icons.receipt_long, color: C.green, size: 22),
            const SizedBox(width: 8),
            Text(_r.id, style: ty(24, 700, ls: -0.12, lh: 32 / 24)),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: _r.status.pillBg,
              borderRadius: BorderRadius.circular(9999),
              boxShadow: shadowSmall,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_r.status.icon, color: _r.status.iconColor, size: 17),
                const SizedBox(width: 6),
                Text(_r.pillLabel,
                    style: ty(18, 700,
                        color: _r.status == ReportStatus.done
                            ? C.greenDark
                            : _r.status.pillFg,
                        ls: 0.18, lh: 24 / 18)),
              ],
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.location_on, color: C.muted, size: 16),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text('${_r.address}, Kec.\nSukamaju',
                  style: ty(18, 500, color: C.slate, lh: 28 / 18)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _photosCard() {
    return SectionCardColumn(
      gap: 12,
      children: [
        Row(
          children: [
            const Icon(Icons.photo_library, color: C.green, size: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Text('Foto Bukti Pembersihan',
                  style: ty(24, 700, ls: -0.12, lh: 32 / 24)),
            ),
          ],
        ),
        Text(
          'Tekan tombol di bawah untuk\nmembandingkan kondisi sampah liar\nsebelum dan sesudah dibersihkan.',
          style: ty(18, 400, color: C.slate, lh: 28 / 18),
        ),
        _viewSwitcher(),
        _photoArea(),
      ],
    );
  }

  Widget _viewSwitcher() {
    final after = _after;
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: C.indigoSoft,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _switcherButton(
            active: after,
            icon: Icons.check_circle_outline,
            label: 'Setelah\n(Bersih)',
            onTap: () => setState(() => _after = true),
          ),
          const SizedBox(width: 8),
          _switcherButton(
            active: !after,
            icon: Icons.history,
            label: 'Sebelum\nLapor',
            onTap: () => setState(() => _after = false),
          ),
        ],
      ),
    );
  }

  Widget _switcherButton({
    required bool active,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final fg = active ? C.white : C.slate;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: active ? C.green : C.indigoSoft,
            borderRadius: BorderRadius.circular(8),
            boxShadow: active ? shadowSmall : null,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: fg, size: 21),
              const SizedBox(width: 8),
              Text(label,
                  textAlign: TextAlign.center,
                  style: ty(18, 600, color: fg, ls: 0.18, lh: 24 / 18)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _photoArea() {
    final asset = _after ? 'assets/images/foto_after.png' : _r.photoAsset;
    final pillText = _after
        ? '${_r.statusDate}, 09:30 • TUNTAS\nBERSIH'
        : 'Kondisi Saat Dilaporkan';
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: C.indigoPlaceholder,
        child: Column(
          children: [
            SizedBox(
              height: 288,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(asset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: C.indigoPlaceholder)),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                          color: C.greenLight,
                          borderRadius: BorderRadius.circular(9999),
                          boxShadow: shadowLift,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check,
                                color: C.greenDark, size: 18),
                            const SizedBox(width: 6),
                            Text(pillText,
                                textAlign: TextAlign.center,
                                style: ty(18, 600, color: C.greenDark, ls: 0.18, lh: 24 / 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: C.indigoSoft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.check_circle, color: C.green, size: 17),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _after
                          ? 'Trotoar dan tepi jalan telah steril dan bebas sumbatan.'
                          : 'Foto asli saat sampah liar masih menumpuk sebelum diangkut.',
                      style: ty(18, 500, lh: 28 / 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timelineCard() {
    final steps = stepsFor(_r);
    return SectionCardColumn(
      gap: 20,
      children: [
        Row(
          children: [
            const Icon(Icons.timeline, color: C.green, size: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Text('Perjalanan Laporan\nAnda',
                  style: ty(24, 700, ls: -0.12, lh: 32 / 24)),
            ),
          ],
        ),
        for (int i = 0; i < steps.length; i++) _step(steps[i]),
      ],
    );
  }

  Widget _step(TimelineStep s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 44,
          child: Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: s.circleBg,
                  shape: BoxShape.circle,
                  boxShadow: shadowSmall,
                ),
                alignment: Alignment.center,
                child: Icon(s.icon, color: s.iconColor, size: s.icon == Icons.local_shipping ? 22 : 18),
              ),
              if (!s.isLast)
                Container(width: 6, height: 48, color: C.green),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(s.title,
                        style: ty(22, s.descColor == C.ink ? 700 : 600,
                            color: s.titleColor, lh: 30 / 22)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: s.chipBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(s.time,
                    style: ty(16, s.chipFg == C.greenDark ? 700 : 600,
                        color: s.chipFg, ls: 0.16, lh: 22 / 16)),
              ),
              const SizedBox(height: 8),
              Text(s.desc,
                  style: ty(18, 400, color: s.descColor, lh: 24.75 / 18)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _petugasCard() {
    return SectionCardColumn(
      gap: 12,
      children: [
        Row(
          children: [
            const RoundIcon(icon: Icons.engineering, bg: C.indigo, fg: C.green,
                size: 56, iconSize: 28),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bpk. Mulyono', style: ty(22, 600, lh: 30 / 22)),
                Text('Kepala Regu Kebersihan 4',
                    style: ty(16, 600, color: C.slate, ls: 0.16, lh: 22 / 16)),
              ],
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: C.indigoSoft,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Icon(Icons.format_quote, color: C.green, size: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '“Lokasi Jl. Lembah Oak No. 442 sudah kami bersihkan tuntas bersama 3 personil. Area sudah disemprot disinfektan dan jalanan kembali rapi. Terima kasih banyak atas kepedulian warga menjaga lingkungan kita!”',
                  style: ty(18, 400, lh: 29.25 / 18),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _mapCard() {
    return SectionCardColumn(
      gap: 12,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: C.green, size: 22),
            const SizedBox(width: 8),
            Text('Titik Lokasi Pengangkutan', style: ty(22, 600, lh: 30 / 22)),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 192,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/peta.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: C.indigoPlaceholder)),
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: C.bg,
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: shadowLift,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on, color: C.green, size: 20),
                        const SizedBox(width: 8),
                        Text(_r.address,
                            style: ty(18, 700, ls: 0.18, lh: 24 / 18)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(_r.detailLocation,
            style: ty(18, 400, color: C.slate, lh: 28 / 18)),
      ],
    );
  }

  Widget _actions() {
    return Column(
      children: [
        Material(
          color: C.green,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Fitur berbagi WhatsApp (demo).'))),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: shadowLift,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.chat, color: C.white, size: 22),
                  const SizedBox(width: 8),
                  Text('Bagikan Bukti Bersih ke\nWhatsApp RT',
                      textAlign: TextAlign.center,
                      style: ty(18, 600, color: C.white, ls: 0.18, lh: 24 / 18)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Material(
          color: C.white,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Menelepon 311 (demo).'))),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: shadowSmall,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone_in_talk, color: C.green, size: 20),
                  const SizedBox(width: 8),
                  Text('Masih ada sisa sampah?\nHubungi Petugas (311)',
                      textAlign: TextAlign.center,
                      style: ty(18, 600, ls: 0.18, lh: 24 / 18)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}