
import 'dart:io';
import 'dart:ui';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final database = db();
const tablePosts = 'posts';

Future<Database> db() async {
  return openDatabase(
    join(await getDatabasesPath(), 'posts_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE IF NOT EXISTS $tablePosts(id INTEGER PRIMARY KEY, title TEXT, tags TEXT, media BLOB)',
      );
    },
    // Version provides path to perform database upgrades and downgrades.
    version: 1,
  );
}
  Future<void> insertPosts(Post post) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Posts into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same Posts is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      tablePosts,
      post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

Future<List<Post>> allPosts() async {
  // Get a reference to the database.
  final Database db = await database;

  // Query the table for all The Posts.
  final List<Map<String, dynamic>> maps = await db.query(tablePosts);

  // Convert the List<Map<String, dynamic> into a List<Posts>.
  return List.generate(
    maps.length,
        (i) {
      return Post(
          id: maps[i]['id'],
          title: maps[i]['title'],
          tags: maps[i]['tags'],
          media: maps[i]['media']);
    },
  );
}



class Post {
  final int? id;
  final String? title;
  final String? tags;
  final File? media;

  Post({this.id, this.title, this.tags, this.media});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'tags': tags,
      'media': media,
    };
  }

  @override
  String toString() {
    return 'Product("id": ${this.id}, "title": ${this.title}, "tags": ${this.tags}, '
        '"media": ${this.media};';
  }
}
