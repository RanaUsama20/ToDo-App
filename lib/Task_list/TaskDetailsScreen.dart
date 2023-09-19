import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_rana/Home/MyTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        title: Text(AppLocalizations.of(context)!.todo_list,
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
                            decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!.this_is_title
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
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
                          /// Save Changes
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

