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
      throw Exception('Error agregando la tarea, inténtalo de nuevo');
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      await _db.collection('todos').doc(id).delete();
    } catch (e) {
      throw Exception('Error eliminando latarea, inténtalo de nuevo');
    }
  }

  @override
  Future<List<Todo>>? getTodos() {
    try {
      return _db.collection('todos').get().then((event) {
        final todos = <Todo>[];
        for (var doc in event.docs) {
          Todo todo = Todo.fromJson(doc.data());
          todo = todo.copyWith(id: doc.id);
          todos.add(todo);
        }
        return todos;
      });
    } catch (e) {
      throw Exception('Error obteniendo las tareas, inténtalo de nuevo');
    }
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    try {
      await _db.collection('todos').doc(todo.id).update(todo.toJson());
    } catch (e) {
      throw Exception('Error actualizando la tarea, inténtalo de nuevo');
    }
  }
}
