import 'package:flutter/material.dart';
import '../services/file_picker_helper.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';
import '../models/tahlil.dart';
import 'result_screen.dart';
import 'history_screen.dart'; // <- yeni eklenen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  Future<void> _pickAndAnalyze() async {
    final file = await pickFile();
    if (file == null || !mounted) return;

    setState(() => _isLoading = true);

    try {
      final report = await ApiService.analyzeImage(file);

      final tahlil = Tahlil(
        date: DateTime.now().toIso8601String(),
        data: {}, // TODO: API yanıtından parse edeceğiz
        report: report,
      );
      await DbService.insert(tahlil);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ResultScreen(report: report)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahlil Kolay')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.upload_file),
                    label: const Text('PDF / Resim Yükle'),
                    onPressed: _pickAndAnalyze,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.history),
                    label: const Text('Geçmiş Tahliller'),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HistoryScreen(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
