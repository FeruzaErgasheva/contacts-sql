import 'package:flutter/material.dart';
import 'package:lesson_52/services/local/notes_databse.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final localDatabase = LocalDatabase();
  bool isLoading = false;
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await localDatabase.getNotes();
    setState(() {
      isLoading = false;
    });
  }

  void addNote() async {
    setState(() {
      isLoading = true;
    });
    int id =await localDatabase.addNote("New Note");
    print(id);
    fetchNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text("SQL"),
        actions: [
          IconButton(
            onPressed: addNote,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : notes.isEmpty
              ? Center(child: Text("No notes available"))
              : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return ListTile(
                      title: Text(note['title']),
                      subtitle: Text(note['content']),
                    );
                  },
                ),
    );
  }
}
