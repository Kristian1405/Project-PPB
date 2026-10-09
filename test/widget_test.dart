import 'package:flutter_test/flutter_test.dart';

import 'package:cleanreport/main.dart';

void main() {
  testWidgets('Home shell renders tabs and header', (tester) async {
    await tester.pumpWidget(const CleanReportApp());

    // Header brand tampil.
    expect(find.text('CleanReport'), findsWidgets);

    // Navigasi bawah tampil (tab Lapor & Riwayat).
    expect(find.text('Lapor'), findsWidgets);
    expect(find.text('Riwayat'), findsWidgets);
  });
}