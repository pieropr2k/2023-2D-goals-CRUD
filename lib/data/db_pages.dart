import 'package:crud_sqlite_chgpt/data/db.dart';
import 'package:crud_sqlite_chgpt/data/tables.dart';
import 'package:crud_sqlite_chgpt/model/diary.dart';
import 'package:crud_sqlite_chgpt/model/page.dart';
import 'package:sqflite/sqflite.dart';

class PagesDBClass extends DatabaseClass {
  String tableName = pageTable;

  static final PagesDBClass instance = PagesDBClass._init();

  PagesDBClass._init();

  // tiene que haber filtro
  Future<List<PageClass>> getPages(int diaryId) async {
    final db = await instance.database;
    final dbPath = await getDatabasesPath();
    //print(dbPath);
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'diaryId = ?',
      orderBy: "orderIndex ASC",
      whereArgs: [diaryId],
    );
    return List.generate(
      maps.length,
      (index) => PageClass(
        id: maps[index]['id'],
        orderIndex: maps[index]['orderIndex'],
        title: maps[index]['title'],
        content: maps[index]['content'],
        diaryId: maps[index]['diaryId'],
      ),
    );
  }

  Future<PageClass?> getPage(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return PageClass(
        id: maps[0]['id'],
        title: maps[0]['title'],
        content: maps[0]['content'],
        diaryId: maps[0]['diaryId'],
      );
    }
    return null;
  }

  Future<int> insertPage(PageClass page) async {
    final db = await instance.database;
    //print(page.toMap());

    return await db.insert(
      tableName,
      page.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Future<int> updatePage(PageClass page, String attr, value) async {
  Future<int> updatePage(PageClass page) async {
    final db = await instance.database;
    print("Intern update");
    print(page.toMap());
    print(page.id);
    //print(value);

    return await db.update(
      tableName,
      page.toMap(),
      //{attr: value},
      //{"orderIndex": value},
      where: 'id = ?',
      //conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [page.id],
    );
  }

  Future<int> deletePage(int id, {String dependentArg = 'id'}) async {
    //Future<int> deletePage(int id) async {
    final db = await DatabaseClass.instance.database;
    print(id);
    return await db.delete(
      tableName,
      where: '$dependentArg = ?',
      //where: 'id = ?',
      whereArgs: [id],
    );
  }
}
