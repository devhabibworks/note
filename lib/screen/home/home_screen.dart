import 'package:flutter/cupertino.dart';
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
        actions: const [
          Icon(
            CupertinoIcons.search,
            size: 30,
          ),
          SizedBox(
            width: 16,
          ),
          Icon(
            Icons.settings,
            size: 30,
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "add-note");
        },
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        extendedPadding: const EdgeInsets.symmetric(horizontal: 28),
      ),
    );
  }
}
