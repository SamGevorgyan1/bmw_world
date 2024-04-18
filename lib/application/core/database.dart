import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:sqflite/sqflite.dart';

import 'resources/converter/data_converter.dart';

abstract class BaseDatabase<E extends DataConverter> {
  E entity;
  final String tableName;

  BaseDatabase({
    required this.entity,
    required this.tableName,
  });

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb();

  Future<DataState<List<E>>> getAll() async {
    try {
      Database dbClient = await db;
      List<Map<String, dynamic>> maps = await dbClient.query(tableName);
      List<E> data = List.generate(maps.length, (index) {
        return entity.fromMap(maps[index]);
      });
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<void>> deleteAll() async {
    try {
      Database dbClient = await db;
      await dbClient.delete(tableName);
      return const DataSuccess(null);
    } catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<int>> insert(E entity) async {
    try {
      Database dbClient = await db;
      int id = await dbClient.insert(tableName, entity.toMap());
      return DataSuccess(id);
    } catch (e) {
      return DataFailed(e);
    }
  }
}
