import 'package:flutter/material.dart';
import 'AddToDo.dart';
import 'ToDo.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final List<ToDo> _mytodoList = <ToDo>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My To-Do List")),
      body: ListView.builder(
          itemCount: _mytodoList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_mytodoList[index].title),
              subtitle: Text(_mytodoList[index].description),
              leading: Icon(
                Icons.circle_rounded,
                color: _mytodoList[index].color,
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _addNewItem(context);
        },
        tooltip: "Add New",
      ),
    );
  }

  void _addNewItem(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddToDo()),
    );
    if (result != null) {
      setState(() {
        _mytodoList.add(result);
      });
    }
  }
}
