const String diaryTable = "diary";
const String pageTable = "page";

List get tables => [
      _createTable(
        diaryTable,
        "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
        //"order_number INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "title TEXT",
        //"(1393, 'Be Flutter developer')"
        //    "(1123, 'Get lean')"
      ),
      _createTable(
          pageTable,
          "id INTEGER PRIMARY KEY NOT NULL, "
          //"orderNumber INTEGER AUTOINCREMENT NOT NULL, "
          "orderIndex INTEGER, "
          //"date TEXT,"
          "title TEXT, "
          "content TEXT, "
          "diaryId INTEGER, "
          "FOREIGN KEY(diaryId) REFERENCES $diaryTable (id)"
          //, null
          )
    ];

_createTable(String table, String columns) {
  return "CREATE TABLE IF NOT EXISTS $table ($columns)";
}

_insertTable(String table, String columns, String values) {
  return "INSERT INTO $table ($columns) VALUES $values";
}

String get insertScript => _insertTable(
    diaryTable,
    "id,"
        "title",
    "(1393, 'Be Flutter developer'),"
        "(1123, 'Get lean'),"
        "(1523, 'Publish my first release')");
