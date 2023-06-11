import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/todos_controller.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    final TodosController todosController = Get.find();
    return Scaffold(
      body: todosController.favouriteTodos.isEmpty
          ? const Center(
              child: Text(
              "No Todos to show",
              style: TextStyle(color: Colors.white),
            ))
          : Obx(
              () => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: todosController.favouriteTodos.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: todosController
                                .favouriteTodos[index].isCompleted,
                            onChanged: (value) {
                              todosController
                                      .favouriteTodos[index].isCompleted =
                                  !todosController
                                      .favouriteTodos[index].isCompleted;
                              todosController.favouriteTodos.refresh();
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(bottom: 15),
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.teal[200]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        todosController.favouriteTodos
                                            .removeAt(index);
                                       
                                        // todosController.toDos
                                        //     .remove(todosController.toDos[index]);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  todosController.favouriteTodos[index].title,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(todosController.favouriteTodos[index].date
                                    .toString()),
                              ],
                            ),
                            // color: Colors.amber,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
    );
  }
}
