import 'package:flutter/material.dart';

import 'theme.dart';

/// Status sebuah laporan sampah.
enum ReportStatus { received, inProgress, done }

extension ReportStatusX on ReportStatus {
  String get label => switch (this) {
        ReportStatus.received => 'Laporan Diterima',
        ReportStatus.inProgress => 'Petugas Meluncur',
        ReportStatus.done => 'Sudah Bersih',
      };

  IconData get icon => switch (this) {
        ReportStatus.done => Icons.check,
        ReportStatus.inProgress => Icons.local_shipping,
        ReportStatus.received => Icons.inbox,
      };

  Color get pillBg => this == ReportStatus.done ? C.greenLight : C.indigo;
  Color get pillFg => this == ReportStatus.done ? C.greenDeep : C.ink;
  Color get iconColor => this == ReportStatus.done ? C.greenDeep : C.green;

  Color get descColor => switch (this) {
        ReportStatus.done => C.green,
        ReportStatus.inProgress => C.greenMid,
        ReportStatus.received => C.olive,
      };

  Color get badgeBg => this == ReportStatus.done ? C.green : C.indigo;
  Color get badgeIcon => this == ReportStatus.done ? C.white : C.ink;
}

class Report {
  final String id;
  final ReportStatus status;

  /// Tanggal di pill status, mis. "24 Okt" (kosong jika tidak ada).
  final String statusDate;
  final String address;
  final String reportedText;
  final String statusMessage;
  final String footerNote;
  final IconData footerIcon;
  final String photoAsset;
  final String detailLocation;

  const Report({
    required this.id,
    required this.status,
    this.statusDate = '',
    required this.address,
    required this.reportedText,
    required this.statusMessage,
    required this.footerNote,
    required this.footerIcon,
    required this.photoAsset,
    required this.detailLocation,
  });

  String get pillLabel => statusDate.isEmpty ? status.label : '${status.label} • $statusDate';
}

/// Data demo sesuai desain (3 laporan di layar Riwayat).
final List<Report> demoReports = [
  const Report(
    id: '#CR-8821',
    status: ReportStatus.done,
    statusDate: '24 Okt',
    address: 'Jl. Lembah Oak No. 442',
    reportedText: 'Dilaporkan 3 hari lalu',
    statusMessage: 'Regu Kebersihan #4 telah mengangkut sampah.',
    footerNote: '2 Foto (Sebelum & Sesudah)',
    footerIcon: Icons.photo_library,
    photoAsset: 'assets/images/foto_1.png',
    detailLocation: 'Kecamatan Sukamaju,\nRT 04 / RW 02',
  ),
  const Report(
    id: '#CR-8904',
    status: ReportStatus.inProgress,
    address: 'Jl. Melati & Simpang Warga',
    reportedText: 'Dilaporkan Kemarin,\n14:15 WIB',
    statusMessage: 'Perkiraan selesai diangkut dalam 24 jam.',
    footerNote: 'Rute Angkut #12 Terjadwal',
    footerIcon: Icons.local_shipping,
    photoAsset: 'assets/images/foto_2.png',
    detailLocation: 'Kecamatan Sukamaju,\nRT 04 / RW 02',
  ),
  const Report(
    id: '#CR-8930',
    status: ReportStatus.received,
    address: 'Jl. Pinus No. 78',
    reportedText: 'Dilaporkan Hari Ini,\n09:30 WIB',
    statusMessage: 'Sedang ditinjau petugas wilayah.',
    footerNote: 'Dekat Taman Warga',
    footerIcon: Icons.place,
    photoAsset: 'assets/images/foto_3.png',
    detailLocation: 'Kecamatan Sukamaju,\nRT 04 / RW 02',
  ),
];

/// Satu langkah pada timeline detail laporan.
class TimelineStep {
  final String title;
  final String time;
  final String desc;
  final IconData icon;
  final Color circleBg;
  final Color iconColor;
  final Color titleColor;
  final Color chipBg;
  final Color chipFg;
  final Color descColor;
  final bool isLast;

  const TimelineStep({
    required this.title,
    required this.time,
    required this.desc,
    required this.icon,
    required this.circleBg,
    required this.iconColor,
    required this.titleColor,
    required this.chipBg,
    required this.chipFg,
    required this.descColor,
    required this.isLast,
  });
}

/// Timeline disusun berdasarkan status laporan.
List<TimelineStep> stepsFor(Report r) {
  final steps = <TimelineStep>[
    TimelineStep(
      title: '1. Laporan Diterima',
      time: r.status == ReportStatus.received ? 'Hari Ini, 09:30' : '21 Okt, 14:15',
      desc: 'Laporan foto warga masuk ke sistem pusat Dinas Kebersihan & Pertamanan.',
      icon: Icons.check,
      circleBg: C.green,
      iconColor: C.white,
      titleColor: C.ink,
      chipBg: C.indigoPlaceholder,
      chipFg: C.slate,
      descColor: C.slate,
      isLast: r.status == ReportStatus.received,
    ),
    TimelineStep(
      title: '2. Regu Ditugaskan',
      time: r.status == ReportStatus.inProgress ? 'Hari Ini, 08:00' : '22 Okt, 08:00',
      desc: 'Armada Truk #12 & Regu 4 meluncur langsung menuju titik lokasi laporan.',
      icon: Icons.local_shipping,
      circleBg: C.green,
      iconColor: C.white,
      titleColor: C.ink,
      chipBg: C.indigoPlaceholder,
      chipFg: C.slate,
      descColor: C.slate,
      isLast: r.status == ReportStatus.inProgress,
    ),
    TimelineStep(
      title: '3. Sampah Diangkut\nTuntas',
      time: r.statusDate.isEmpty ? '24 Okt, 09:30' : '${r.statusDate}, 09:30',
      desc: 'Semua sampah perabotan & puluhan kantong plastik telah dibawa ke TPA Induk.',
      icon: Icons.check,
      circleBg: C.greenLight,
      iconColor: C.green,
      titleColor: C.green,
      chipBg: C.greenLight,
      chipFg: C.greenDark,
      descColor: C.ink,
      isLast: true,
    ),
  ];
  return steps.sublist(0, switch (r.status) {
        ReportStatus.received => 1,
        ReportStatus.inProgress => 2,
        ReportStatus.done => 3,
      });
}

/// Opsi jenis sampah pada formulir.
class TrashCategory {
  final String name;
  final String sub;
  final IconData icon;

  const TrashCategory({required this.name, required this.sub, required this.icon});
}

const List<TrashCategory> trashCategories = [
  TrashCategory(name: 'Plastik & Liar', sub: 'Sampah kantong / bungkus', icon: Icons.shopping_bag),
  TrashCategory(name: 'Kasur & Perabot', sub: 'Barang bekas besar', icon: Icons.chair),
  TrashCategory(name: 'Ranting & Puing', sub: 'Sisa pohon / semen', icon: Icons.park),
  TrashCategory(name: 'Berbau / Bangkai', sub: 'Perlu angkut segera', icon: Icons.warning_amber),
];