import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/AddTaskPage.dart';
import 'package:flutter_todo_app/pages/TaskPage.dart';
import 'package:flutter_todo_app/shapes/BottomBackgroundShape.dart';
import 'package:flutter_todo_app/shapes/TopBackgroundShape.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color.fromRGBO(3, 218, 153, 1),
      ),
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ToDoListState();
}

final taskPageKey = GlobalKey<TaskPageState>();
Date chosenDate = DateBuilder()
    .year(DateTime.now().year)
    .month(DateTime.now().month)
    .day(DateTime.now().day)
    .weekDay(DateFormat('EEEE').format(DateTime.now()))
    .build();

class ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          BottomBackgroundShape(),
          TopBackgroundShape(),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.dehaze,
                        color: Colors.black,
                        size: 40.0,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              _buildMainContent(context)
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Color.fromRGBO(3, 218, 153, 1),
        onPressed: () async {
          String result = await showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: AddTaskPage(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                );
              });

          if (result.isNotEmpty)
            taskPageKey.currentState.addToTaskList(Task(result, chosenDate, false));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                chosenDate.weekDay,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                chosenDate.day.toString(),
                style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 112,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: _buildTopButtons(context),
        ),
        Container(
            height: MediaQuery.of(context).size.height - 315,
            child: TaskPage(
              key: taskPageKey,
            ))
      ],
    );
  }

  Widget _buildTopButtons(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: MaterialButton(
            elevation: 0,
            onPressed: () {},
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).accentColor),
                borderRadius: BorderRadius.circular(12)),
            color: Colors.white,
            textColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(14.0),
            child: Text("Tasks"),
          ),
        ),
        SizedBox(
          width: 32,
        ),
        Expanded(
          child: MaterialButton(
            elevation: 0,
            onPressed: () => _selectDate(context),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            padding: EdgeInsets.all(14.0),
            child: Text("Calendar"),
          ),
        ),
      ],
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1999),
        lastDate: DateTime(2100),
        initialDate: DateTime.now());

    if (pickedDate != null) {
      setState(() {
        chosenDate = DateBuilder().from(pickedDate).build();
      });
    }
  }
}
