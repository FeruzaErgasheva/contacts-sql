import 'package:lesson_52/models/contacts_model.dart';
import 'package:sqflite/sqflite.dart';

class ContactsDatabase {
  ContactsDatabase._singleton();
  static final _contactsDatabase = ContactsDatabase._singleton();
  factory ContactsDatabase() {
    return _contactsDatabase;
  }

  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/conatcts.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute("""
  CREATE TABLE contacts(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    phone INTEGER NOT NULL
  )
""");
  }

  Future<ContactsModel> addContact(
      String name, String surname, int phone) async {
    int id = await _database!
        .insert("contacts", {"name": name, "surname": surname, "phone": phone});
    Map<String, dynamic> contactsJson = {
      "name": name,
      "surname": surname,
      "phone": phone,
      "id": id
    };
    return ContactsModel.fromJson(contactsJson);
  }

  Future<List<Map<String, dynamic>>> getContacts() async {
    final db = await database;
    return await db.query('contacts', orderBy: 'name ASC');
  }
}
