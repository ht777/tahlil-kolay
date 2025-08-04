import 'package:flutter/material.dart';
import 'package:tahlil_kolay/screens/home_screen.dart';

void main() {
  runApp(const TahlilKolayApp());
}

class TahlilKolayApp extends StatelessWidget {
  const TahlilKolayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahlil Kolay',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
