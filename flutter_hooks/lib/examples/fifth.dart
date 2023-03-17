import 'dart:math';

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
      title: 'Fifth',
      home: const Fifth(),
    );
  }
}

const imagUrl =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdQ6jfWP8xNfe5LjLZWs3pFtWW5Blf4jQD7A&usqp=CAU";
const imageHeight = 300.0;

class Fifth extends HookWidget {
  const Fifth({super.key});

  @override
  Widget build(BuildContext context) {
    final opacity = useAnimationController(
        duration: const Duration(seconds: 1),
        initialValue: 1.0,
        lowerBound: 0.0,
        upperBound: 1.0);
    final size = useAnimationController(
        duration: const Duration(seconds: 1),
        initialValue: 1.0,
        lowerBound: 0.0,
        upperBound: 1.0);
    final controller = useScrollController();
    useEffect(() {
      controller.addListener(
        () {
          final newOpacity = max(imageHeight - controller.offset, 0.0);
          final normalized = newOpacity.normalized(0.0, imageHeight).toDouble();
          opacity.value = normalized;
          size.value = normalized;
        },
      );
      return null;
    }, [controller]);

    return Scaffold(
      body: Column(children: [
        SizeTransition(
          sizeFactor: size,
          axis: Axis.vertical,
          axisAlignment: -1.0,
          child: FadeTransition(
            opacity: opacity,
            child: Image.network(
              imagUrl,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: controller,
            padding: const EdgeInsets.all(0.0),
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
              title: Text("Person ${index + 1}"),
            ),
          ),
        )
      ]),
    );
  }
}

extension Normalize on num {
  num normalized(num selfRangeMin, num selfRangeMax,
          [num normalizeRangeMin = 0.0, num normalizeRangeMax = 1.0]) =>
      (normalizeRangeMax - normalizeRangeMin) *
      ((this - selfRangeMin) / (selfRangeMax - selfRangeMin));
}
