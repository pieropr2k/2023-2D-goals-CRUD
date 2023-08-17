import 'package:crud_sqlite_chgpt/data/db_diaries.dart';
import 'package:crud_sqlite_chgpt/model/diary.dart';
import 'package:flutter/foundation.dart';

class DiaryProvider with ChangeNotifier {
  List<DiaryClass> _diaries = [];
  List<DiaryClass> get diaries => _diaries;

  DiaryProvider() {
    loadDiaries();
  }

  Future<void> loadDiaries() async {
    _diaries = await DiariesDBClass.instance.getDiaries();
    notifyListeners();
  }

  Future<void> addDiary(DiaryClass diary) async {
    _diaries = [..._diaries, diary];
    await DiariesDBClass.instance.insertDiary(diary);
    //await loadDiaries();
    notifyListeners();
  }

  Future<void> updateDiary(DiaryClass diary) async {
    await DiariesDBClass.instance.updateDiary(diary);
    await loadDiaries();
  }

  Future<void> deleteTask(int id) async {
    _diaries = _diaries.where((page) => page.id != id).toList();
    await DiariesDBClass.instance.deleteDiary(id);
    print(id);
    //await loadDiaries();
    notifyListeners();
  }
}
