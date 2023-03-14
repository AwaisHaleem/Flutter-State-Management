import 'package:flutter/material.dart';
import 'package:hooks/examples/three.dart';
import './examples/second.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      title: 'Flutter Hooks',
      home: const Third(),
    );
  }
}
