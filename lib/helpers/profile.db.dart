import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final database = db();
const profileTables = 'profiles';

Future<Database> db() async {
  return openDatabase(
    join(await getDatabasesPath(), 'profile_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE IF NOT EXISTS $profileTables(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, phone TEXT)',
      );
    },
    // Version provides path to perform database upgrades and downgrades.
    version: 1,
  );
}

Future<void> insertProfile(Profile profile) async {
  // Get a reference to the database.
  final Database db = await database;

  // Insert the Profile into the correct table. Also specify the
  // `conflictAlgorithm`. In this case, if the same profile is inserted
  // multiple times, it replaces the previous data.
  await db.insert(
    profileTables,
    profile.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> updateProfile(Profile profile) async {
  // Get a reference to the database.
  final db = await database;

  // Update the given Profile.
  await db.update(
    profileTables,
    profile.toMap(),
    // Ensure that the Profile has a matching id.
    where: "id = ?",
    // Pass the Profile's id as a whereArg to prevent SQL injection.
    whereArgs: [profile.id],
  );
}

Future<void> deleteProfile(int id) async {
  // Get a reference to the database.
  final db = await database;

  // Remove the Profile from the database.
  await db.delete(
    profileTables,
    // Use a `where` clause to delete a specific profile.
    where: "id = ?",
    // Pass the profile's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}

class Profile{
  late int? id;
  late String? firstName;
  late String? lastName;
  late String? email;
  late String? phone;

  Profile({this.id,this.firstName, this.lastName, this.email, this.phone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
    };
  }

  @override
  String toString() {
    return 'Profile("id": ${this.id}, "firstName": ${this.firstName}, "lastName": ${this.lastName}, '
        '"email": ${this.email}, "phone":${this.phone});';
  }

}

