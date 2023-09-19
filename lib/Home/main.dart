import 'package:flutter/material.dart';
import 'package:todo_rana/Home/HomeScreen.dart';
import 'package:todo_rana/Home/MyTheme.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      initialRoute: HomeScreen.routeName ,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),
      },
      theme: MyTheme.lightTheme,
    );
  }

}