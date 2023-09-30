import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_rana/Firebase_utils/Firebase_utils.dart';
import 'package:todo_rana/Home/MyTheme.dart';
import 'package:todo_rana/Task_list/Task_widget.dart';
import 'package:todo_rana/provider/listProvider.dart';

import '../model/Task.dart';
import '../provider/listProvider.dart';


class TaskListTab extends StatefulWidget {

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    if(listProvider.taskList.isEmpty) {
      listProvider.getAllTasksFromFirestore();
    }
    return Column(
      children: [
        CalendarTimeline(
          initialDate: listProvider.selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (selectedDate){
            listProvider.setNewSelectedDate(selectedDate);
          },
          leftMargin: 20,
          monthColor: MyTheme.blackColor,
          dayColor: MyTheme.blackColor,
          activeDayColor: MyTheme.whiteColor,
          activeBackgroundDayColor: Theme.of(context).primaryColor,
          dotsColor: Color(0xFF333A47),
          locale: 'en_ISO',
        ),
        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskListWidget( task: listProvider.taskList[index],);
          },
          itemCount: listProvider.taskList.length,),
        ),
     ],
    );
  }
}
