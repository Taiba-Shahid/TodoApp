import 'package:get/get.dart';
import '../models/todo_models.dart';

class TodosController extends GetxController {
  final RxInt myIndex = 0.obs;
  final RxList<Todo> toDos = <Todo>[].obs;
  final RxList<Todo> favouriteTodos = <Todo>[].obs;
}
