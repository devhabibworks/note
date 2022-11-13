import 'package:flutter/material.dart';
import 'package:note/databse/sql_helper.dart';
import 'package:note/screen/home/widgets/app_bar.dart';
import 'package:note/screen/home/widgets/body.dart';
import 'package:note/screen/home/widgets/floating_action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SqlHelper sqlHelper;

  @override
  void initState() {
    sqlHelper = SqlHelper.instence;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: const CustomeAppBar(),
        body: Body(
        
          update: () {
            setState(() {});
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomFloating(
          onPressed: () {
            Navigator.pushNamed(context, "add-note").then((value) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => setState(() {}));
            });
          },
        ));
  }
}
