import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../model/Task.dart';

class Firebase_Utils{

  static CollectionReference<Task> getTasksCollection(){
   return FirebaseFirestore.instance.collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore: ((snapshot,actions) => Task.fromFireStore(snapshot.data()!)),
        toFirestore: ((task,options) => task.toFireStore())
    );
  }

  static Future<void> addTaskToFireBase(Task task){
 var taskCollection = getTasksCollection();
 DocumentReference taskDocRef = taskCollection.doc();
   task.id =  taskDocRef.id;
   return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task){
    return getTasksCollection().doc(task.id).delete();
  }

  static Future<void> EditTaskInFireStore(Task task){
    var taskCollection = getTasksCollection();
    var updatedData = task.toFireStore();
    updatedData.remove('id');
    return taskCollection.doc(task.id).update(updatedData);
  }

}