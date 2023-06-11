import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtodo/models/todo_models.dart';

import '../controllers/todos_controller.dart';

class AddToDo extends StatelessWidget {
  const AddToDo({super.key});
  @override
  Widget build(BuildContext context) {
    final TodosController todosController = Get.find();
    TextEditingController controller = TextEditingController();
    DateTime selectedDate = DateTime.now();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  hintText: "Add Your Note",
                  filled: true,
                  border: InputBorder.none,
                  fillColor: Colors.teal,
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            Expanded(
              child: CupertinoTheme(
                data: const CupertinoThemeData(brightness: Brightness.dark),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: DateTime.now(),
                  initialDateTime: DateTime.now(),
                  maximumDate:
                      DateTime.now().add(const Duration(days: 365 * 4)),
                  onDateTimeChanged: (value) {
                    selectedDate = value;
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                log(todosController.toDos.length);
                if (controller.text.trim().isEmpty) {
                  Get.snackbar(
                      "Title cannot be empty", "Please type something");
                } else {
                  todosController.toDos
                      .add(Todo(4, controller.text, selectedDate, false));
                  todosController.myIndex.value = 0;
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal)),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
