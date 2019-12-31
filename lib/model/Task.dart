import 'package:flutter_todo_app/model/Date.dart';

class Task {
  final String id;
  final String task;
  final Date date;
  final bool finished;

  const Task(this.id, this.task, this.date, this.finished);
}

class TaskBuilder {
  String id;
  String task;
  Date date;
  bool finished;

  TaskBuilder from(k, v) {
    this.id = k;
    task = v['task'];
    finished = v['finished'];
    date = DateBuilder()
        .year(v['year'])
        .month(v['month'])
        .day(v['day'])
        .build();
    return this;
  }

  Task build() {
    return Task(id, task, date, finished);
  }
}
