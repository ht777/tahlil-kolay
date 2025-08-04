// lib/services/db_service.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/tahlil.dart';

class DbService {
  static Database? _db;

  static Future<Database> get _database async {
    if (_db != null) return _db!;
    _db = await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    final path = join(await getDatabasesPath(), 'tahliller.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE tahliller(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            data TEXT,
            report TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insert(Tahlil t) async {
    await (await _database).insert('tahliller', t.toMap());
  }

  static Future<List<Tahlil>> getAll() async {
    final maps =
        await (await _database).query('tahliller', orderBy: 'date DESC');
    return maps.map((e) => Tahlil.fromMap(e)).toList();
  }

  static Future<Tahlil?> getLast() async {
    final list = await getAll();
    return list.isEmpty ? null : list.first;
  }
}
