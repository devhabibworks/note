import 'package:flutter/material.dart';

import '../../model/note.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late TextEditingController titleContoller;
  late TextEditingController bodyController;
  final _formKey = GlobalKey<FormState>();
  Note note = Note();

  @override
  void initState() {
    titleContoller = TextEditingController(text: "");
    bodyController = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(),
              TextFormField(),
            ],
          ),
        ),
      ),
    );
  }
}
