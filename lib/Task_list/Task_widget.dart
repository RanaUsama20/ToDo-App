import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_rana/Home/MyTheme.dart';

class TaskListWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children:  [
          SlidableAction(
            borderRadius: BorderRadius.circular(25),
            onPressed:(context) {
            },
            backgroundColor: MyTheme.redColor,
            foregroundColor: MyTheme.whiteColor,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

        child: Container(
        height: 150,
        margin: EdgeInsets.all(12),
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
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Task Title',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).primaryColor
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('description',
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
    ));
  }
}
