import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  TaskDetailsScreen({required this.task});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late bool _isCompleted;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _isCompleted = widget.task.isCompleted;
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    final updatedTask = widget.task.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
      isCompleted: _isCompleted,
    );

    Provider.of<TaskProvider>(context, listen: false).updateTask(updatedTask);
    _toggleEdit();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Task' : 'Task Details'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveChanges : _toggleEdit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isEditing)
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              )
            else
              Text(
                widget.task.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(height: 20),
            if (_isEditing)
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 5,
              )
            else
              Text(
                widget.task.description,
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Status: ', style: TextStyle(fontWeight: FontWeight.bold)),
                if (_isEditing)
                  Switch(
                    value: _isCompleted,
                    onChanged: (value) {
                      setState(() {
                        _isCompleted = value;
                      });
                    },
                  )
                else
                  Text(
                    widget.task.isCompleted ? 'Completed' : 'Pending',
                    style: TextStyle(
                      color: widget.task.isCompleted ? Colors.green : Colors.orange,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}