abstract class DatabaseConstants {
  // Article
  static const String article = 'articles';


  // Posts
  static const String postTableName = 'posts';
  static const String createPostTableQuery = '''
    CREATE TABLE $postTableName (
      id INTEGER PRIMARY KEY,
      content TEXT,
      likes INTEGER,
      carId INTEGER,
      imageUrl TEXT,
      createdAt TEXT
    )
  ''';
}
 