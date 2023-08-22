import 'package:crud_sqlite_chgpt/data/db.dart';
import 'package:crud_sqlite_chgpt/data/tables.dart';
import 'package:crud_sqlite_chgpt/model/goal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GoalsDBClass extends DatabaseClass implements DatabaseClassMethods {
  String tableName = goalTable;
  String subTableName = taskTable;

  static final GoalsDBClass instance = GoalsDBClass._init();

  GoalsDBClass._init();

  Future<List<GoalClass>> getAll() async {
    final db = await instance.database;
    final dbPath = await getDatabasesPath();
    //print(dbPath);
    final List<Map<String, dynamic>> maps =
        await db.query(tableName, orderBy: "createdAt ASC");
    return List.generate(
      maps.length,
      (index) => GoalClass(
          id: maps[index]['id'],
          title: maps[index]['title'],
          createdAt: maps[index]['createdAt']),
    );
  }

  @override
  Future<GoalClass?> getById(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return GoalClass(
          id: maps[0]['id'],
          title: maps[0]['title'],
          createdAt: maps[0]['createdAt']);
    }
    return null;
  }

  @override
  Future<int> insert(dynamic diary) async {
    //print(diary.toString());
    final db = await instance.database;
    //print(diary.toMap());

    return await db.insert(
      tableName,
      diary.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> update(dynamic diary) async {
    final db = await instance.database;

    return await db.update(
      tableName,
      diary.toMap(),
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [diary.id],
    );
  }

  @override
  Future<int> delete(int id) async {
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
