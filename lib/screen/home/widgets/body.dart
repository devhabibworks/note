import 'package:flutter/material.dart';
import 'package:note/screen/home/widgets/note_argument.dart';

import '../../../databse/sql_helper.dart';
import '../../../model/note.dart';

class Body extends StatelessWidget {
  Function update;
  Body({Key? key, required this.update, required this.futureValue})
      : super(key: key);

  SqlHelper sqlHelper = SqlHelper.instence;
  Future<List<Map<String, dynamic>>> futureValue;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: futureValue,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              // incase there is data

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Note note = Note.fromMap(snapshot.data![index]);

                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        // update
                        Navigator.pushNamed(context, "add-note",
                                arguments:
                                    NoteArgument(type: TYPE.UPDATE, note: note))
                            .then((value) {
                          update();
                          print("update");
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(16).copyWith(bottom: 8),
                        child: ListTile(
                          title: Text("${note.title}"),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${note.body}"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${note.date}"),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      sqlHelper.DeleteNote(note).then((value) {
                                        update();
                                      });
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Icon(Icons.delete)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No Notes Yet"));
            }
        }
      },
    );
  }
}
