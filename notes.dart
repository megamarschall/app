import 'package:flutter/material.dart';
import '../models/note_model.dart'; // Новая модель
import '../repositories/notes_repository.dart'; // Новый репозиторий

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NotesRepository _notesRepo =
      NotesRepository(); // Заменяем Hive на SQLite-репозиторий
  List<Note> _notes = []; // Список заметок

  @override
  void initState() {
    super.initState();
    _loadNotes(); // Загружаем заметки при старте
  }

  Future<void> _loadNotes() async {
    _notes = await _notesRepo.getAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Заметки')),
      body:
          _notes.isEmpty
              ? const Center(child: Text('Нет заметок.'))
              : ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  final note = _notes[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),
                    onTap: () => _showEditNoteDialog(note),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteNote(note.id!),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder:
          (context) => _NoteDialog(
            onSave: (title, content) async {
              await _notesRepo.addNote(Note(title: title, content: content));
              _loadNotes(); // Перезагружаем список
              Navigator.pop(context);
            },
          ),
    );
  }

  void _showEditNoteDialog(Note note) {
    showDialog(
      context: context,
      builder:
          (context) => _NoteDialog(
            title: note.title,
            content: note.content,
            onSave: (title, content) async {
              await _notesRepo.updateNote(
                Note(id: note.id, title: title, content: content),
              );
              _loadNotes(); // Перезагружаем список
              Navigator.pop(context);
            },
          ),
    );
  }

  Future<void> _deleteNote(int id) async {
    await _notesRepo.deleteNote(id);
    _loadNotes(); // Перезагружаем список
  }
}

// Диалог остаётся без изменений
class _NoteDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final Function(String title, String content) onSave;

  const _NoteDialog({this.title, this.content, required this.onSave});

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = title ?? '';
    _contentController.text = content ?? '';

    return AlertDialog(
      title: Text(title == null ? 'Добавить заметку' : 'Редактировать заметку'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Заголовок'),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(labelText: 'Содержание'),
            maxLines: 5,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            onSave(_titleController.text, _contentController.text);
          },
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
