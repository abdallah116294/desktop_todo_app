import 'package:desktop_todo_app/main.dart';
import 'package:desktop_todo_app/models/task_model.dart';
import 'package:desktop_todo_app/objectbox.g.dart';
import 'package:desktop_todo_app/screens/task_editor.dart';
import 'package:flutter/material.dart';

import '../widget/coustom_task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Box<TodoEntity> taskeBox = objectBox.store.box<TodoEntity>();
  Box<TodoEntity>? taskBox;
  Stream<List<TodoEntity>>? fetchAllTaske;
  @override
  void initState() {
    super.initState();
    taskBox = objectBox.store.box<TodoEntity>();
    print(taskBox!.count());
   setState(() {
      fetchAllTaske = taskBox!.query().watch(triggerImmediately: true).map((event) => event.find());
   });
  }

  @override
  void dispose() {
    objectBox.store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(19),
          width: MediaQuery.of(context).size.width * .8,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome sir 👋',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Today\'s tasks ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold)),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TaskEditorScreen()));
                        },
                        label: const Text('Add a new Task'),
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
               const  SizedBox(height: 20,), 
                  StreamBuilder<List<TodoEntity>>(
                    stream: fetchAllTaske,
                    builder: (context, snapshot) {
                   if(snapshot.hasData)
                   {
                     return SingleChildScrollView(child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:MainAxisAlignment.start,
                      children:snapshot.data!.map((e) => TaskWidget(e)).toList()) ,);
                   }
                   return const Center(child: CircularProgressIndicator(),);
                  })
                ]),
          ),
        ),
      ),
    );
  }
}
