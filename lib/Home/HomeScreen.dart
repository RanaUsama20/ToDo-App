import 'package:flutter/material.dart';
import 'package:todo_rana/Home/MyTheme.dart';
import 'package:todo_rana/Settings/SettingsTab.dart';
import 'package:todo_rana/Task_list/AddTaskBottomSheet.dart';
import 'package:todo_rana/Task_list/TaskList.dart';

class HomeScreen extends StatefulWidget{
  static const String routeName = 'Home-Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
         title: Text('To Do List',
             style: Theme.of(context).textTheme.titleLarge,),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            selectedIndex = index;
            setState(() {

            });
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
            side: BorderSide(
              color: MyTheme.whiteColor,
              width: 6
            ) ),
          onPressed: (){
          AddTaskBottonSheet();
          }

      ,child: Icon(
          Icons.add,
          size: 30),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
    ,
      body: tabs[selectedIndex],
    );
  }

  List <Widget> tabs = [
    TaskListTab(),SettingsTab()
  ];

  void AddTaskBottonSheet() {
    showModalBottomSheet(context: context,
        builder: (context) => AddTaskBottomSheet());
  }
}