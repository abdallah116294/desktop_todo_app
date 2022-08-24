import 'package:desktop_todo_app/main.dart';
import 'package:desktop_todo_app/models/task_model.dart';
import 'package:desktop_todo_app/objectbox.g.dart';
import 'package:flutter/material.dart';

class TaskEditorScreen extends StatefulWidget {
  const TaskEditorScreen({Key? key}) : super(key: key);

  @override
  State<TaskEditorScreen> createState() => _TaskEditorScreenState();
}

class _TaskEditorScreenState extends State<TaskEditorScreen> {
  Box<TodoEntity> taskeBox = objectBox.store.box<TodoEntity>();
  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _taskDescrptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey.shade900,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: const Text(
          'create a new taske ',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'task title ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _taskTitleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade800,
                      filled: true,
                      hintText: 'Type your Task title ',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'task Description ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _taskDescrptionController,
                  style: const TextStyle(color: Colors.white),
                  minLines: 5,
                  maxLines: 10,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade800,
                      filled: true,
                      hintText: 'Type your Task Description ',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      elevation: 0.0,
                      onPressed: () {
                        String tasktitle = _taskTitleController.text;
                        String taskDescription = _taskDescrptionController.text;
                        TodoEntity model = TodoEntity(
                            task_description: taskDescription,
                            task_title: tasktitle,
                            task_done: false,
                            creation_date: DateTime.now());
                        taskeBox.put(model);
                        Navigator.pop(context);
                      },
                      color: Colors.blue,
                      child: const Text(
                        'save Task',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
