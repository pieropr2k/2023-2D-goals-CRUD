import 'package:crud_sqlite_chgpt/model/goal.dart';
import 'package:crud_sqlite_chgpt/view_model/models_providers/goal_provider.dart';
import 'package:crud_sqlite_chgpt/views/screens/goals/widgets/goal_list.dart';
import 'package:crud_sqlite_chgpt/views/widgets/list_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiariesScreen extends StatelessWidget {
  const DiariesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My 2023 goals',
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
      body: const Column(
        children: [
          ListInfoWidget(
            title: "Personal diary:",
            content:
                "These are your personal goals you must achieve this year to annotate:",
            subtitle: "GOALS",
          ),
          GoalList()
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
            Provider.of<GoalProvider>(context, listen: false);
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
                final timeRightNow = DateTime.now();
                //print(timeRightNow.microsecondsSinceEpoch);
                //print(timeRightNow.toIso8601String());
                // use the dart console
                await diariesProvider.add(
                  GoalClass(
                    id: timeRightNow.microsecondsSinceEpoch,
                    title: diaryTitle,
                    //createdAt: timeRightNow.millisecondsSinceEpoch
                  ),
                );
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
