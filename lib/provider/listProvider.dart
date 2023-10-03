import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Firebase_utils/Firebase_utils.dart';
import '../model/Task.dart';

class ListProvider extends ChangeNotifier{
  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();

  void getAllTasksFromFirestore(String uId)async{
    QuerySnapshot<Task> querySnapshot = await Firebase_Utils.getTasksCollection(uId).get();
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

    taskList.sort((Task task1 , Task task2){
      return task1.dateTime!.compareTo(task2.dateTime!);
    });
    notifyListeners();

  }

  void setNewSelectedDate(DateTime newDate, String uId){
    selectedDate = newDate;
    getAllTasksFromFirestore(uId);

  }



}