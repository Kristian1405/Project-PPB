import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/brand_header.dart';
import '../widgets/common.dart';
import 'form_screen.dart';

/// Layar 2: Foto & Lapor Sampah (kamera + lokasi + kirim).
class LaporScreen extends StatelessWidget {
  const LaporScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BrandHeader(subtitle: 'Foto & Lapor', compact: true),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepBanner(),
                const SizedBox(height: 20),
                _cameraPreview(),
                const SizedBox(height: 20),
                _locationCard(),
                const SizedBox(height: 20),
                _cta(context),
                const SizedBox(height: 8),
                _footnote(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _stepBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: C.greenLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: shadowSmall,
      ),
      child: Row(
        children: [
          const RoundIcon(icon: Icons.photo_camera, bg: C.green, fg: C.white,
              size: 40, iconSize: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Langkah 1: Foto Sampah',
                    style: ty(22, 700, color: C.greenDark, lh: 27.5 / 22)),
                Text('Arahkan kamera ke tumpukan\nsampah liar',
                    style: ty(16, 600, color: C.greenDark, ls: 0.16, lh: 22 / 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cameraPreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 262,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/kamera_preview.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: C.indigoPlaceholder),
            ),
            const Positioned.fill(child: CornerBrackets()),
            Positioned(
              left: 16,
              right: 16,
              top: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                    decoration: BoxDecoration(
                      color: C.camDark,
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: shadowSmall,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.flash_off, color: C.camText, size: 17),
                        const SizedBox(width: 4),
                        Text('Lampu Mati',
                            style: ty(16, 600, color: C.camText, ls: 0.16, lh: 22 / 16)),
                      ],
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: C.camDark,
                      shape: BoxShape.circle,
                      boxShadow: shadowSmall,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.flip_camera_ios, color: C.camText, size: 20),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: C.white,
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: shadowLift,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const RoundIcon(icon: Icons.camera_alt, bg: C.green, fg: C.white,
                          size: 40, iconSize: 20),
                      const SizedBox(width: 12),
                      Text('Ambil Foto', style: ty(22, 700, lh: 30 / 22)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationCard() {
    return SectionCardColumn(
      gap: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: C.green, size: 23),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lokasi Terdeteksi\nOtomatis',
                        style: ty(22, 700, lh: 30 / 22)),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: C.greenLight,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                        color: C.green, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 4),
                  Text('GPS\nAkurat',
                      style: ty(16, 700, color: C.greenDark, ls: 0.16, lh: 22 / 16)),
                ],
              ),
            ),
          ],
        ),
        Text('Jl. Lembah Oak No. 442', style: ty(24, 700, ls: -0.12, lh: 30 / 24)),
        Text('Kecamatan Sukamaju • Akurat hingga\n3 meter',
            style: ty(18, 400, color: C.slate, lh: 28 / 18)),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/peta_pin.png',
            height: 144,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(height: 144, color: C.indigoPlaceholder),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.edit_location_alt, color: C.greenMid, size: 16),
              const SizedBox(width: 4),
              Text('Titik kurang pas? Geser peta\nmanual',
                  textAlign: TextAlign.center,
                  style: ty(18, 600, color: C.greenMid, ls: 0.18, lh: 24 / 18)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cta(BuildContext context) {
    return Material(
      color: C.green,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const FormScreen()),
        ),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: shadowLift,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.send, color: C.white, size: 25),
              const SizedBox(width: 12),
              Text('KIRIM LAPORAN\nSEKARANG',
                  textAlign: TextAlign.center,
                  style: ty(24, 700, color: C.white, ls: 0.6, lh: 32 / 24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _footnote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 19),
          child: Icon(Icons.shield_outlined, color: C.green, size: 14),
        ),
        const SizedBox(width: 6),
        SizedBox(
          width: 250,
          child: Text(
            'Tanpa perlu mengetik. Laporan langsung\nditerima petugas kebersihan kota.',
            textAlign: TextAlign.center,
            style: ty(18, 500, color: C.slate, lh: 28 / 18),
          ),
        ),
      ],
    );
  }
}