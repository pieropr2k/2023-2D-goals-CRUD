import 'package:crud_sqlite_chgpt/data/db.dart';
import 'package:crud_sqlite_chgpt/data/tables.dart';
import 'package:crud_sqlite_chgpt/model/goal.dart';
import 'package:sqflite/sqflite.dart';

class GoalsDBClass extends DatabaseClass implements DatabaseClassMethods {
  String tableName = goalTable;
  String subTableName = taskTable;

  static final GoalsDBClass instance = GoalsDBClass._init();

  GoalsDBClass._init();

  Future<List<GoalClass>> getAll() async {
    final db = await instance.database;
    //final dbPath = await getDatabasesPath();
    //print(dbPath);
    final List<Map<String, dynamic>> maps =
        await db.query(tableName, orderBy: "id ASC");
    //final List<Map<String, dynamic>> maps = await db.query(tableName, orderBy: "createdAt ASC");
    print(maps);
    return List.generate(
        maps.length, (index) => GoalClass.fromJson(maps[index]));
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
      return GoalClass.fromJson(maps[0]);
    }
    return null;
  }

  @override
  Future<int> insert(dynamic goal) async {
    final db = await instance.database;
    print(goal.toMap());
    //final goalFormatted = goal as GoalClass;
    print(goal.createdAt.toIso8601String());
    return await db.insert(
      tableName,
      goal.toMap(),
      //goalObj,
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
