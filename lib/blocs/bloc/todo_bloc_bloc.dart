import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yodev_test/domain/models/todo.dart';

part 'todo_bloc_event.dart';
part 'todo_bloc_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
  }

  Future<void> _onLoadTodos(
    LoadTodos event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodosLoading());
    await Future.delayed(const Duration(seconds: 2));
    final todos = [
      Todo(
        id: '1',
        title: 'Tarea 1',
        priority: 1,
        description: 'Descripción de la tarea 1',
        estimatedDate: DateTime.now().add(const Duration(days: 1)),
        isDone: false,
      ),
      Todo(
        id: '2',
        title: 'Tarea 2',
        priority: 2,
        description: 'Descripción de la tarea 2',
        estimatedDate: DateTime.now().add(const Duration(days: 2)),
        isDone: false,
      ),
      Todo(
        id: '3',
        title: 'Tarea 3',
        priority: 3,
        description: 'Descripción de la tarea 3',
        estimatedDate: DateTime.now().add(const Duration(days: 3)),
        isDone: false,
      ),
      Todo(
        id: '4',
        title: 'Tarea 4',
        priority: 1,
        description: 'Descripción de la tarea 4',
        estimatedDate: DateTime.now().add(const Duration(days: 4)),
        isDone: false,
      ),
      Todo(
        id: '5',
        title: 'Tarea 5',
        priority: 2,
        description: 'Descripción de la tarea 5',
        estimatedDate: DateTime.now().add(const Duration(days: 5)),
        isDone: false,
      ),
    ];

    emit(TodosLoaded(todos));
  }

  Future<void> _onAddTodo(
    AddTodo event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final updatedTodos = List<Todo>.from(currentState.todos)
        ..add(
          Todo(
            id: '6',
            title: 'Nueva tarea',
            priority: 1,
            description: 'Descripción de la tarea',
            estimatedDate: DateTime.now().add(const Duration(days: 6)),
            isDone: false,
          ),
        );

      emit(TodosLoaded(updatedTodos));
    } else {
      emit(const TodosError('Error adding todo'));
    }
  }
}
