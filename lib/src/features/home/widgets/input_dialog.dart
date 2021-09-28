import 'package:flutter/material.dart';

import '../../../domain/model/task_item.dart';

class InputDialog extends StatefulWidget {
  final TaskItem? task;
  final bool isEditing;
  const InputDialog({
    Key? key,
    this.task,
    required this.isEditing,
  }) : super(key: key);

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final _titleController = TextEditingController();
  final _subtilteController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void _submitData() {
    if (_titleController.text.isNotEmpty &&
        _subtilteController.text.isNotEmpty) {
      Navigator.of(context).pop(
        TaskItem(
          id: widget.isEditing ? widget.task!.id : DateTime.now().toString(),
          title: _titleController.text,
          subtitle: _subtilteController.text,
          isComplete: widget.isEditing ? widget.task!.isComplete : false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _subtilteController.text = widget.task!.subtitle;
    }
    _titleController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _titleController.text.length,
      ),
    );
    return SimpleDialog(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 20.0,
      ),
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Row(
        children: [
          Text(
            widget.isEditing ? 'Edit Task' : 'Add Task',
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.cancel,
              color: Colors.grey,
              size: 30.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      children: [
        const Divider(),
        TextFormField(
          controller: _titleController,
          style: const TextStyle(
            fontSize: 18,
            height: 1.5,
            color: Colors.white,
          ),
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Title',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
        ),
        TextFormField(
          controller: _subtilteController,
          style: const TextStyle(
            fontSize: 18,
            height: 1.5,
            color: Colors.white,
          ),
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Subtitle',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          child: TextButton(
            child: Text(
              widget.isEditing == false ? 'Add' : 'Save',
            ),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              primary: Colors.white,
            ),
            onPressed: _submitData,
          ),
        ),
      ],
    );
  }
}
