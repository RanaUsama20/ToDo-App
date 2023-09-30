import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Firebase_utils/Firebase_utils.dart';
import '../model/Task.dart';

class ListProvider extends ChangeNotifier{
  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();

  void getAllTasksFromFirestore()async{
    QuerySnapshot<Task> querySnapshot = await Firebase_Utils.getTasksCollection().get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    taskList = taskList.where((task){
      if( task.dateTime?.day == selectedDate.day &&
          task.dateTime?.month == selectedDate.month &&
          task.dateTime?.year == selectedDate.year)
      {
        return true;
      }
      return false;
    }).toList();
    notifyListeners();

  }

  void setNewSelectedDate(DateTime newDate){
    selectedDate = newDate;
    getAllTasksFromFirestore();

  }


}