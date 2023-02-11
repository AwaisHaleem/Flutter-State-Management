import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
      title: 'DateTime',
      home: ApiProvider(api: Api(), child: const HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueKey _textKey = const ValueKey<String?>(null);

  // String title = "Tab the Screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ApiProvider.of(context).api.dateTime ?? ""),
      ),
      body: GestureDetector(
        onTap: () async {
          final api = ApiProvider.of(context).api;
          final dateTime = await api.getDateTime();
          setState(() {
            _textKey = ValueKey(dateTime);
          });
        },
        child: SizedBox.expand(
          child: DateTimeWidget(
            key: _textKey,
          ),
        ),
      ),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return Text(api.dateTime ?? "Tap on screen to Fetch Date and Time");
  }
}

class Api {
  String? dateTime;

  Future<String> getDateTime() {
    return Future.delayed(
            const Duration(seconds: 1), () => DateTime.now().toIso8601String())
        .then((value) {
      dateTime = value;
      return dateTime!;
    });
  }
}

class ApiProvider extends InheritedWidget {
  final Api api;
  final String id;
  ApiProvider({Key? key, required this.api, required Widget child})
      : id = const Uuid().v4(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return id != oldWidget.id;
  }

  static ApiProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}
