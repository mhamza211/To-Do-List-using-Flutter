import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/taskscreen.dart';
import 'package:task2/taskviewmode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>Taskviewmodel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Taskscreen(),
      ),
    );
  }
}
