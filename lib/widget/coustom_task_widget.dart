import 'package:desktop_todo_app/models/task_model.dart';
import 'package:flutter/material.dart';


import '../main.dart';
import '../objectbox.g.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget(this.todoEntity, {Key? key}) : super(key: key);
  TodoEntity todoEntity;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  Box<TodoEntity> taskeBox = objectBox.store.box<TodoEntity>();
  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(15)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Checkbox(
            side: const BorderSide(color: Colors.white),
            value: widget.todoEntity.task_done,
            onChanged: (value) {
              widget.todoEntity.task_done = value;
              taskeBox.put(widget.todoEntity);
            }),
        const SizedBox(
          width: 4,
        ),
      
        Text(
          widget.todoEntity.task_title!,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        Container(width: 10,color: Colors.white,),
        Text(widget.todoEntity.task_description.toString(),style: TextStyle(color: Colors.grey.shade100,fontSize:12,),),
       
        // ListTile(title: Text(widget.todoEntity.task_title!,style: const TextStyle(color: Colors.white, fontSize: 24)),trailing: Text(widget.todoEntity.task_description!,style: TextStyle(color:Colors.grey.shade200,fontSize:16 ),),leading: Text(widget.todoEntity.creation_date.toString()),),
        const Spacer(),
        Expanded(
          child: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              taskeBox.remove(widget.todoEntity.id);
            },
          ),
        )
      ]),
    );
  }
}
// extension DataExtension on DateTime{
// String?  string(String pattern)
// { 
//   try{
//      return  DateFormat(pattern).format(this);
//   }catch(e)
//   {
//    return null;
//   }

// }

// }