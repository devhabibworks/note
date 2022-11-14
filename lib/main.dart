import 'package:flutter/material.dart';
import 'package:note/screen/add-note/add_note_screen.dart';
import 'package:note/screen/home/home_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  InputDecorationTheme inputDecorationTheme() {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.purple),
      gapPadding: 10,
    );

    OutlineInputBorder outlineInputBorder2 = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.black),
      gapPadding: 10,
    );
    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder2,
      border: outlineInputBorder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: inputDecorationTheme(),
        colorSchemeSeed: Colors.purpleAccent,
      ),
      routes: {
        "home": (context) => const HomeScreen(),
        'add-note': (context) => const AddNoteScreen()
      },
      initialRoute: "home",
    );
  }
}
