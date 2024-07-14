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
      emit(const TodosLoaded([]));
    }
  }

  Future<void> _onAddTodo(
    AddTodo event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;
    emit(TodoAddLoading());
    if (currentState is TodosLoaded) {
      final allTodos = List<Todo>.from(currentState.todos);
      try {
        final newTodo = await _todoRepository.addTodo(event.todo);
        emit(const TodoSucces('Tarea añadida con éxito'));
        emit(TodosLoaded(allTodos..add(newTodo)));
      } catch (e) {
        emit(TodosError(e.toString()));
        emit(TodosLoaded(allTodos));
        return;
      }
    }
  }
}
