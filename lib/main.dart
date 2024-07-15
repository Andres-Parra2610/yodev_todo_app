import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yodev_test/blocs/bloc/todo_bloc_bloc.dart';
import 'package:yodev_test/blocs/cubit/todo_filter_cubit.dart';
import 'package:yodev_test/data/repositories/todo/implementations/firebase_todo_repository.dart';
import 'package:yodev_test/ui/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('es_ES', null);
  final db = FirebaseFirestore.instance;

  runApp(
    RepositoryProvider(
      create: (context) => FirebaseTodoRepository(db: db),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TodoFilterCubit(),
          ),
          BlocProvider(
            create: (context) => TodoBloc(
              todoRepository: context.read<FirebaseTodoRepository>(),
              todoFilterCubit: context.read<TodoFilterCubit>(),
            )..add(LoadTodos()),
          ),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      title: 'Flutter Todo App',
      home: const HomeScreen(),
    );
  }
}
