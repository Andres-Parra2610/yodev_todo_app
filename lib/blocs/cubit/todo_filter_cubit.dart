import 'package:bloc/bloc.dart';
import 'package:yodev_test/core/enums.dart';

class TodoFilterCubit extends Cubit<TodoFilterEnum> {
  TodoFilterCubit() : super(TodoFilterEnum.all);

  void changeFilter(TodoFilterEnum filter) {
    emit(filter);
  }
}
