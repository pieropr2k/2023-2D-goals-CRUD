import 'package:crud_sqlite_chgpt/model/goal.dart';
import 'package:crud_sqlite_chgpt/view_model/models_providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final goalInfo = ModalRoute.of(context)!.settings.arguments as GoalClass;
    int goalInfoId = goalInfo.id;
    return Consumer<TasksProvider>(
      builder: (context, tasksProvider, _) {
        //print(diaryInfoId);
        tasksProvider.loadAllData(goalInfoId);
        tasksProvider.diaryId = goalInfoId;
        final tasks = tasksProvider.tasks;
        if (tasks.isEmpty) {
          return Container(
            //width: double.infinity,
            //height: 500,
            //color: Colors.amber,
            alignment: Alignment.center,
            child: const SizedBox(
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
          /*
          Expanded(
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
          */
        }
        return ReorderableListView.builder(
          itemCount: tasks.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Dismissible(
                //key: UniqueKey(),
                key: Key(task.id.toString()),
                onDismissed: (direction) async {
                  await tasksProvider.delete(task.id);
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
                      title: Text(task.title),
                      subtitle: Text(task.content),
                    ),
                    const Divider(
                      height: 0,
                      color: Color.fromRGBO(55, 55, 55, 0.25),
                    ),
                  ],
                ));
          },
          onReorder: (oldIndex, newIndex) async {
            await tasksProvider.updateTasksByDragDrop(oldIndex, newIndex);
          },
        );
      },
    );
  }
}
