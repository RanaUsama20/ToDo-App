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

}