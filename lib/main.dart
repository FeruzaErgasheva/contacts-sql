import 'package:flutter/material.dart';
import 'package:lesson_52/controllers/contacts_controller.dart';
import 'package:lesson_52/providers/contacts_provider.dart';
import 'package:lesson_52/views/screens/constacts_screen.dart';
import 'package:lesson_52/views/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ContactsProvider(
      contactsController: ContactsController(),
      child: Builder(
        builder: (context) {
          return ListenableBuilder(
            listenable: ContactsProvider.of(context),
            builder: (context, child) {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: ConstactsScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
