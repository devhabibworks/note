import 'package:flutter/material.dart';
import 'package:note/databse/sql_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqlHelper sqlHelper = SqlHelper.instence;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: const [Icon(Icons.search), Icon(Icons.settings)],
      ),
    );
  }
}
