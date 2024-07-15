import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yodev_test/blocs/cubit/todo_filter_cubit.dart';
import 'package:yodev_test/core/enums.dart';
import 'package:yodev_test/data/repositories/todo/todo_repository.dart';
import 'package:yodev_test/domain/models/todo.dart';

part 'todo_bloc_event.dart';
part 'todo_bloc_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ITodoRepository _todoRepository;
  final TodoFilterCubit _todoFilterCubit;

  late final StreamSubscription _filterSubscription;

  TodoBloc(
      {required ITodoRepository todoRepository,
      required TodoFilterCubit todoFilterCubit})
      : _todoRepository = todoRepository,
        _todoFilterCubit = todoFilterCubit,
        super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<FilterTodos>(_onFilterTodos);

    _filterSubscription = _todoFilterCubit.stream.listen((filter) {
      add(FilterTodos(filter));
    });
  }

  Future<void> _onLoadTodos(
    LoadTodos event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodosLoading());
    try {
      final todos = await _todoRepository.getTodos();

      if (todos == null) return;

      emit(TodosLoaded(todos, _applyCurrentFilter(todos)));
    } catch (e) {
      emit(TodosError(e.toString()));
      emit(const TodosLoaded([], []));
    }
  }

  Future<void> _onAddTodo(
    AddTodo event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;
    emit(TodoSubmitLoading());
    if (currentState is TodosLoaded) {
      final allTodos = List<Todo>.from(currentState.todos);
      try {
        final newTodo = await _todoRepository.addTodo(event.todo);
        emit(const TodoSucces('Tarea añadida con éxito'));
        _todoFilterCubit.changeFilter(TodoFilterEnum.all);
        emit(TodosLoaded(allTodos..add(newTodo),
            _applyCurrentFilter(allTodos..add(newTodo))));
      } catch (e) {
        emit(TodosError(e.toString()));
        emit(TodosLoaded(allTodos, allTodos));
        return;
      }
    }
  }

  Future<void> _onUpdateTodo(
    UpdateTodo event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      List<Todo> allTodos = List<Todo>.from(currentState.todos);
      try {
        await _todoRepository.updateTodo(event.todo);
        if (!event.isToggle!) {
          emit(const TodoSucces('Tarea actualizada con éxito'));
        }
        allTodos = allTodos
            .map((todo) => todo.id == event.todo.id ? event.todo : todo)
            .toList();
        emit(TodosLoaded(allTodos, _applyCurrentFilter(allTodos)));
      } catch (e) {
        emit(TodosError(e.toString()));
        emit(TodosLoaded(allTodos, _applyCurrentFilter(allTodos)));
      }
    }
  }

  Future<void> _onDeleteTodo(
    DeleteTodo event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      List<Todo> allTodos = List<Todo>.from(currentState.todos);
      try {
        await _todoRepository.deleteTodo(event.todo.id!);
        allTodos = allTodos.where((todo) => todo.id != event.todo.id).toList();
        emit(const TodoSucces('Tarea eliminada con éxito'));
        emit(TodosLoaded(allTodos, _applyCurrentFilter(allTodos)));
      } catch (e) {
        emit(TodosError(e.toString()));
        emit(TodosLoaded(allTodos, _applyCurrentFilter(allTodos)));
      }
    }
  }

  Future<void> _onFilterTodos(
    FilterTodos event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final filteredTodos = _applyCurrentFilter(currentState.todos);
      emit(TodosLoaded(currentState.todos, filteredTodos));
    }
  }

  List<Todo> _applyCurrentFilter(List<Todo> todos) {
    TodoFilterEnum currentFilter = _todoFilterCubit.state;
    switch (currentFilter) {
      case TodoFilterEnum.done:
        return todos.where((todo) => todo.isDone).toList();
      case TodoFilterEnum.undone:
        return todos.where((todo) => !todo.isDone).toList();
      case TodoFilterEnum.all:
      default:
        return todos;
    }
  }

  @override
  Future<void> close() {
    _filterSubscription.cancel();
    return super.close();
  }
}
