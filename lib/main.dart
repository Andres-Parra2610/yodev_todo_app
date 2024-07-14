import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yodev_test/blocs/bloc/todo_bloc_bloc.dart';
import 'package:yodev_test/ui/screens/screens.dart';

void main() => runApp(
      BlocProvider(
        create: (context) => TodoBloc()..add(LoadTodos()),
        child: const MainApp(),
      ),
    );

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo App',
      home: HomeScreen(),
    );
  }
}
