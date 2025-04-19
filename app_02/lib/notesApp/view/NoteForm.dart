import 'package:flutter/material.dart';
import '../db/NoteDatabaseHelper.dart';
import '../model/Note.dart';

class NoteForm extends StatefulWidget {
  final Note? note;

  NoteForm({this.note});

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;
  late int _priority;
  late String? _color;
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _title = widget.note!.title;
      _content = widget.note!.content;
      _priority = widget.note!.priority;
      _color = widget.note!.color;
      _tags = widget.note!.tags ?? [];
    } else {
      _title = '';
      _content = '';
      _priority = 1; // Mặc định là ưu tiên thấp
      _color = null;
    }
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final note = Note(
        id: widget.note?.id,
        title: _title,
        content: _content,
        priority: _priority,
        createdAt: widget.note?.createdAt ?? DateTime.now(),
        modifiedAt: DateTime.now(),
        tags: _tags,
        color: _color,
      );
      Navigator.pop(context, note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Thêm Ghi Chú' : 'Sửa Ghi Chú'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Tiêu đề'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tiêu đề';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
                maxLines: null, // Cho phép nội dung kéo dài xuống nhiều dòng
                minLines: 3,
              ),
              TextFormField(
                initialValue: _content,
                decoration: InputDecoration(labelText: 'Nội dung'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập nội dung';
                  }
                  return null;
                },
                onSaved: (value) {
                  _content = value!;
                },
              ),
              DropdownButtonFormField<int>(
                value: _priority,
                decoration: InputDecoration(labelText: 'Mức độ ưu tiên'),
                items: [
                  DropdownMenuItem(value: 1, child: Text('note ưu tiên thấp')),
                  DropdownMenuItem(value: 2, child: Text('note ưu tiên trung bình')),
                  DropdownMenuItem(value: 3, child: Text('note ưu tiên cao')),
                ],
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
              ),


              // Thêm một Color Picker nếu cần
              // ...
            ],
          ),
        ),
      ),
    );
  }
}