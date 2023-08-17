import 'package:crud_sqlite_chgpt/data/db_pages.dart';
import 'package:crud_sqlite_chgpt/model/page.dart';
import 'package:flutter/foundation.dart';

class PagesProvider with ChangeNotifier {
  int diaryId = 2000;
  List<PageClass> _pages = [];
  List<PageClass> get pages => _pages;

  Future<void> loadPages(int diaryId) async {
    _pages = await PagesDBClass.instance.getPages(diaryId);
    notifyListeners();
  }

  Future<void> addPage(PageClass page) async {
    //await PagesDBClass.instance.insertPage(page);
    print(page.toMap());
    print(page.orderIndex);
    _pages = [..._pages, page];
    await PagesDBClass.instance.insertPage(page);
    notifyListeners();
    //await loadPages(diaryId);
  }

  Future<void> updatePage(PageClass page) async {
    //await PagesDBClass.instance.updatePage(page);
    await loadPages(diaryId);
  }

  Future<void> deletePage(int id) async {
    //await PagesDBClass.instance.deletePage(id);
    _pages = _pages.where((page) => page.id != id).toList();
    //.filter(id => _pages.id);
    await PagesDBClass.instance.deletePage(id);
    //_pages = _pages.where((page) => page.id != id).toList();

    print(id);
    notifyListeners();
    //await loadPages(diaryId);
  }

  ///*
  //void
  Future<void> updateMyTiles(int oldIndex, int newIndex) async {
    // this adjustment is needed when moving down the list
    print("oldIndex: $oldIndex - newIndex: $newIndex");
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    // get the tile we are moving
    PageClass pageToReplace = _pages.removeAt(oldIndex);
    print("Pages Order Before:");
    print(_pages.map((e) => e.toMap()));
    print("Page to Replace:");
    print(pageToReplace.toMap());
    print("Pages oldIndex - newIndex");
    print("oldIndex: $oldIndex - newIndex: $newIndex");

    print("New Pages After:");
    print(pageToReplace.toMap());
    //print(newPage.toMap());
    // place the tile in new position

    print("Pages Order:");
    print(_pages.map((e) => e.toMap()));

    _pages.insert(newIndex, pageToReplace);
    print("New Pages Order:");
    print(_pages.map((e) => e.toMap()));

    for (int i = 0; i < _pages.length; i++) {
      print("item $i:");
      print(_pages[i].toMap());
      //int changes = await PagesDBClass.instance.updatePage(_pages[i], 'orderIndex', i);
      //print(changes);
      _pages[i].orderIndex = i;
      print(_pages[i].toMap());
    }

    print("New Pages Order:");
    print(_pages.map((e) => e.toMap()));

    // You must know about async await
    ///*
    for (final page in _pages) {
      await PagesDBClass.instance.updatePage(page);
      //.updatePage(page, 'orderIndex', page.orderIndex);
    }
    /*
    for (int i = 0; i < _pages.length; i++) {
      //final elemento = _pages[i];
      final index = i; // Crear una copia local del índice
      final elemento = _pages[index];

      print('Comenzando ciclo $index para el elemento: $elemento');

      //await miFuncionAsincrona(elemento);
      await PagesDBClass.instance.updatePage(elemento);
      //await PagesDBClass.instance.updatePage(elemento, 'orderIndex', index);

      print('Terminando ciclo $index para el elemento: $elemento');
    }
    */
    print(_pages.map((e) => e.toMap()));

    notifyListeners();
  }
}
