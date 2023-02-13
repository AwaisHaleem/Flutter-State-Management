import 'package:flutter/material.dart';

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
      title: 'Opacity Changer',
      home: const HomePage(),
    );
  }
}

final sliderData = SliderData();

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheritedNotifier(
      {Key? key, required Widget child, required SliderData sliderData})
      : super(
          key: key,
          notifier: sliderData,
          child: child,
        );

  static double of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()
          ?.notifier
          ?.value ??
      0.0;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Opacity changer."),
      ),
      body: SliderInheritedNotifier(
        sliderData: sliderData,
        child: Builder(builder: (context) {
          return Column(
            children: [
              Slider.adaptive(
                value: SliderInheritedNotifier.of(context),
                onChanged: (value) {
                  sliderData.setValue = value;
                },
              ),
              Row(
                children: [
                  Opacity(
                    opacity: SliderInheritedNotifier.of(context),
                    child: Container(
                      height: 180,
                      color: Colors.yellow,
                    ),
                  ),
                  Opacity(
                    opacity: SliderInheritedNotifier.of(context),
                    child: Container(
                      height: 180,
                      color: Colors.blue,
                    ),
                  )
                ].expandEqually().toList(),
              )
            ],
          );
        }),
      ),
    );
  }
}

class SliderData extends ChangeNotifier {
  double _value = 0.0;

  get value => _value;

  set setValue(double newValue) {
    if (newValue != _value) {
      _value = newValue;
      notifyListeners();
    }
  }
}

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() => map((w) => Expanded(child: w));
}
