import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:project1/ToDo.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({Key? key}) : super(key: key);

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  Color currentColor = Colors.amber;
  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Item'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.circle,
                      color: currentColor,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Color'),
                              content: SingleChildScrollView(
                                child: BlockPicker(
                                    pickerColor: currentColor,
                                    onColorChanged: changeColor),
                              ),
                            );
                          });
                    }),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Title",
                    ),
                    controller: titleController,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(),
              ),
              controller: descController,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
            ),
            const Padding(
              padding: EdgeInsets.all(30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          ToDo(titleController.text, descController.text,
                              currentColor));
                    },
                    child: const Text("Add")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: const Text("Cancel"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
