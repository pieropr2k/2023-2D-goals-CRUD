import 'package:crud_sqlite_chgpt/data/db_goals.dart';
import 'package:crud_sqlite_chgpt/model/goal.dart';
import 'package:flutter/foundation.dart';

class GoalProvider with ChangeNotifier {
  List<GoalClass> _goals = [];
  List<GoalClass> get goals => _goals;

  GoalProvider() {
    loadAllData();
  }

  Future<void> loadAllData() async {
    _goals = await GoalsDBClass.instance.getAll();
    notifyListeners();
  }

  Future<void> add(GoalClass diary) async {
    _goals = [..._goals, diary];
    await GoalsDBClass.instance.insert(diary);
    //await loadDiaries();
    notifyListeners();
  }

  Future<void> update(GoalClass diary) async {
    await GoalsDBClass.instance.update(diary);
    await loadAllData();
  }

  Future<void> delete(int id) async {
    _goals = _goals.where((page) => page.id != id).toList();
    await GoalsDBClass.instance.delete(id);
    print(id);
    //await loadDiaries();
    notifyListeners();
  }
}
