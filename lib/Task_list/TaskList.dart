import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_rana/Home/MyTheme.dart';
import 'package:todo_rana/Task_list/Task_widget.dart';


class TaskListTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
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
              return TaskListWidget();
          },
          itemCount: 20,),
        ),
     ],
    );
  }
}
