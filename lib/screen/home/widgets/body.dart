import 'package:flutter/material.dart';

import '../../../databse/sql_helper.dart';
import '../../../model/note.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late SqlHelper sqlHelper;

  @override
  void initState() {
    sqlHelper = SqlHelper.instence;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: sqlHelper.getAllNotes(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${note.date}"),
                                const SizedBox(
                                  height: 16,
                                ),
                                InkWell(
                                  onTap: () {
                                    sqlHelper.DeleteNote(note).then((value) {
                                      setState(() {});
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
