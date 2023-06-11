import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtodo/controllers/todos_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // late DateTime _selectedDate;
  // void _resetSelectedDate() {
  //   _selectedDate = DateTime.now().add(const Duration(days: 2));
  // }

  @override
  Widget build(BuildContext context) {
    final TodosController todosController = Get.find();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Manage your \nTasks',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.tealAccent[100], fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 0.8),
            child: CalendarTimeline(
              showYears: true,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
              onDateSelected: (selecteddate) {
                todosController.toDos.value = todosController.toDos
                    .where((todo) => todo.date == selecteddate)
                    .toList();
              },
              leftMargin: 20,
              monthColor: Colors.white70,
              dayColor: Colors.teal[200],
              dayNameColor: const Color(0xFF333A47),
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              dotsColor: const Color(0xFF333A47),
              locale: 'en',
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: todosController.toDos.isEmpty
                ? const Center(
                    child: Text(
                    "No Todos to show",
                    style: TextStyle(color: Colors.white),
                  ))
                : Obx(
                    () => ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: todosController.toDos.length,
                        itemBuilder: (context, index) {
                          RxBool isFavourite = todosController.favouriteTodos
                              .contains(todosController.toDos[index])
                              .obs;
                          return Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value:
                                      todosController.toDos[index].isCompleted,
                                  onChanged: (value) {
                                    todosController.toDos[index].isCompleted =
                                        !todosController
                                            .toDos[index].isCompleted;
                                    todosController.toDos.refresh();
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              todosController.toDos
                                                  .removeAt(index);
                                              // todosController.toDos
                                              //     .remove(todosController.toDos[index]);
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            ),
                                          ),
                                          InkWell(
                                            child: Icon(
                                              Icons.favorite,
                                              color: isFavourite.value
                                                  ? Colors.red
                                                  : Colors.white,
                                            ),
                                            onTap: () {
                                              todosController.favouriteTodos
                                                  .insert(
                                                      0,
                                                      todosController
                                                          .toDos[index]);
                                            },
                                          ),
                                        ],
                                      ),
                                      Text(
                                        todosController.toDos[index].title,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(todosController.toDos[index].date
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
          ),
        ],
      ),
    );
  }
}
