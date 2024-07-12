import 'package:flutter/material.dart';
import 'package:yodev_test/ui/screens/screens.dart';

void main() => runApp(const MainApp());

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
