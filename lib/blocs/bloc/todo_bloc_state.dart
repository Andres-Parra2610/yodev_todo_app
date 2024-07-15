part of 'todo_bloc_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodosLoading extends TodoState {}

class TodoSubmitLoading extends TodoState {}

class TodosLoaded extends TodoState {
  final List<Todo> todos;
  final List<Todo> filteredTodos;

  const TodosLoaded(this.todos, this.filteredTodos);

  @override
  List<Object> get props => [todos, filteredTodos];
}

class TodoSucces extends TodoState {
  final String message;

  const TodoSucces(this.message);

  @override
  List<Object> get props => [message];
}

class TodosError extends TodoState {
  final String message;

  const TodosError(this.message);

  @override
  List<Object> get props => [message];
}
