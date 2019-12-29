import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(child: Text("Add new task",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
          SizedBox(height: 24,),
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                labelText: "Enter task name"
            ),
          ),
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

            Navigator.of(context).pop();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.transparent),
          ),
          padding: EdgeInsets.all(14.0),
          child: Text("Close"),
        ),

        MaterialButton(
          onPressed: () {
            SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

            if( textEditingController.text.isNotEmpty)
              Navigator.pop(context, textEditingController.text);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.transparent),
          ),
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(14.0),
          child: Text("Save"),
        ),
      ],
    );
  }


}