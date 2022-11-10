import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/databse/sql_helper.dart';
import 'package:note/model/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> getNameFromFuture() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => "Nawaf",
    );
  }

  late SqlHelper sqlHelper;

  Future<int> addNote() {
    return sqlHelper.insertNote(
      Note(
          id: null,
          title: "late",
          body: "Nawaf is late",
          date: DateTime.now().toString()),
    );
  }

  @override
  void initState() {
    sqlHelper = SqlHelper.instence;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "add-note").then((value) {
            setState(() {});
          });
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
