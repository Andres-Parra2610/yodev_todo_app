part of 'todo_bloc_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;

  const AddTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodoEvent {
  final Todo todo;
  final bool? isToggle;

  const UpdateTodo(this.todo, {this.isToggle = false});

  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodoEvent {
  final Todo todo;

  const DeleteTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class FilterTodos extends TodoEvent {
  final TodoFilterEnum filter;

  const FilterTodos(this.filter);

  @override
  List<Object> get props => [filter];
}
