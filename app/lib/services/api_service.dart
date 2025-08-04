import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // Prod için dart-define ile geç: --dart-define=API_BASE_URL=https://api.domain.com
  static const String _baseUrl = String.fromEnvironment('API_BASE_URL',
      defaultValue: 'https://api.example.com');

  static Future<String> analyzeImage(File imageFile) async {
    final uri = Uri.parse('$_baseUrl/analyze');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    try {
      final response = await request.send();
      final status = response.statusCode;
      final body = await response.stream.bytesToString();

      if (status < 200 || status >= 300) {
        return 'Sunucu hatası ($status): $body';
      }

      final decoded = jsonDecode(body);
      final report = decoded is Map<String, dynamic> ? decoded['report'] : null;
      return (report is String && report.isNotEmpty)
          ? report
          : 'Analiz alınamadı';
    } on SocketException {
      return 'Ağ bağlantısı hatası. Lütfen internetinizi kontrol edin.';
    } on FormatException {
      return 'Sunucudan beklenmeyen yanıt alındı.';
    } catch (e) {
      return 'Beklenmeyen hata: $e';
    }
  }
}
