import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._singleton();
  static final LocalDatabase _localDatabase = LocalDatabase._singleton();

  factory LocalDatabase() {
    return _localDatabase;
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
    final path = '$databasePath/notes.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute("""
  CREATE TABLE notes(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    created_time INTEGER NOT NULL
  )
""");
  }

  Future<int> addNote(String title) async {
    int id = await _database!.insert("notes", {
      "title": title,
      "content":
          "Consequat est commodo ipsum ex consectetur adipisicing proident est incididunt consectetur sint sit. Magna consectetur mollit ullamco officia duis duis officia nisi tempor veniam deserunt consequat. Nulla occaecat velit adipisicing eu id ad do dolor adipisicing. Et amet qui ipsum eiusmod anim elit. Commodo labore quis esse deserunt non id ex dolore.",
      "created_time": DateTime.now().millisecondsSinceEpoch
    });
    return id;
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database;
    return await db.query('notes', orderBy: 'created_time DESC');
  }
}

void main(List<String> args) {
  LocalDatabase localDatabase = LocalDatabase();
  localDatabase.addNote("reading books");
}
