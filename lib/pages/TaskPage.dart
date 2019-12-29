import 'package:flutter/material.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TaskPageState();
}

class Date {
  final int year;
  final int month;
  final int day;
  final String weekDay;

  Date(this.year, this.month, this.day, this.weekDay);
}

class DateBuilder {
  int mYear;
  int mMonth;
  int mDay;
  String mWeekDay;

  DateBuilder from(DateTime dateTime) {
    mYear = dateTime.year;
    mMonth = dateTime.month;
    mDay = dateTime.day;
    mWeekDay = DateFormat('EEEE').format(dateTime);
    return this;
  }

  DateBuilder year(int year) {
    mYear = year;
    return this;
  }

  DateBuilder month(int month) {
    mMonth = month;
    return this;
  }

  DateBuilder day(int day) {
    mDay = day;
    return this;
  }

  DateBuilder weekDay(String weekDay) {
    mWeekDay = weekDay;
    return this;
  }

  Date build() {
    return Date(mYear, mMonth, mDay, mWeekDay);
  }
}

class Task {
  final String task;
  final Date date;
  final bool finished;

  const Task(this.task, this.date, this.finished);
}

class TaskPageState extends State<TaskPage> {
  List<Task> _taskList = new List<Task>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: _taskList.length,
      itemBuilder: (context, index) {
        if (_taskList[index].date.day == chosenDate.day) {
          if (_taskList[index].finished)
            return _buildTaskComplete(context, _taskList[index]);
          else
            return _buildTaskUncomplete(context, _taskList[index]);
        } else
          return Container();
      },
    );
  }

  Widget _buildTaskUncomplete(BuildContext context, Task task) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.radio_button_unchecked,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          SizedBox(
            width: 20,
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
      ),
    );
  }

  void addToTaskList(Task task) {
    setState(() {
      _taskList.add(task);
    });
  }
}
