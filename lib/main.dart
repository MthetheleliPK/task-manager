
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/task.dart';
import 'providers/task_provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/tast_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using ChangeNotifierProvider for state management
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'Flutter Task Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // Setting up named routes for navigation
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/add-task': (context) => AddTaskScreen(),
        },
        // For dynamic routes with parameters
        onGenerateRoute: (settings) {
          if (settings.name == '/task-details') {
            final Task task = settings.arguments as Task;
            return MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(task: task),
            );
          }
          return null;
        },
      ),
    );
  }
}