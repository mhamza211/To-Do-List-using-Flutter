import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task2/model/taskmodel.dart';

class Taskviewmodel extends ChangeNotifier {
  List<Task> tasks = [];
  String? taskName;
  final datecont = TextEditingController();
  final timecont = TextEditingController();
  setTaskName(String value) {
    taskName = value;
    log(value.toString());
    notifyListeners();
  }

  setDate(DateTime? date) {
    if (date == null) {
      return;
    }
    log(date.toString());
    DateTime currentDate = DateTime.now();
    DateTime now =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    int diff = date.difference(now).inDays;
    if (diff == 0) {
      datecont.text = 'Today';
    } else if (diff == 1) {
      datecont.text = 'tommorow';
    } else {
      datecont.text = "${date.day}-${date.month}-${date.year}";
    }
    notifyListeners();
  }

  setTime(TimeOfDay? time) {
    log(time.toString());
    if (time == null) {
      return;
    }
    if (time.hour == 0) {
      timecont.text = '12${time.minute} AM';
    } else if (time.hour < 12) {
      timecont.text = "${time.hour}:${time.minute} AM";
    } else if (time.hour == 12) {
      timecont.text = "${time.hour}:${time.minute} PM";
    } else {
      timecont.text = "${time.hour - 12}:${time.minute} PM";
    }
    notifyListeners();
  }

  bool get isValid =>
      taskName != null && datecont.text.isNotEmpty && timecont.text.isNotEmpty;
  addTask() {
    if (!isValid) {
      return;
    }
    final task = Task(taskName!, datecont.text, timecont.text);
    tasks.add(task);
    timecont.clear();
    datecont.clear();
    log(tasks.length.toString());
    notifyListeners();
  }
}
