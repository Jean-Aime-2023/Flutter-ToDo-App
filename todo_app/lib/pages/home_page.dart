import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/pages/util/dialog_box.dart';
import 'package:todo_app/pages/util/todoTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  // ignore: unused_field
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {

    //if it is the first time ever to open the app, then create  default data
    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }else{
      db.loadData();
    }
     
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });

    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //create new task method
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
  setState(() {
    db.toDoList.removeAt(index); // Use removeAt to remove by index
  });
  db.updateDataBase();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text("ToDo"),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
              taskName: db.toDoList[index][0],
              taskComplete: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction:(context)=>deleteTask(index), 
          );
        },
      ),
    );
  }
}
