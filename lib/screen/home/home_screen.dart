import 'package:flutter/material.dart';
import 'package:note/databse/sql_helper.dart';
import 'package:note/screen/home/widgets/app_bar.dart';
import 'package:note/screen/home/widgets/body.dart';
import 'package:note/screen/home/widgets/floating_action_button.dart';
import 'package:note/screen/home/widgets/note_argument.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SqlHelper sqlHelper;
  late Future<List<Map<String, dynamic>>> futureValue;

  @override
  void initState() {
    sqlHelper = SqlHelper.instence;
    futureValue = sqlHelper.getAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: CustomeAppBar(
          onChange: ((value) {
            setState(() {
              futureValue = sqlHelper.search(value);
            });
          }),
        ),
        body: Body(
          futureValue: futureValue,
          update: () {
            WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                  futureValue = sqlHelper.getAllNotes();
                }));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomFloating(
          onPressed: () {
            Navigator.pushNamed(context, "add-note",
                    arguments: NoteArgument(type: TYPE.NEW))
                .then((value) {
              WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                    futureValue = sqlHelper.getAllNotes();
                  }));
            });
          },
        ));
  }
}
