import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(
        transform ?? (e) => e,
      )
          .where(
            (e) => e != null,
          )
          .cast();
}

void testIt() {
  final values = [2, 4, 5, null];
  final nonVal = values.compactMap();
}

const url =
    "https://plus.unsplash.com/premium_photo-1667066301823-53200691b051?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60";

class Third extends HookWidget {
  const Third({super.key});

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(
      () => NetworkAssetBundle(Uri.parse(url))
          .load(url)
          .then((data) => data.buffer.asUint8List())
          .then((data) => Image.memory(data)),
    );
    final snapShot = useFuture(future);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Third Hook"),
      ),
      body: Column(
        children: [
          snapShot.data
          // Image.network(url),
        ].compactMap().toList(),
      ),
    );
  }
}
