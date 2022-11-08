import 'package:flutter/material.dart';
import 'package:note/screen/add-note/add_note_screen.dart';
import 'package:note/screen/home/home_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "home": (context) => HomeScreen(),
        'add-note': (context) => const AddNoteScreen()
      },
      initialRoute: "home",
    );
  }
}
