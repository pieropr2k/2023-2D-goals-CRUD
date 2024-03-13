import 'package:crud_sqlite_chgpt/view_model/models_providers/goal_provider.dart';
import 'package:crud_sqlite_chgpt/views/screens/tasks/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoalList extends StatelessWidget {
  const GoalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalProvider>(
      builder: (context, goalProvider, _) {
        //diaryProvider.loadDiaries();
        final diaries = goalProvider.goals;
        if (diaries.isEmpty) {
          return Container(
            width: double.infinity,
            //height: 500,
            //color: Colors.amber,
            alignment: Alignment.center,
            child: const SizedBox(
              //alignment: Alignment.center,
              //width: 200,
              height: 150,
              //color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
          );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TasksScreen(),
                        settings: RouteSettings(arguments: diary),
                      ),
                    );
                  },
                  title: Text(diary.title),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => goalProvider.delete(diary.id),
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
    );
  }
}
