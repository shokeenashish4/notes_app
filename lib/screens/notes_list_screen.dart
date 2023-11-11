import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/models/note_data.dart';
import 'package:notes_app/screens/note_details_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({
    super.key,
  });

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final List<NoteData> notesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDetailsScreen(
                data: null,
                onSave: (data) {
                  setState(() {
                    notesList.add(data);
                  });
                },
              ),
            ),
          );
        },
        tooltip: "Add a note",
        child: const Icon(Icons.add),
      ),
      body: notesList.isEmpty
          ? const Center(
              child: Text(
                "No notes found! Please create a new note by tapping the '+' "
                "icon below",
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                left: 8,
                top: 8,
                right: 8,
              ),
              child: MasonryGridView.count(
                itemCount: notesList.length,
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteDetailsScreen(
                            data: notesList[index],
                            onSave: (data) {
                              setState(() {
                                notesList[index] = data;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                                  const Text("Confirm deletion? Pakka bolo?"),
                              content: const Text(
                                "Are you sure you want to delete this note?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("No"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      notesList.removeAt(index);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            );
                          });
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: notesList[index].color,
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          right: 32,
                          bottom: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notesList[index].title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                notesList[index].content,
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
