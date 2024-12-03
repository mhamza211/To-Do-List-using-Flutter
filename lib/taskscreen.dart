import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/colors.dart';
import 'package:task2/model/taskmodel.dart';
import 'package:task2/taskviewmode.dart';

class Taskscreen extends StatefulWidget {
  const Taskscreen({super.key});

  @override
  State<Taskscreen> createState() => _TaskscreenState();
}

class _TaskscreenState extends State<Taskscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: AppBar(
        backgroundColor: primary,
        leading: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 15,
            child: Icon(Icons.check),
          ),
        ),
        title: const Text(
          "TO-DO-LIST",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Consumer<Taskviewmodel>(
        builder: (context,taskProvider,_) {
          return ListView.separated(
              itemBuilder: (context, index) {
                //task.taskName;
                final task=taskProvider.tasks[index];
                return TaskWidget(task: task,);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                  thickness: 1,
                  color: primary,
                );
              },
              itemCount: taskProvider.tasks.length);
        }
      ),
      floatingActionButton: CustomFAB(),
    );
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.task
  });
final Task task;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      title: Text(
        task.taskName,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      subtitle:  Text(
        "${task.date}, ${task.time}",
        style: TextStyle(fontWeight: FontWeight.bold, color: textBlue),
      ),
    );
  }
}

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDialog();
          },
        );
      },
      backgroundColor: primary,
      child: const Icon(Icons.add, color: Colors.white, size: 40),
    );
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;
    final taskProvider = Provider.of<Taskviewmodel>(context, listen: false);
    return Dialog(
      backgroundColor: secondary,
      child: SizedBox(
        height: sh * 0.6,
        width: sw * 0.8,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: sw * 0.05, vertical: sh * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Create New Tasks",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const Text(
                'What has to be done?',
                style: TextStyle(color: textBlue),
              ),
              CustomTextFeild(
                hint: 'Enter the task ',
                onChanged: (value) {
                  taskProvider.setTaskName(value);
                },
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Due Date',
                style: TextStyle(color: textBlue),
              ),
              CustomTextFeild(
                readOnly: true,
                hint: 'Enter date',
                icon: Icons.calendar_month,
                controller: taskProvider.datecont,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2017),
                      lastDate: DateTime(2030));
                  taskProvider.setDate(date);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFeild(
                readOnly: true,
                hint: 'Enter time',
                icon: Icons.timer,
                controller: taskProvider.timecont,
                onTap: () async {
                  TimeOfDay? time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  taskProvider.setTime(time);
                },
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () async{
                    await taskProvider.addTask();
                    if(context.mounted){
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Create',
                    style: TextStyle(color: primary),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild(
      {super.key,
      required this.hint,
      this.icon = null,
      this.onTap,
      this.readOnly = false,
      this.onChanged,
      this.controller});
  final String hint;
  final IconData? icon;
  final void Function()? onTap;
  final bool readOnly;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
          suffixIcon: InkWell(
              onTap: onTap,
              child: Icon(
                icon,
                color: Colors.white,
              )),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
