import 'package:crud_sqlite_chgpt/model/goal.dart';
import 'package:crud_sqlite_chgpt/model/task.dart';
import 'package:crud_sqlite_chgpt/view_model/models_providers/task_provider.dart';
import 'package:crud_sqlite_chgpt/views/screens/tasks/widgets/task_list.dart';
import 'package:crud_sqlite_chgpt/views/widgets/list_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final goalInfo = ModalRoute.of(context)!.settings.arguments as GoalClass;
    int goalInfoId = goalInfo.id;
    return Scaffold(
      appBar: AppBar(
        title: Text("'${goalInfo.title}' Task List:"),
        elevation: 0,
      ),
      body: const Column(
        children: [
          ListInfoWidget(
            title: "These are your tasks:",
            content: "These are your tasks to achieve this goal:",
            subtitle: "TASKS",
          ),
          //TaskList()
          Expanded(child: TaskList())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTaskDialog(context, goalInfoId),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, int diaryId) {
    showDialog(
      context: context,
      builder: (context) {
        final tasksProvider =
            Provider.of<TasksProvider>(context, listen: false);
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
                await tasksProvider.add(TaskClass(
                    id: DateTime.now().millisecondsSinceEpoch,
                    orderIndex: DateTime.now().millisecondsSinceEpoch,
                    /*
                    orderIndex: tasksProvider.tasks.isEmpty
                        ? 0
                        : tasksProvider.tasks[tasksProvider.tasks.length - 1]
                                .orderIndex! +
                            1,
                    */
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
