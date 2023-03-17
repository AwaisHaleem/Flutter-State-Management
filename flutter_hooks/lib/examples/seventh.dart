import 'dart:async';
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
      title: 'Seventh',
      home: const Seventh(),
    );
  }
}

const imagUrl =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdQ6jfWP8xNfe5LjLZWs3pFtWW5Blf4jQD7A&usqp=CAU";

enum Action {
  rotateLeft,
  rotateRight,
  increaseVisibility,
  decreaseVisibility,
}

@immutable
class State {
  final int rotationDeg;
  final double alpha;

  const State({required this.rotationDeg, required this.alpha});

  const State.zero()
      : rotationDeg = 0,
        alpha = 1.0;

  State rotateLeft() => State(rotationDeg: rotationDeg + 10, alpha: alpha);
  State rotateRight() => State(rotationDeg: rotationDeg - 10, alpha: alpha);
  State increaseVisibility() =>
      State(rotationDeg: rotationDeg, alpha: min(alpha + 0.1, 1.0));
  State decreaseVisibility() =>
      State(rotationDeg: rotationDeg, alpha: max(alpha - 0.1, 0.0));
}

State reducer(State oldState, Action? action) {
  switch (action) {
    case Action.rotateLeft:
      return oldState.rotateLeft();
    case Action.rotateRight:
      return oldState.rotateRight();
    case Action.increaseVisibility:
      return oldState.increaseVisibility();
    case Action.decreaseVisibility:
      return oldState.decreaseVisibility();
    case null:
      return oldState;
  }
}

class Seventh extends HookWidget {
  const Seventh({super.key});

  @override
  Widget build(BuildContext context) {
    final store = useReducer<State, Action?>(reducer,
        initialState: const State.zero(), initialAction: null);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Hooks"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                RotateRightButton(store: store),
                RotateLeftButton(store: store),
                IncreaseVisibilityButton(store: store),
                DecreaseVisibilityButton(store: store),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Opacity(
              opacity: store.state.alpha,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(store.state.rotationDeg / 360.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    imagUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class DecreaseVisibilityButton extends StatelessWidget {
  const DecreaseVisibilityButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        store.dispatch(Action.decreaseVisibility);
      },
      child: const Text("- Visibility"),
    );
  }
}

class IncreaseVisibilityButton extends StatelessWidget {
  const IncreaseVisibilityButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        store.dispatch(Action.increaseVisibility);
      },
      child: const Text("+ Visibility"),
    );
  }
}

class RotateLeftButton extends StatelessWidget {
  const RotateLeftButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        store.dispatch(Action.rotateLeft);
      },
      child: const Text("Rotate Left"),
    );
  }
}

class RotateRightButton extends StatelessWidget {
  const RotateRightButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        store.dispatch(Action.rotateRight);
      },
      child: const Text("Rotate Right"),
    );
  }
}
