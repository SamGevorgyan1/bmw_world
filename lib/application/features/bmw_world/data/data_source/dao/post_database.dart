import 'package:bmw_world/application/core/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bmw_world/application/features/bmw_world/domain/entities/post_entity.dart';

import '../../../../../core/resources/data_state/data_state.dart';


class PostDatabase {
  static final PostDatabase _instance = PostDatabase._internal();

  factory PostDatabase() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  PostDatabase._internal();

  Future<Database> _initDb() async {
    try {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'posts.db');
      return await openDatabase(path, version: 1, onCreate: _onCreate);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute(DatabaseConstants.createPostTableQuery);
    } catch (e) {
      print("Error during table creation: $e");
    }
  }

  Future<DataState<int>> insertPost(PostEntity post) async {
    try {
      Database dbClient = await db;
      int id = await dbClient.insert(DatabaseConstants.postTableName, post.toMap());
      return DataSuccess(id);
    } catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<List<PostEntity>>> getPosts() async {
    try {
      Database dbClient = await db;
      List<Map<String, dynamic>> maps = await dbClient.query(DatabaseConstants.postTableName);
      List<PostEntity> posts = List.generate(maps.length, (index) {
        return PostEntity.fromMap(maps[index]);
      });
      return DataSuccess(posts);
    } catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<int>> updatePost(PostEntity post) async {
    try {
      Database dbClient = await db;
      int rowsAffected = await dbClient.update(
        DatabaseConstants.postTableName,
        post.toMap(),
        where: 'id = ?',
        whereArgs: [post.id],
      );
      return DataSuccess(rowsAffected);
    } catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<int>> deletePost(int id) async {
    try {
      Database dbClient = await db;
      int rowsAffected =
      await dbClient.delete(DatabaseConstants.postTableName, where: 'id = ?', whereArgs: [id]);
      return DataSuccess(rowsAffected);
    } catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<void>> deleteAllPosts() async {
    try {
      Database dbClient = await db;
      await dbClient.delete('Post');
      return DataSuccess(null);
    } catch (e) {
      return DataFailed(e);
    }
  }
}
