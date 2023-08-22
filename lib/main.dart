import 'package:crud_sqlite_chgpt/view_model/models_providers/goal_provider.dart';
import 'package:crud_sqlite_chgpt/view_model/models_providers/task_provider.dart';
import 'package:crud_sqlite_chgpt/views/screens/goals/goals_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoalProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TasksProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Your App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DiariesScreen(),
        //home: const DiariesListScreen(),
      ),
    );
  }
}
