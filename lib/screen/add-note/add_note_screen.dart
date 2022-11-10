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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: false, signed: false),
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
                  onPressed: () {},
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
