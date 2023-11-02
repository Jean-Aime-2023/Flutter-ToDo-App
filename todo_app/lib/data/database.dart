import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{

  List toDoList = [];

  final _myBox = Hive.box('mybox');

  //run this function if this is the first time ever to run / opening this app
  void createInitialData(){
    toDoList=[
      ["Make a tutorial",false],
      ["Do Exercises",false],
    ];
  }

  //load the data from the database
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDataBase(){
    _myBox.put("TODOLIST", toDoList);
  }

}