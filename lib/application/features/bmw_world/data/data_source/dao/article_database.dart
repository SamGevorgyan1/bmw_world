import 'package:bmw_world/application/core/constants/database_constants.dart';
import 'package:bmw_world/application/core/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:path/path.dart';


import '../../../domain/entities/article_entity.dart';

class ArticleDatabase extends BaseDatabase<ArticleEntity> {
  ArticleDatabase() : super(entity: ArticleEntity(), tableName: DatabaseConstants.articleTableName);

  @override
  Future<Database> initDb() async {
    try {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'bmw_world.db');
      return await openDatabase(path, version: 1, onCreate: _onCreate);
    } catch (e) {
      return Future.error(e);
    }
  }
  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute(DatabaseConstants.createArticleTableQuery);
    } catch (e) {
      rethrow;
    }
  }
}
