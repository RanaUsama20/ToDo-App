import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Firebase_utils/Firebase_utils.dart';
import '../model/Task.dart';

class ListProvider extends ChangeNotifier{
  List<Task> taskList = [];
  void getAllTasksFromFirestore()async{
    QuerySnapshot<Task> querySnapshot = await Firebase_Utils.getTasksCollection().get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();

  }


}