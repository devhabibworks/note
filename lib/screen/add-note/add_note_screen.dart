import 'package:flutter/material.dart';
import 'package:note/databse/sql_helper.dart';
import 'package:note/screen/home/widgets/note_argument.dart';
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
  bool isFirsTime = true;

  final _formKey = GlobalKey<FormState>();
  Note note = Note();

  @override
  void initState() {
    titleContoller = TextEditingController(text: "");
    bodyController = TextEditingController(text: "");
    sqlHelper = SqlHelper.instence;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NoteArgument argument =
        ModalRoute.of(context)!.settings.arguments as NoteArgument;

    if (argument.type == TYPE.UPDATE && isFirsTime) {
      note.id = argument.note!.id;
      note.title = argument.note!.title;
      note.body = argument.note!.body;
      note.date = argument.note!.date;
      isFirsTime = false;
      titleContoller.text = argument.note!.title;
      bodyController.text = argument.note!.body;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(argument.type == TYPE.NEW ? "Add Note" : "Update Note"),
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
                      if (argument.type == TYPE.NEW) {
                        await sqlHelper.insertNote(note);
                      } else {
                        await sqlHelper.updateNote(note);
                      }

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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      argument.type == TYPE.NEW ? "Save" : "Update",
                      style: const TextStyle(color: Colors.white),
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
