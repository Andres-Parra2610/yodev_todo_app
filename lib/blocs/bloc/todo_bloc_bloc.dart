import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yodev_test/data/repositories/todo/todo_repository.dart';
import 'package:yodev_test/domain/models/todo.dart';

part 'todo_bloc_event.dart';
part 'todo_bloc_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ITodoRepository _todoRepository;

  TodoBloc({required ITodoRepository todoRepository})
      : _todoRepository = todoRepository,
        super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
  }

  Future<void> _onLoadTodos(
    LoadTodos event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodosLoading());
    try {
      final todos = await _todoRepository.getTodos();

      if (todos == null) return;

      emit(TodosLoaded(todos));
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  Future<void> _onAddTodo(
    AddTodo event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final updatedTodos = List<Todo>.from(currentState.todos);

      emit(TodosLoaded(updatedTodos));
    } else {
      emit(const TodosError('Error adding todo'));
    }
  }
}
