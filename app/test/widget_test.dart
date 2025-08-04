import 'package:flutter_test/flutter_test.dart';
import 'package:tahlil_kolay/main.dart';

void main() {
  testWidgets('Ana ekran açılır', (WidgetTester tester) async {
    await tester.pumpWidget(const TahlilKolayApp());

    // “Tahlil Yükle” butonu bulunmalı
    expect(find.text('Tahlil Yükle'), findsOneWidget);
    // “Geçmiş Tahliller” metni bulunmalı
    expect(find.text('Geçmiş Tahliller'), findsOneWidget);
  });
}
