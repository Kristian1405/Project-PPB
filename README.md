# CleanReport — Aplikasi Lapor Sampah (Flutter)

Implementasi desain Figma **"PPB"** sebagai aplikasi mobile Flutter.
App ini adalah aplikasi lapor sampah bernama **CleanReport** dengan 4 layar:

1. **Riwayat Laporan Sampah** — daftar laporan dengan filter status.
2. **Foto & Lapor Sampah** — alur cepat: foto + lokasi otomatis (GPS) + kirim.
3. **Detail tiap laporan** — foto bukti sebelum/sesudah, timeline, catatan petugas, peta, aksi.
4. **Formulir Laporan** — formulir lengkap (foto, lokasi, jenis sampah, privasi, kirim).

Semua teks, warna, ukuran, dan layout mengikuti persis desain Figma
(lebar layar desain 390 px). Font **Atkinson Hyperlegible Next**
(dimuat sebagai font variabel) sudah dibundel di `assets/fonts/`.

## Struktur proyek

```
lib/
  main.dart                 # entry point aplikasi
  theme.dart                # palet warna & gaya teks (dari Figma)
  models.dart               # model Laporan, status, kategori, timeline
  widgets/
    brand_header.dart       # header CleanReport
    bottom_nav.dart         # navigasi bawah (Lapor / Riwayat)
    common.dart             # kartu, pill status, tanda sudut kamera
  screens/
    home_shell.dart         # kerangka 2 tab + nav bawah
    riwayat_screen.dart     # layar 1
    lapor_screen.dart       # layar 2
    detail_screen.dart      # layar 3
    form_screen.dart        # layar 4
assets/
  images/                   # foto sampah, logo, peta (diekspor dari Figma)
  fonts/                    # AtkinsonHyperlegibleNext.ttf (variabel)
```

## Cara menjalankan

1. **Instal Flutter** (jika belum): ikuti panduan resmi
   https://docs.flutter.dev/get-started/install — pastikan `flutter` ada di PATH.

2. Buka terminal di folder proyek ini, lalu buat file platform standar:
   ```sh
   flutter create .
   ```
   (File `pubspec.yaml`, `lib/`, dan `assets/` yang sudah ada **tidak** ditimpa.)

3. Ambil dependensi:
   ```sh
   flutter pub get
   ```

4. Jalankan aplikasi (emulator/HP Android, Chrome, dsb.):
   ```sh
   flutter run
   ```

5. (Opsional) Cek kualitas kode & jalankan tes:
   ```sh
   flutter analyze
   flutter test
   ```

## Navigasi antar layar

- **Tab bawah**: `Lapor` (layar 2) ↔ `Riwayat` (layar 1).
- **Riwayat** → tekan kartu laporan → **Detail**.
- **Riwayat** → tombol "+ Buat Laporan Baru" → **Formulir**.
- **Lapor** → tombol "KIRIM LAPORAN SEKARANG" → **Formulir**.

Konten (3 laporan, lokasi, catatan petugas) adalah data demo statis sesuai desain.