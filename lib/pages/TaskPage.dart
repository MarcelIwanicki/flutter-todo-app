import 'package:flutter/material.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/model/Task.dart';
import 'package:flutter_todo_app/service/FirestoreService.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  FirestoreService firestoreService;
  List<Task> _taskList = new List<Task>();

  TaskPageState() {
    firestoreService = FirestoreService(uid: 'to-do-app-34d2c');
  }

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  void _loadList() async {
    _taskList = await firestoreService.getTaskList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: _taskList.length,
      itemBuilder: (context, index) {
        if (_taskList[index].date.equals(chosenDate)) {
          if (_taskList[index].finished)
            return _buildTaskComplete(context, _taskList[index]);
          else
            return _buildTaskIncomplete(context, _taskList[index]);
        } else
          return Container();
      },
    );
  }

  Widget _buildTaskIncomplete(BuildContext context, Task task) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              task.finished = true;
              firestoreService.updateTask(task);
              setState(() {});
            },
            icon: Icon(
              Icons.radio_button_unchecked,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
          ),
          Text(
            task.task,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskComplete(BuildContext context, Task task) {
    return Container(
      foregroundDecoration: BoxDecoration(color: Color(0x60fdfdfd)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.radio_button_checked,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(task.task),

              ],
            ),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () => _showRemoveDialog(context, task),
                  icon: Icon(
                      Icons.delete_forever
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void addToTaskList(Task task) {
    setState(() {
      _taskList.add(task);
      firestoreService.addTask(task);
    });
  }

  void _showRemoveDialog(BuildContext context, Task task) {
    setState(() {
      _taskList.remove(task);
      firestoreService.deleteTask(task.id);
    });
  }
}
