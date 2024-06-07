import 'package:flutter/material.dart';
import 'package:lesson_52/controllers/contacts_controller.dart';

class ContactsProvider extends InheritedWidget {
  final ContactsController contactsController;
  const ContactsProvider(
      {super.key, required super.child, required this.contactsController});

  @override
  bool updateShouldNotify(covariant ContactsProvider oldWidget) {
    return oldWidget.contactsController != contactsController;
  }

  static ContactsController of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ContactsProvider>()!
        .contactsController;
  }
}