import 'package:flutter/material.dart';
import '../models/tahlil.dart';

class CompareScreen extends StatelessWidget {
  final Tahlil current;
  final Tahlil? previous;

  const CompareScreen({super.key, required this.current, this.previous});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Karşılaştırma')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Yeni Tahlil',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(current.report),
            const SizedBox(height: 20),
            if (previous != null) ...[
              const Text('Önceki Tahlil',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(previous!.report),
            ] else
              const Text('Önceki tahlil bulunamadı.'),
          ],
        ),
      ),
    );
  }
}
