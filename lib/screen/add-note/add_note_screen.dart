import 'package:flutter/material.dart';
import 'package:note/backupcode.dart';

import '../../model/note.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late TextEditingController titleContoller;
  late TextEditingController bodyController;

  late SqlHelper sqlHelper;
  final _formKey = GlobalKey<FormState>();
  Note note = Note();

  @override
  void initState() {
    titleContoller = TextEditingController(text: "");
    bodyController = TextEditingController(text: "");
    sqlHelper = SqlHelper.instance;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: titleContoller,
                  onChanged: (value) {
                    setState(() {
                      note.title = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "title",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    validator: ((value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "Body is Required";
                      }
                    }),
                    onChanged: (value) {
                      setState(() {
                        note.body = value;
                      });
                    },
                    controller: bodyController,
                    decoration: InputDecoration(
                        hintText: "write your note",
                        helperText: "required",
                        counter: Text("${bodyController.text.length}")),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.purple,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      note.date = DateTime.now().toString();
                      await sqlHelper.insertNote(note);
                      setState(() {
                        titleContoller.text = "";
                        bodyController.text = "";
                        note = Note();
                      });

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Added Succeffluy"),
                      ));
                      Navigator.pop(context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
