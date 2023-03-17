import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
      title: 'Sixth',
      home: const Sixth(),
    );
  }
}

const imagUrl =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdQ6jfWP8xNfe5LjLZWs3pFtWW5Blf4jQD7A&usqp=CAU";

class Sixth extends HookWidget {
  const Sixth({super.key});

  @override
  Widget build(BuildContext context) {
    late StreamController<double> controller;
    controller = useStreamController(
      onListen: () {
        controller.sink.add(0.0);
      },
    );

    return Scaffold(
      body: StreamBuilder<double>(
          stream: controller.stream,
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const CircularProgressIndicator();
            } else {
              final rotation = snapShot.data ?? 0.0;
              return RotationTransition(
                turns: AlwaysStoppedAnimation(rotation / 360),
                child: GestureDetector(
                  onTap: () => controller.sink.add(rotation + 10),
                  child: Center(
                    child: SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        imagUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
