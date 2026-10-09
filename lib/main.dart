import 'package:flutter/material.dart';

import 'screens/home_shell.dart';
import 'theme.dart';

void main() => runApp(const CleanReportApp());

class CleanReportApp extends StatelessWidget {
  const CleanReportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanReport',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const HomeShell(),
    );
  }
}