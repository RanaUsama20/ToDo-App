import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_rana/Firebase_utils/Firebase_utils.dart';
import 'package:todo_rana/Home/MyTheme.dart';
import 'package:todo_rana/Task_list/TaskDetailsScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_rana/provider/listProvider.dart';

import '../model/Task.dart';


class TaskListWidget extends StatelessWidget {

    Task task;
    TaskListWidget({required this.task});

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    return  Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children:  [
            SlidableAction(
              borderRadius: BorderRadius.circular(25),
              onPressed:(context) {
                Firebase_Utils.deleteTaskFromFireStore(task).timeout(
                    Duration(milliseconds: 500),
                  onTimeout: () {
                      print('Task deleted successfully');
                      listProvider.getAllTasksFromFirestore();

                    },);
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

          child: InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(TaskDetailsScreen.routeName);
            },
            child: Container(
            height: 150,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyTheme.whiteColor,
            ),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VerticalDivider(
                  width: 1,
                  thickness: 7,
                  indent: 1,
                  endIndent: 0,
                  color: Theme.of(context).primaryColor,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(task.title??'',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).primaryColor
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(task.description??'',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: MyTheme.blackColor)),
                      ),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Icon(Icons.check,
                      color: MyTheme.whiteColor,
                      size: 35),)

              ],
            )
      ),
          )),
    );
  }


}
