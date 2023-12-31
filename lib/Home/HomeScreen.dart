import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_rana/Home/MyTheme.dart';
import 'package:todo_rana/Settings/SettingsTab.dart';
import 'package:todo_rana/Task_list/AddTaskBottomSheet.dart';
import 'package:todo_rana/Task_list/TaskList.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_rana/login/login_screen.dart';
import 'package:todo_rana/provider/listProvider.dart';

import '../provider/auth_provider.dart';


class HomeScreen extends StatefulWidget{
  static const String routeName = 'Home-Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var listProvider = Provider.of<ListProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            listProvider.taskList = [];
            authProvider.currentUser = null;
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          }, icon: Icon(Icons.logout))
        ],
         title: Text( AppLocalizations.of(context)!.todo_list ,
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
            BottomNavigationBarItem(icon: Icon(Icons.list), label: AppLocalizations.of(context)!.list),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: AppLocalizations.of(context)!.settings)
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