import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yodev_test/data/repositories/todo/todo_repository.dart';
import 'package:yodev_test/domain/models/todo.dart';

class FirebaseTodoRepository implements ITodoRepository {
  final FirebaseFirestore _db;

  const FirebaseTodoRepository({required FirebaseFirestore db}) : _db = db;

  @override
  Future<Todo> addTodo(Todo todo) async {
    try {
      final newTodo = await _db.collection('todos').add(todo.toJson());
      return todo.copyWith(id: newTodo.id);
    } catch (e) {
      throw Exception('Error adding todo, try again');
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      await _db.collection('todos').doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting todo, try again');
    }
  }

  @override
  Future<List<Todo>>? getTodos() {
    try {
      return _db.collection('todos').get().then((event) {
        final todos = <Todo>[];
        for (var doc in event.docs) {
          final todo = Todo.fromJson(doc.data());
          todo.copyWith(id: doc.id);
          todos.add(todo);
        }
        return todos;
      });
    } catch (e) {
      throw Exception('Error getting todos, try again');
    }
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    try {
      _db.collection('todos').doc(todo.id).update(todo.toJson());
    } catch (e) {
      throw Exception('Error updating todo, try again');
    }
  }
}
