import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_rana/Home/MyTheme.dart';

class TaskDetailsScreen extends StatefulWidget {
  static const String routeName = 'Details Screen';

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('To Do List',
        style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.05),
        decoration: BoxDecoration(
          color: MyTheme.whiteColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Edit Task',textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,),
                SizedBox(height: 50),
                Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'This is Title'
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Task Details',
                            ),
                            maxLines: 4,

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Select Time',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w400

                            ),),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {

                            showCalender();

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${formatDate(selectedDate)}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: MyTheme.grayColor
                              ),),
                          ),
                        ),
                        SizedBox(height: 100),
                        ElevatedButton(onPressed: (){
                          /// Save Changes
                        },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Save Changes',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color:  MyTheme.whiteColor,
                                ),
                              ),
                            ))



                      ],
                    )),
              ],
            ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  void showCalender() async{
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null ){
      selectedDate = chosenDate;

      setState(() {

      });

    }

  }
}
