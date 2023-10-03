import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_rana/model/my_user.dart';

import '../model/Task.dart';

class Firebase_Utils{

  static CollectionReference<Task> getTasksCollection(String uId){
   return
     getUsersCollection().doc(uId).collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore: ((snapshot,actions) => Task.fromFireStore(snapshot.data()!)),
        toFirestore: ((task,options) => task.toFireStore())
    );
  }

  static Future<void> addTaskToFireBase(Task task,String uId){
 var taskCollection = getTasksCollection(uId);
 DocumentReference taskDocRef = taskCollection.doc();
   task.id =  taskDocRef.id;
   return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task,String uId){
    return getTasksCollection(uId).doc(task.id).delete();
  }

  static Future<void> EditTaskInFireStore(Task task,String uId){
    var taskCollection = getTasksCollection(uId);
    var updatedData = task.toFireStore();
    updatedData.remove('id');
    return taskCollection.doc(task.id).update(updatedData);
  }

  static  CollectionReference<MyUser> getUsersCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName).
    withConverter<MyUser>(
      fromFirestore: (snapshot , options) => MyUser.fromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFireStore(),);
  }

  static Future<void> addUserToFireStore(MyUser myUser){
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId)async{
    var querySnapshot = await getUsersCollection().doc(uId).get();
    return querySnapshot.data();
  }

}