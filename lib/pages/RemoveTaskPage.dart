
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_app/model/Task.dart';

class RemoveTaskPage extends StatefulWidget {

  final Task _task;

  RemoveTaskPage(this._task);

  @override
  State<StatefulWidget> createState() => RemoveTaskPageState();
}

class RemoveTaskPageState extends State<RemoveTaskPage> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(child: Text("Are you sure you want to remove task: " + widget._task.task,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
          SizedBox(height: 24,),
          _buildOptionButtons(context),
        ],
      ),
    );
  }

  Widget _buildOptionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        MaterialButton(
          onPressed: () {
            SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

            Navigator.of(context).pop(false);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.transparent),
          ),
          padding: EdgeInsets.all(14.0),
          child: Text("No"),
        ),

        MaterialButton(
          onPressed: () {
            SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

            Navigator.of(context).pop(true);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.transparent),
          ),
          textColor: Colors.white,
          color: Colors.redAccent,
          padding: EdgeInsets.all(14.0),
          child: Text("Yes"),
        ),
      ],
    );
  }

}