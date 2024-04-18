final class DatabaseConstants {
  // Articles
  static const String articleTableName = 'articles';
  static const String createArticleTableQuery = '''
    CREATE TABLE $articleTableName (
      id INTEGER PRIMARY KEY,
      title TEXT,
      mainImage TEXT,
      mainContent TEXT
    )
  ''';

  // Posts
  static const String postTableName = 'posts';
  static const String createPostTableQuery = '''
    CREATE TABLE $postTableName (
      id INTEGER PRIMARY KEY,
      title TEXT,
      content TEXT,
      likes INTEGER,
      carId INTEGER,
      imageUrl TEXT,
      createdAt TEXT
    )
  ''';
}
 