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
      () => "Habib",
    );
  }

  SqlHelper sqlHelper = SqlHelper.instence;

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

                print(snapshot.data);
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data![index]);
                    Note note = Note.fromMap(snapshot.data![index]);

                    return ListTile(
                      title: Text("${note.title}"),
                      subtitle: Text("${note.body}"),
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
          // Navigator.pushNamed(context, "add-note");
          addNote().then((value) {
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
