import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  TaskList({required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(
        child: Text('No tasks found'),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (ctx, index) {
        final task = tasks[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(task.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                  ),
                  onPressed: () {
                    Provider.of<TaskProvider>(context, listen: false)
                        .toggleTaskStatus(task.id);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () {
                    Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Task deleted')),
                    );
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/task-details',
                arguments: task,
              );
            },
          ),
        );
      },
    );
  }
}
