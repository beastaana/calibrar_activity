import 'package:calibrar_activity/logic/model/reddit_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String redditTable = 'reddit';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;
  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('reddit.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $redditTable ("
    _id INTEGER PRIMARY KEY AUTOINCREMENT, "
    community_name TEXT NOT NULL,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    date TEXT NOT NULL,
    subtitle TEXT NOT NULL,
    )
''');
  }

  Future<RedditModel> create(RedditModel redditModel) async {
    final db = await instance.database;
    final id = await db.insert(redditTable, redditModel.toJson());
    return redditModel.copy(id: id);
  }

  Future<RedditModel> readRedditPost({required int id}) async {
    final db = await instance.database;

    final maps = await db.query(
      redditTable,
      columns: RedditFields.values,
      where: '${RedditFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RedditModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<RedditModel>> readAllRedditPosts() async {
    final db = await instance.database;
    const orderBy = '${RedditFields.id} ASC';
    final result = await db.query(redditTable, orderBy: orderBy);

    return result.map((json) => RedditModel.fromJson(json)).toList();
  }

  Future<int> update({required RedditModel redditModel}) async {
    final db = await instance.database;

    return db.update(
      redditTable,
      redditModel.toJson(),
      where: '${RedditFields.id} = ?',
      whereArgs: [redditModel.id],
    );
  }

  Future<int> delete({required int id}) async {
    final db = await instance.database;

    return await db.delete(
      redditTable,
      where: '${RedditFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}