import 'package:flutter/material.dart';

import '../models.dart';
import '../theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/brand_header.dart';
import '../widgets/common.dart';

/// Layar 4: Formulir Laporan (foto, lokasi, jenis sampah, privasi, kirim).
class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  int _category = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BrandHeader(subtitle: 'Foto & Lapor', compact: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _intro(),
                  const SizedBox(height: 28),
                  _step1(),
                  const SizedBox(height: 28),
                  _step2(),
                  const SizedBox(height: 28),
                  _step3(),
                  const SizedBox(height: 28),
                  _step4(),
                  const SizedBox(height: 28),
                  _submit(),
                  const SizedBox(height: 28),
                  _bantuanCard(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(active: -1),
    );
  }

  // ---------- Intro ----------

  Widget _intro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: C.greenLight,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified_user, color: C.greenDark, size: 18),
              const SizedBox(width: 8),
              Text('Bebas Login • Otomatis Lacak GPS',
                  style: ty(16, 700, color: C.greenDark, lh: 22 / 16)),
            ],
          ),
        ),
        const SizedBox(height: 7),
        Text('Lapor Sampah Cepat',
            style: ty(28, 700, ls: -0.7, lh: 36 / 28)),
        const SizedBox(height: 7),
        Text(
          'Cukup ambil foto tumpukan sampah. Lokasi\ndan rincian lain akan terisi otomatis untuk\npetugas kebersihan.',
          style: ty(18, 400, color: C.slate, lh: 24.75 / 18),
        ),
      ],
    );
  }

  // ---------- Step header ----------

  Widget _stepHeader(int number, String title, Widget trailing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                  color: C.green, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text('$number',
                  style: ty(14, 700, color: C.white, lh: 20 / 14)),
            ),
            const SizedBox(width: 8),
            Text(title, style: ty(22, 700, lh: 30 / 22)),
          ],
        ),
        trailing,
      ],
    );
  }

  Widget _greenPill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: C.greenLight,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: C.greenDark, size: 15),
          const SizedBox(width: 4),
          Text(label,
              textAlign: TextAlign.center,
              style: ty(16, 600, color: C.greenDark, ls: 0.16, lh: 22 / 16)),
        ],
      ),
    );
  }

  // ---------- Step 1: Foto ----------

  Widget _step1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _stepHeader(1, 'Foto Lokasi\nSampah', _greenPill(Icons.check, 'Siap\nKirim')),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: C.indigoPlaceholder,
            borderRadius: BorderRadius.circular(12),
            boxShadow: shadowLift,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              SizedBox(
                height: 288,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset('assets/images/foto_form.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: C.indigoPlaceholder)),
                    const Positioned.fill(child: CornerBrackets()),
                    Positioned(
                      left: 16,
                      right: 16,
                      top: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: C.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: shadowSmall,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.check,
                                    color: C.green, size: 15),
                                const SizedBox(width: 6),
                                Text('✓ Foto Terlampir',
                                    style: ty(16, 600,
                                        color: C.green, ls: 0.16, lh: 22 / 16)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: C.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('Pukul 09:42 WIB',
                                style: ty(12, 700,
                                    color: C.slate, lh: 16 / 12)),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text('[ AREA BIDIKAN PETUGAS ]',
                            style: ty(12, 600, color: C.white, ls: 1.2)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: C.white,
                child: Material(
                  color: C.indigo,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pilih foto baru (demo).'))),
                    child: Container(
                      height: 58,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.camera_alt, color: C.ink, size: 22),
                          const SizedBox(width: 8),
                          Text('Ganti Foto Baru',
                              style: ty(18, 700, ls: 0.18, lh: 24 / 18)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------- Step 2: Lokasi ----------

  Widget _step2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _stepHeader(2, 'Lokasi\nPenjemputan',
            _greenPill(Icons.my_location, 'Akurat\n(±3m)')),
        const SizedBox(height: 8),
        SectionCardColumn(
          gap: 12,
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: C.greenLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child:
                      const Icon(Icons.location_on, color: C.greenDark, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jl. Lembah Oak No. 442',
                          style: ty(18, 700, lh: 22.5 / 18)),
                      const SizedBox(height: 4),
                      Text('Kel. Sukamaju, Kec. Cilodong,\nKota Depok',
                          style: ty(18, 400, color: C.slate, lh: 24.75 / 18)),
                    ],
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 144,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset('assets/images/peta.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: C.indigoPlaceholder)),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: C.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text('Kordinat: -6.4128, 106.8402',
                                  style: ty(12, 700, lh: 16 / 12)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: C.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: shadowSmall,
                              ),
                              child: Text('Ubah Titik',
                                  style: ty(16, 700,
                                      color: C.green, ls: 0.16, lh: 22 / 16)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------- Step 3: Jenis Sampah ----------

  Widget _step3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration:
                      const BoxDecoration(color: C.green, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text('3',
                      style: ty(14, 700, color: C.white, lh: 20 / 14)),
                ),
                const SizedBox(width: 8),
                Text('Jenis Sampah', style: ty(22, 700, lh: 30 / 22)),
              ],
            ),
            Text('(Bisa Dipilih)',
                style: ty(16, 600, color: C.slate, ls: 0.16, lh: 22 / 16)),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            Row(
              children: [
                Expanded(child: _categoryCard(0)),
                const SizedBox(width: 8),
                Expanded(child: _categoryCard(1)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _categoryCard(2)),
                const SizedBox(width: 8),
                Expanded(child: _categoryCard(3)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _categoryCard(int index) {
    final c = trashCategories[index];
    final selected = _category == index;
    final fg = selected ? C.greenDark : C.ink;
    final subFg = selected ? C.greenDark : C.slate;
    return GestureDetector(
      onTap: () => setState(() => _category = index),
      child: Container(
        height: 96,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? C.greenLight : C.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: shadowSmall,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(c.icon, color: fg, size: 24),
                Icon(
                  selected
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: selected ? C.greenDark : C.greyIcon,
                  size: 20,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.name, style: ty(18, 700, color: fg, lh: 22.5 / 18)),
                Text(c.sub, style: ty(12, 400, color: subFg, lh: 16 / 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Step 4: Patokan & Privasi ----------

  Widget _step4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _patokan(),
        const SizedBox(height: 20),
        _privasi(),
      ],
    );
  }

  Widget _patokan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Patokan Lokasi Tambahan\n(Opsional)',
                style: ty(18, 700, ls: 0.18, lh: 24 / 18)),
            Text('Boleh\nDikosongkan',
                textAlign: TextAlign.right,
                style: ty(12, 400, color: C.slate, ls: 0.18, lh: 16 / 12)),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          style: ty(18, 400, color: C.ink, lh: 23.4 / 18),
          decoration: InputDecoration(
            hintText: 'Contoh: Samping pos ronda / dekat tiang listrik biru',
            hintStyle: ty(18, 400, color: C.muted, lh: 23.4 / 18),
            filled: true,
            fillColor: C.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text('Membantu supir truk langsung menemukan titik sampah.',
            style: ty(12, 400, color: C.slate, lh: 16 / 12)),
      ],
    );
  }

  Widget _privasi() {
    return Container(
      decoration: BoxDecoration(
        color: C.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: shadowSmall,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Privasi Warga', style: ty(22, 700, lh: 30 / 22)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: C.chipBg,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('Aman 100%',
                    style: ty(12, 700, color: C.chipFg, lh: 16 / 12)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: C.indigoSoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: C.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.check, color: C.white, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Laporkan Secara Anonim',
                          style: ty(18, 700, lh: 28 / 18)),
                      Text('Nama dan identitas Anda dirahasiakan\nsepenuhnya.',
                          style: ty(12, 400, color: C.slate, lh: 16 / 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _optionalField(
            icon: Icons.person,
            label: 'Nama Pelapor\n(Opsional)',
            hint: 'Contoh: Bpk. Bambang / Ibu Rina',
            helper: 'Boleh dikosongkan jika ingin tetap anonim.',
          ),
          const SizedBox(height: 12),
          _optionalField(
            icon: Icons.phone,
            label: 'Nomor WA untuk Bukti Bersih\n(Opsional)',
            hint: '812-3456-7890',
            helper: null,
            withPrefix: true,
          ),
        ],
      ),
    );
  }

  Widget _optionalField({
    required IconData icon,
    required String label,
    required String hint,
    String? helper,
    bool withPrefix = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Icon(icon, color: C.green, size: 14),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(label,
                  style: ty(16, 600, ls: 0.16, lh: 22 / 16)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 54,
          decoration: BoxDecoration(
            color: C.indigoPlaceholder,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              if (withPrefix) ...[
                Text('+62 ', style: ty(14, 700, color: C.slate, lh: 20 / 14)),
                Container(width: 1, height: 26, color: C.indigo),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: TextField(
                  style: ty(18, 400, color: C.ink, lh: 23.4 / 18),
                  keyboardType:
                      withPrefix ? TextInputType.phone : TextInputType.text,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: ty(18, 400, color: C.muted, lh: 23.4 / 18),
                    isDense: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (helper != null) ...[
          const SizedBox(height: 4),
          Text(helper, style: ty(12, 400, color: C.slate, lh: 16 / 12)),
        ],
      ],
    );
  }

  // ---------- Submit ----------

  Widget _submit() {
    return Column(
      children: [
        Material(
          color: C.submit,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Laporan berhasil dikirim! (demo)'))),
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
                  const Icon(Icons.send, color: C.mint, size: 25),
                  const SizedBox(width: 12),
                  Text('KIRIM LAPORAN\nSEKARANG',
                      textAlign: TextAlign.center,
                      style: ty(24, 700, color: C.mint, lh: 32 / 24)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: C.green, size: 15),
            const SizedBox(width: 8),
            Text('100% Gratis • Langsung terhubung ke\narmada kebersihan kota',
                textAlign: TextAlign.center,
                style: ty(16, 500, color: C.slate, ls: 0.16, lh: 22 / 16)),
          ],
        ),
      ],
    );
  }

  // ---------- Bantuan card ----------

  Widget _bantuanCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: C.indigoPlaceholder,
        borderRadius: BorderRadius.circular(12),
        boxShadow: shadowSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const RoundIcon(icon: Icons.phone_in_talk, bg: C.greenLight,
                  fg: C.greenDark, size: 48, iconSize: 22),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Butuh\nBantuan\nSuara?',
                      style: ty(18, 700, lh: 28 / 18)),
                  const SizedBox(height: 4),
                  Text('Hubungi Telepon\nDarurat Kebersihan\n311',
                      style: ty(12, 400, color: C.slate, lh: 16 / 12)),
                ],
              ),
            ],
          ),
          Material(
            color: C.white,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Menelepon 311 (demo).'))),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: shadowSmall,
                ),
                child: Text('Telepon 311',
                    style: ty(16, 700, color: C.green, ls: 0.16, lh: 22 / 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}