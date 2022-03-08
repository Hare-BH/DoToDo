import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoey_flutter/models/tasks_box.dart';
import 'add_task_screen.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/widgets/soft_button.dart';
//import 'package:todoey_flutter/models/task.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    Box tasksBox = Provider.of<TasksBox>(context).tasksBox;
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(
          Icons.add,
          color: _darkMode ? Colors.black87 : Colors.white,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(),
              ),
            ),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _darkMode = !_darkMode;
                    });
                  },
                  child: SoftButton(
                    isPressed: _darkMode,
                    icon: _darkMode ? Icons.lightbulb_outline : Icons.lightbulb,
                    color: _darkMode ? Colors.black87 : Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'DoToDo',
                  style: TextStyle(
                    color: _darkMode ? Colors.black87 : Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${tasksBox.length} Tasks',
                  style: TextStyle(
                    color: _darkMode ? Colors.black87 : Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: _darkMode ? Colors.black87 : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: _buildListView(),
            ),
          ),
        ],
      ),
    );
  }

  ListView _buildListView() {
    Box tasksBox = Provider.of<TasksBox>(context).tasksBox;
    TasksBox tasksBoxMethods = Provider.of<TasksBox>(context, listen: false);

    return ListView.builder(
        itemCount: tasksBox.length,
        itemBuilder: (context, index) {
          final task = tasksBox.getAt(index);
          return ListTile(
            title: Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(0.8),
                borderRadius: BorderRadius.circular(5),
              ),
              message: 'Long press to delete',
              child: Text(
                task.name,
                style: _lineThrough(task.isDone),
              ),
            ),
            trailing: Checkbox(
              value: task.isDone,
              checkColor: _darkMode ? Colors.black87 : Colors.white,
              activeColor: Colors.deepOrange,
              onChanged: (bool? value) {
                tasksBoxMethods.updateTask(index, task, check: true);
              },
            ),
            onLongPress: () {
              tasksBoxMethods.deleteTask(index);
            }, //delete
            // onTap: () {
            //   tasksBoxMethods.updateTask(index, Task('${task.name}*'));
            // },
            //edit
          );
        });
  }

  TextStyle _lineThrough(bool isDone) {
    if (isDone)
      return TextStyle(
        color: _darkMode ? Colors.deepOrange : Colors.black87,
        decoration: TextDecoration.lineThrough,
      );
    else
      return TextStyle(
        color: _darkMode ? Colors.deepOrange : Colors.black87,
      );
  }
}
