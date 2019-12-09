import "dart:async";
import "dart:io";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:sqflite/sqflite.dart";

final shopTABLE = "Shop";

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveShop.db is our database instance name
    final String path = join(documentsDirectory.path, "ReactiveShop.db");
    final database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE IF NOT EXISTS $shopTABLE ("
        "id INTEGER PRIMARY KEY, "
        "hash TEXT UNIQUE, "
        "name TEXT, "
        "phone_number TEXT, "
        "address TEXT, "
        "status TEXT, "
        "rating INTEGER, "
        "String TEXT, "
        "image TEXT, "
        "image_big TEXT, "
        "latitude REAL, "
        "longitude REAL, "
        "category TEXT"
        ")");
  }

  void dispose() {}
}
