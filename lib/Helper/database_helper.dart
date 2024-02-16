import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/food_recipe_model.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'recipes';

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    // final databasesPath = await getDatabasesPath();
    // final path = join(databasesPath, 'recipes.db');

    return await openDatabase(
      'recipes.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE recipeTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            imageUrl TEXT,
            icon TEXT
          )
        ''');
      },
    );
  }

  /// insert record
  static Future createItem(
      String name, String description, String imageUrl) async {
    final db = await DatabaseHelper.initDatabase();

    final data = {
      'name': name,
      'description': description,
      'imageUrl': imageUrl
    };
    final id = await db.insert('recipeTable', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(id);
    return id;
  }

  /// get data from database
  static Future getItems() async {
    List<FoodRecipe> recipeList = [];
    final db = await DatabaseHelper.initDatabase();
    var data = await db.query('recipeTable', orderBy: 'id');
    print(data);
    for (var e in data) {
      recipeList.add(FoodRecipe.fromJson(e));
    }
    return recipeList;
  }

  /// get items by id
  static Future getItemById(int id) async {
    final db = await DatabaseHelper.initDatabase();
    List<FoodRecipe> recipeList = [];
    var data = await db.query('recipeTable', where: "id=?", whereArgs: [id]);
    for (var e in data) {
      //recipeList.add(FoodRecipe.fromJson(e));
    }
    return recipeList;
  }

  /// update item
  static Future updateItem(int id, String title, String description) async {
    final db = await DatabaseHelper.initDatabase();
    final data = {'title': title, 'description': description};
    final result =
        await db.update('recipeTable', data, where: "id=?", whereArgs: [id]);
    return result;
  }

  ///delete item
  static Future deleteItem(int id) async {
    final db = await DatabaseHelper.initDatabase();
    try {
      await db.delete('recipeTable', where: "id=?", whereArgs: [id]);
    } catch (e) {
      rethrow;
    }
  }
}
