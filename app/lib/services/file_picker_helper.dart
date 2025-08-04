import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<File?> pickFile() async {
  // 1) İzin iste
  final status = await Permission.storage.request();
  if (!status.isGranted) {
    // Android 13+ için alternatif izin kontrolü
    final mediaStatus = await Permission.photos.request();
    if (!mediaStatus.isGranted) return null;
  }

  // 2) Dosya seç
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
  );
  if (result == null || result.files.single.path == null) return null;
  return File(result.files.single.path!);
}
