import 'package:crud_sqlite_chgpt/data/tables.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseClass {
  DatabaseClass();

  static final DatabaseClass instance = DatabaseClass._init();

  static Database? _database;
  //String name = "tasks";
  int version = 1;

  DatabaseClass._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('crud_diaries1.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    //print(dbPath);
    final path = join(dbPath, filePath);
    //print(path);

    return await openDatabase(
      path,
      version: version,
      onCreate: onCreate,
      onConfigure: onConfigure,
    );
  }

  onCreate(Database db, int version) async {
    for (var scrip in tables) {
      await db.execute(scrip);
    }
    print(insertScript + ": sqflite script");
    await db.execute(insertScript);
  }

  onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }
}
