import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newtodo/date.dart';
import 'package:newtodo/screens/addtodo.dart';
import 'package:newtodo/screens/favourite.dart';
import 'package:newtodo/screens/home.dart';

import 'controllers/todos_controller.dart';

// TODOs: While working with Getx

// 1. Dont use StatefulWidget
// 2. Dont use SetState
// 3. Dont pass data via constructor

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF333A47),
      ),
      title: "ToDo App",
      home: const HomePage(),
    );
  }
}

class HomePage extends GetView<TodosController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TodosController());

    final screen = [
      const Home(),
      const AddToDo(),
      const Favourite(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF333A47),
        leading: const Icon(Icons.dehaze),
        title: Center(
            child: Text(
          " ${getCurrentDate()}",
          style: const TextStyle(fontSize: 15),
        )),
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 13),
            child: Icon(Icons.account_balance_rounded),
          )
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => Center(
            child: screen.elementAt(controller.myIndex.value),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
              elevation: 13,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.teal,
              unselectedItemColor: Colors.white,
              backgroundColor: const Color(0xFF333A47),
              mouseCursor: MaterialStateMouseCursor.clickable,
              onTap: (index) {
                controller.myIndex.value = index;
              },
              currentIndex: controller.myIndex.value,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.grey,
                    ),
                  ),
                  label: "",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "",
                ),
              ])),
    );
  }
}
