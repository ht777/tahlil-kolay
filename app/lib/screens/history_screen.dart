import 'package:flutter/material.dart';
import '../models/tahlil.dart';
import '../services/db_service.dart';
import 'compare_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Geçmiş Tahliller')),
      body: FutureBuilder<List<Tahlil>>(
        future: DbService.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Henüz kayıt yok'));
          }
          final list = snapshot.data!;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final t = list[i];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(t.report),
                  subtitle: Text('Tarih: ${t.date.substring(0, 10)}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CompareScreen(
                        current: t,
                        previous: i + 1 < list.length ? list[i + 1] : null,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
