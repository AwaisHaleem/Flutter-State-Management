import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Eighth extends HookWidget {
  const Eighth({super.key});

  @override
  Widget build(BuildContext context) {
    late AppLifecycleState state;
    state = useAppLifecycleState()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Hooks"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Opacity(
          opacity: state == AppLifecycleState.resumed ? 1 : 0,
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black45, blurRadius: 10, spreadRadius: 10)
              ],
            ),
            child: Image.asset("assets/images/card.png"),
          ),
        ),
      ),
    );
  }
}
