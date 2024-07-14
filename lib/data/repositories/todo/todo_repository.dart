import 'package:yodev_test/domain/models/todo.dart';

abstract class ITodoRepository {
  Future<Todo> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id);
  Future<List<Todo>>? getTodos();
}
