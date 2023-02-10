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
      title: 'Contact Book',
      home: const HomePage(),
      routes: {"/new-contac": (context) => const NewContact()},
    );
  }
}

class Contact {
  final String id;
  final String name;
  Contact({
    required this.name,
  }) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance() : super([]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  // List<Contact> _contacts = []; No more need after value notifier
  // now value contains data

  int get length => value.length;

  void add({required Contact contact}) {
    final contacts = value;
    contacts.add(contact);
    notifyListeners();
  }

  void remove({required Contact contact}) {
    final contacts = value;
    contacts.remove(contact);
    notifyListeners();
  }

  Contact? contact({required int atIndex}) {
    return value.length > atIndex ? value[atIndex] : null;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacs"),
      ),
      body: ValueListenableBuilder(
          valueListenable: ContactBook(),
          builder: (context, value, child) {
            final contacts = value;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final Contact contact = contacts[index];
                return Dismissible(
                  key: ValueKey(contact.id),
                  onDismissed: (direction) {
                    ContactBook().remove(contact: contact);
                  },
                  child: Material(
                    color: Colors.white,
                    elevation: 6.0,
                    child: ListTile(
                      title: Text(contact.name),
                    ),
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/new-contac");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NewContact extends StatefulWidget {
  const NewContact({super.key});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  late final TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Contact"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            decoration:
                const InputDecoration(hintText: "Enter a new contact ..."),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text;
              final contact = Contact(name: name);
              ContactBook().add(contact: contact);
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
