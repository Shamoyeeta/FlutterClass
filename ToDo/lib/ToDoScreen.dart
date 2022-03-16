import 'package:flutter/material.dart';
import 'AddToDo.dart';
import 'ToDo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final List<ToDo> _mytodoList = <ToDo>[];
  final firebaseInstance = FirebaseFirestore.instance;

  Future<Object?> _getData() async {
    _mytodoList.clear();
    await firebaseInstance.collection("ToDo_Items").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        _mytodoList.add(ToDo(result.data()["title"],
            result.data()["description"], Color(result.data()["color"])));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Image(
            image: AssetImage('assets/logo.png'),
          ),
          title: const Text("My To-Do List")),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, builder) {
          return ListView.builder(
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
              });
        },
      ),
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
      ToDo resValue = result as ToDo;
      //adding a new value
      firebaseInstance.collection('ToDo_Items').add({
        "title": resValue.title,
        "description": resValue.description,
        "color": resValue.color.value
      }).then((value) {
        print(value.id);
      });

      setState(() {
        //_mytodoList.add(resValue);
      });
    }
  }
}
