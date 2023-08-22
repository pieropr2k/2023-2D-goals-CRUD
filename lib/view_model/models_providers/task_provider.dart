import 'package:crud_sqlite_chgpt/data/db_tasks.dart';
import 'package:crud_sqlite_chgpt/model/task.dart';
import 'package:flutter/foundation.dart';

class TasksProvider with ChangeNotifier {
  int diaryId = 2000;
  List<TaskClass> _tasks = [];
  List<TaskClass> get tasks => _tasks;

  Future<void> loadAllData(int diaryId) async {
    _tasks = await TasksDBClass.instance.getAll(diaryId);
    notifyListeners();
  }

  Future<void> addPage(TaskClass page) async {
    _tasks = [..._tasks, page];
    await TasksDBClass.instance.insert(page);
    notifyListeners();
    //await loadPages(diaryId);
  }

  Future<void> updatePage(TaskClass page) async {
    await TasksDBClass.instance.update(page);
    await loadAllData(diaryId);
  }

  Future<void> deletePage(int id) async {
    _tasks = _tasks.where((page) => page.id != id).toList();
    //.filter(id => _pages.id);
    await TasksDBClass.instance.delete(id);
    notifyListeners();
    //await loadPages(diaryId);
  }

  Future<void> updateTasksByDragDrop(int oldIndex, int newIndex) async {
    // this adjustment is needed when moving down the list
    //print("oldIndex: $oldIndex - newIndex: $newIndex");
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    // get the tile we are moving
    TaskClass pageToReplace = _tasks.removeAt(oldIndex);
    _tasks.insert(newIndex, pageToReplace);

    for (int i = 0; i < _tasks.length; i++) {
      _tasks[i].orderIndex = i;
    }

    // You must know about async await
    for (final task in _tasks) {
      await TasksDBClass.instance.update(task);
    }
    notifyListeners();
  }
}
