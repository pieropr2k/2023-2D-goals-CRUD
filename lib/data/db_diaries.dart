import 'package:crud_sqlite_chgpt/data/db.dart';
import 'package:crud_sqlite_chgpt/data/tables.dart';
import 'package:crud_sqlite_chgpt/model/diary.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DiariesDBClass extends DatabaseClass {
  String tableName = diaryTable;
  String subTableName = pageTable;

  static final DiariesDBClass instance = DiariesDBClass._init();

  DiariesDBClass._init();

  Future<List<DiaryClass>> getDiaries() async {
    final db = await instance.database;
    final dbPath = await getDatabasesPath();
    //print(dbPath);
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(
      maps.length,
      (index) => DiaryClass(
        id: maps[index]['id'],
        title: maps[index]['title'],
      ),
    );
  }

  Future<DiaryClass?> getDiary(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return DiaryClass(
        id: maps[0]['id'],
        title: maps[0]['title'],
      );
    }
    return null;
  }

  Future<int> insertDiary(DiaryClass diary) async {
    print(diary.toString());
    final db = await instance.database;
    //print(diary.toMap());

    return await db.insert(
      tableName,
      diary.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateDiary(DiaryClass diary) async {
    final db = await instance.database;

    return await db.update(
      tableName,
      diary.toMap(),
      //{},
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [diary.id],
    );
  }

  Future<int> deleteDiary(int id) async {
    final db = await DatabaseClass.instance.database;
    // First delete the subelements tables
    await db.delete(
      subTableName,
      where: 'diaryId = ?',
      whereArgs: [id],
    );
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
