const String goalTable = "goal";
const String taskTable = "task";

List get tables => [
      _createTable(
        goalTable,
        "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
        "title TEXT, "
        //"createdAt INTEGER NOT NULL",
        "createdAt TEXT NOT NULL",
        //"createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP"
      ),
      _createTable(
          taskTable,
          "id INTEGER PRIMARY KEY NOT NULL, "
          //"orderNumber INTEGER AUTOINCREMENT NOT NULL, "
          "orderIndex INTEGER, "
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
    //"(1393, 'Be Flutter developer', 1672531200000),"
    "(1672531200000, 'Be Flutter developer', '2022-12-31T19:00:00.000'),"
        //"(1123, 'Get lean', 1672617600000),"
        "(1672617600000, 'Get lean', '2023-01-01T19:00:00.000'),"
        //"(1523, 'Publish my first release', 1672704000000)");
        "(1672704000000, 'Publish my first release', '2023-01-02T19:00:00.000')");
