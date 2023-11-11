import 'package:flutter/material.dart';
import 'package:notes_app/models/note_data.dart';

class NoteDetailsScreen extends StatefulWidget {
  final NoteData? data;
  final Function(NoteData) onSave;

  const NoteDetailsScreen(
      {super.key, required this.data, required this.onSave});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  Color? currentNoteColor;

  @override
  void initState() {
    final data = widget.data;
    if (data != null) {
      titleController.text = data.title;
      contentController.text = data.content;
      currentNoteColor = data.color;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentNoteColor,
      appBar: AppBar(
        backgroundColor: currentNoteColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                widget.onSave(
                  NoteData(
                    title: titleController.text,
                    content: contentController.text,
                    color: currentNoteColor,
                  ),
                );
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.check),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration.collapsed(
                hintText: "Title",
              ),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextField(
                  controller: contentController,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Content",
                  ),
                  minLines: null,
                  maxLines: null,
                  expands: true,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              height: 80,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: noteColors
                    .map((color) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                currentNoteColor = color;
                              });
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              color: color,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

final noteColors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.grey,
];
