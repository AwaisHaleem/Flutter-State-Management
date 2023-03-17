import 'package:flutter/material.dart';
import 'package:hooks/examples/eighth.dart';
import 'package:hooks/examples/fifth.dart';
import 'package:hooks/examples/fourth.dart';
import 'package:hooks/examples/seventh.dart';
import 'package:hooks/examples/sixth.dart';
import 'package:hooks/examples/three.dart';

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
      home: const Eighth(),
    );
  }
}
