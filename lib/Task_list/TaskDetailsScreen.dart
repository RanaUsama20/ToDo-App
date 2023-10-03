import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_rana/Firebase_utils/Firebase_utils.dart';
import 'package:todo_rana/Home/MyTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_rana/model/Task.dart';
import 'package:todo_rana/provider/auth_provider.dart';
import 'package:todo_rana/provider/listProvider.dart';


class TaskDetailsScreen extends StatefulWidget {
  static const String routeName = 'Details Screen';
  Task updatedTask;
  TaskDetailsScreen({ required this.updatedTask});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    Task updatedTask = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(AppLocalizations.of(context)!.todo_list,
        style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  Text(AppLocalizations.of(context)!.edit_task,
                    textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,),
                  SizedBox(height: 50),
                  Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: titleController,
                              onChanged: (value) {
                              },
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.this_is_title
                              ),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!.task_details,
                              ),
                              maxLines: 4,

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(AppLocalizations.of(context)!.select_time,
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
                            widget.updatedTask.title = titleController.text;
                            widget.updatedTask.description = descriptionController.text;
                            widget.updatedTask.dateTime = selectedDate;
                            var authProvider = Provider.of<AuthProvider>(context,listen: false);
                            Firebase_Utils.EditTaskInFireStore(widget.updatedTask,authProvider.currentUser!.id!)
                                .then((_) {
                              print('Task updated successfully');
                            })
                                .catchError((error) {
                              print('Error updating task: $error');
                            });
                           listProvider.getAllTasksFromFirestore(authProvider.currentUser!.id!);

                          },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(AppLocalizations.of(context)!.save_changes,
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

