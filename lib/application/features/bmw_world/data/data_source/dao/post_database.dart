import 'package:bmw_world/application/core/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../../../core/database.dart';
import '../../../domain/entities/post_entity.dart';

class PostDatabase extends BaseDatabase<PostEntity> {
   PostDatabase() : super(entity: PostEntity(), tableName: DatabaseConstants.postTableName);

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
      await db.execute(DatabaseConstants.createPostTableQuery);
    } catch (e) {
      rethrow;
    }
  }
}
