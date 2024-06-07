import 'package:flutter/material.dart';
import 'package:lesson_52/models/contacts_model.dart';
import 'package:lesson_52/services/local/contacts_database.dart';

class ContactsController with ChangeNotifier {
  ContactsDatabase contactsDatabase = ContactsDatabase();
  List<ContactsModel> _contacts = [];

  Future<List<ContactsModel>> get contacts async {
    List<Map<String, dynamic>> contactsList =
        await contactsDatabase.getContacts();
    for (Map<String, dynamic> contactMap in contactsList) {
      _contacts.add(ContactsModel.fromJson(contactMap));
    }
    return [..._contacts];
  }

  void addContact(String name, String surname, int phone) async {
    ContactsModel newContact =
        await contactsDatabase.addContact(name, surname, phone);
    _contacts.add(newContact);
    notifyListeners();
  }
}
