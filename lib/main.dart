import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yodev_test/blocs/bloc/todo_bloc_bloc.dart';
import 'package:yodev_test/data/repositories/todo/implementations/firebase_todo_repository.dart';
import 'package:yodev_test/ui/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final db = FirebaseFirestore.instance;

  runApp(
    RepositoryProvider(
      create: (context) => FirebaseTodoRepository(db: db),
      child: BlocProvider(
        create: (context) =>
            TodoBloc(todoRepository: context.read<FirebaseTodoRepository>())
              ..add(LoadTodos()),
        child: const MainApp(),
      ),
    ),
  );
}

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
