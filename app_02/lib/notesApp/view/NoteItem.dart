import 'package:flutter/material.dart';
import '../model/Note.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final Function(int) onDelete;
  final Function() onTap;

  NoteItem({required this.note, required this.onDelete, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getColorByPriority(note.priority),
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.content.length > 30
            ? '${note.content.substring(0, 30)}...'
            : note.content),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Xóa ghi chú'),
                  content: Text('Bạn có chắc chắn muốn xóa ghi chú này không?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Hủy'),
                    ),
                    TextButton(
                      onPressed: () {
                        onDelete(note.id!);
                        Navigator.of(context).pop();
                      },
                      child: Text('Xóa'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        onTap: onTap,
      ),
    );
  }

  Color _getColorByPriority(int priority) {
    switch (priority) {
      case 1:
        return Colors.red[100]!;
      case 2:
        return Colors.green[100]!;
      case 3:
        return Colors.blue[100]!;
      default:
        return Colors.white;
    }
  }
}