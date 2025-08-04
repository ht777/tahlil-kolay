import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String report;
  const ResultScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analiz Sonucu')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(report, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
