import 'dart:math';
import 'package:crud_sqlite_chgpt/model/diary.dart';
import 'package:crud_sqlite_chgpt/model/page.dart';
import 'package:crud_sqlite_chgpt/view_model/models_providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PagesListScreen extends StatelessWidget {
  const PagesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final diaryInfo = ModalRoute.of(context)!.settings.arguments as DiaryClass;
    int diaryInfoId = diaryInfo.id;
    return Scaffold(
      appBar: AppBar(
        title: Text("'${diaryInfo.title}' Task List:"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 14,
              top: 12,
              bottom: 8,
              right: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'This are your tasks:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 14,
              top: 12,
              bottom: 8,
              right: 14,
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Expanded(
                  child: Text(
                    'This are your personal goals you must achieve this year to annotate:',
                    //overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        //color: Colors.black,
                        //fontSize: 20,

                        //fontWeight: FontWeight.bold,
                        ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 14,
              top: 12,
              bottom: 8,
              right: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'TASKS',
                  style: TextStyle(color: Color(0xffAFB6C8)),
                )
              ],
            ),
          ),
          Consumer<PagesProvider>(
            builder: (context, pagesProvider, _) {
              //print(diaryInfoId);
              pagesProvider.loadPages(diaryInfoId);
              pagesProvider.diaryId = diaryInfoId;
              final pages = pagesProvider.pages;
              if (pages.isEmpty) {
                return Expanded(
                  child: Container(
                    //width: double.infinity,
                    //height: 500,
                    //color: Colors.amber,
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 150,
                      //color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          //Text('N'),
                          Icon(
                            Icons.fitness_center_sharp,
                            size: 50,
                          ),
                          SizedBox(height: 9),
                          Text('No goals found...'),
                          SizedBox(height: 3),
                          Text('Start adding ones.'),
                        ],
                      ),
                    ),
                  ),
                );
                /*return const Center(
                  child: Text('No pages found.'),
                );*/
              }
              return ReorderableListView.builder(
                itemCount: pages.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final page = pages[index];
                  /*return ListTile(
                    key: ValueKey(page),
                    title: Text(page.title),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => pagesProvider.deletePage(page.id),
                    ),
                  );*/
                  return Dismissible(
                      //key: GlobalKey(page.toMap()),
                      //key: UniqueKey(),
                      key: Key(page.id.toString()),
                      //key: Key(page.id.toString()),
                      //onDismissed: (direction) {
                      onDismissed: (direction) async {
                        /*
                  setState(() {
                    items.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Item deleted')),
                  );*/
                        //await pagesProvider.deletePage(page.id);
                        await pagesProvider.deletePage(page.id);
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16.0),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            //key: ValueKey(page),
                            //Key(page.toString()),
                            title: Text(page.title),
                            subtitle: Text(page.content),
                          ),
                          const Divider(
                            height: 0,
                            color: Color.fromRGBO(55, 55, 55, 0.25),
                          ),
                        ],
                      ));
                },
                onReorder: (oldIndex, newIndex) async {
                  await pagesProvider.updateMyTiles(oldIndex, newIndex);
                },
              );
              /*
              return ListView.builder(
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return ListTile(
                    title: Text(page.title),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => pagesProvider.deletePage(page.id),
                    ),
                  );
                },
              );
              */
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTaskDialog(context, diaryInfoId),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, int diaryId) {
    showDialog(
      context: context,
      builder: (context) {
        final pagesProvider =
            Provider.of<PagesProvider>(context, listen: false);
        String pageTitle = "", pageContent = "";
        return AlertDialog(
          title: const Text('Add Page'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) => pageTitle = value,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                onChanged: (value) => pageContent = value,
                decoration: const InputDecoration(
                  labelText: 'Content',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                //print(taskTitle);
                //print(pagesProvider.pages[pagesProvider.pages.length - 1]);
                //print(pagesProvider.pages[pagesProvider.pages.length - 1].orderIndex! +1);
                //print(pagesProvider.pages[pagesProvider.pages.length - 1].orderIndex!);
                await pagesProvider.addPage(PageClass(
                    id: Random().nextInt(1000),
                    orderIndex: pagesProvider.pages.isEmpty
                        ? 0
                        : pagesProvider.pages[pagesProvider.pages.length - 1]
                                .orderIndex! +
                            1,
                    title: pageTitle,
                    content: pageContent,
                    diaryId: diaryId));
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
