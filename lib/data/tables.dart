const String goalTable = "goal";
const String taskTable = "task";

List get tables => [
      _createTable(
        goalTable,
        "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
        //"order_number INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "title TEXT, "
        "createdAt INTEGER NOT NULL",
        //"createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP"
      ),
      _createTable(
          taskTable,
          "id INTEGER PRIMARY KEY NOT NULL, "
          //"orderNumber INTEGER AUTOINCREMENT NOT NULL, "
          "orderIndex INTEGER, "
          //"date TEXT,"
          "title TEXT, "
          "content TEXT, "
          "diaryId INTEGER, "
          "FOREIGN KEY(diaryId) REFERENCES $goalTable (id)")
    ];

_createTable(String table, String columns) {
  return "CREATE TABLE IF NOT EXISTS $table ($columns)";
}

_insertTable(String table, String columns, String values) {
  return "INSERT INTO $table ($columns) VALUES $values";
}

String get insertScript => _insertTable(
    goalTable,
    "id, "
        "title, "
        "createdAt",
    "(1393, 'Be Flutter developer', 1672531200000),"
        "(1123, 'Get lean', 1672617600000),"
        "(1523, 'Publish my first release', 1672704000000)");
