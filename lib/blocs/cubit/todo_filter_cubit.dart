import 'package:bloc/bloc.dart';
import 'package:yodev_test/core/enums.dart';

/// The TodoFilterCubit is a cubit that manages the filter of the todos
/// It has a state of type [TodoFilterEnum] and a changeFilter method that emits the new filter

class TodoFilterCubit extends Cubit<TodoFilterEnum> {
  TodoFilterCubit() : super(TodoFilterEnum.all);

  void changeFilter(TodoFilterEnum filter) {
    emit(filter);
  }
}
