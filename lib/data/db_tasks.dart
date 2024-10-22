import 'package:crud_sqlite_chgpt/data/db.dart';
import 'package:crud_sqlite_chgpt/data/tables.dart';
import 'package:crud_sqlite_chgpt/model/task.dart';
import 'package:sqflite/sqflite.dart';

class TasksDBClass extends DatabaseClass implements DatabaseClassMethods {
  String tableName = taskTable;

  static final TasksDBClass instance = TasksDBClass._init();

  TasksDBClass._init();

  // must have a filter diary id
  Future<List<TaskClass>> getAll(int diaryId) async {
    final db = await instance.database;
    //final dbPath = await getDatabasesPath();
    //print(dbPath);
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'diaryId = ?',
      orderBy: "orderIndex ASC",
      whereArgs: [diaryId],
    );
    return List.generate(
        maps.length, (index) => TaskClass.fromJson(maps[index]));
  }

  @override
  Future<TaskClass?> getById(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return TaskClass.fromJson(maps[0]);
    }
    return null;
  }

  @override
  Future<int> insert(dynamic page) async {
    final db = await instance.database;
    //print(page.toMap());
    return await db.insert(
      tableName,
      page.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> update(dynamic page) async {
    final db = await instance.database;
    return await db.update(
      tableName,
      page.toMap(),
      where: 'id = ?',
      //conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [page.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await DatabaseClass.instance.database;
    //print(id);
    return await db.delete(
      tableName,
      //where: '$dependentArg = ?',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
