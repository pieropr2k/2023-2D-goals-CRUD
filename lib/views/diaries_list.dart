import 'dart:math';
import 'package:crud_sqlite_chgpt/model/diary.dart';
import 'package:crud_sqlite_chgpt/view_model/models_providers/diary_provider.dart';
import 'package:crud_sqlite_chgpt/views/pages_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiariesListScreen extends StatelessWidget {
  const DiariesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My 2023 goals',
          //'Diaries List',
          style: TextStyle(fontWeight: FontWeight.bold
              //color: Colors.deepPurpleAccent
              ), //<-- SEE HERE
        ),
        backgroundColor: Color.fromARGB(255, 2, 189, 252),
        //toolbarHeight: 50, // default is 56
        elevation: 0,
        shape: const Border(
            bottom:
                BorderSide(color: Color.fromRGBO(244, 10, 158, 1), width: 2.5)),
        //bottom: BorderSide(color: Color.fromRGBO(55, 55, 55, 0.75), width: 1)),
      ),
      //backgroundColor: Colors.red,
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
                  'Personal diary:',
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
          Consumer<DiaryProvider>(
            builder: (context, diaryProvider, _) {
              //await
              //diaryProvider.addDiary(DiaryClass(id: Random().nextInt(1000), title: "Create an app"));
              //diaryProvider.addDiary(DiaryClass(id: Random().nextInt(1000), title: "Be freelance"));
              //diaryProvider.addDiary(DiaryClass(id: Random().nextInt(1000), title: "Be Flutter Dev"));
              //diaryProvider.loadDiaries();
              final diaries = diaryProvider.diaries;
              if (diaries.isEmpty) {
                return Expanded(
                  child: Container(
                    width: double.infinity,
                    //height: 500,
                    //color: Colors.amber,
                    alignment: Alignment.center,
                    child: SizedBox(
                      //alignment: Alignment.center,
                      //width: 200,
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
                /*Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('N'),
                      Text('No diaries found.'),
                    ],
                  ),
                );*/
              }
              return ListView.builder(
                itemCount: diaries.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final diary = diaries[index];
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          ///*
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PagesListScreen(),
                              settings: RouteSettings(arguments: diary),
                            ),
                          );
                          //*/
                        },
                        title: Text(diary.title),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => diaryProvider.deleteTask(diary.id),
                        ),
                      ),
                      const Divider(
                        height: 0,
                        color: Color.fromRGBO(55, 55, 55, 0.25),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTaskDialog(context),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final diariesProvider =
            Provider.of<DiaryProvider>(context, listen: false);
        String diaryTitle = "";
        return AlertDialog(
          title: const Text('Add Diary'),
          content: TextField(
            onChanged: (value) => diaryTitle = value,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                //print(taskTitle);
                await diariesProvider.addDiary(
                    DiaryClass(id: Random().nextInt(1000), title: diaryTitle));
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
