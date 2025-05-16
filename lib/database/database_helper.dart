import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'finch_app.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create tables here
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        description TEXT,
        date TEXT NOT NULL,
        type TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE savings_goals(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        target_amount REAL NOT NULL,
        current_amount REAL NOT NULL,
        target_date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE social_payments(
        id TEXT PRIMARY KEY,
        amount REAL NOT NULL,
        currency TEXT NOT NULL,
        senderId TEXT NOT NULL,
        senderName TEXT NOT NULL,
        participants TEXT NOT NULL, -- Store participants list as JSON string
        description TEXT NOT NULL,
        date TEXT NOT NULL,
        status TEXT NOT NULL,
        message TEXT,
        imageUrl TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE carbon_footprints(
        id TEXT PRIMARY KEY,
        transactionId TEXT NOT NULL,
        carbonAmount REAL NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL,
        details TEXT -- Store details map as JSON string
      )
    ''');

    await db.execute('''
      CREATE TABLE sustainable_investments(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        returnRate REAL NOT NULL,
        riskLevel TEXT NOT NULL,
        minInvestment REAL NOT NULL,
        currency TEXT NOT NULL,
        sustainabilityCategories TEXT NOT NULL, -- Store categories list as JSON string
        impactScore REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE eco_donations(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');
  }

  // CRUD operations will be added here

  // Example: Insert a SocialPayment (Need to implement for other models too)
  Future<int> insertSocialPayment(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('social_payments', row);
  }

  // Example: Query all SocialPayments
  Future<List<Map<String, dynamic>>> queryAllSocialPayments() async {
    Database db = await database;
    return await db.query('social_payments');
  }

  // Example: Update a SocialPayment
  Future<int> updateSocialPayment(Map<String, dynamic> row) async {
    Database db = await database;
    String id = row['id'];
    return await db.update(
      'social_payments',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Example: Delete a SocialPayment
  Future<int> deleteSocialPayment(String id) async {
    Database db = await database;
    return await db.delete('social_payments', where: 'id = ?', whereArgs: [id]);
  }

  // --- CarbonFootprint CRUD ---
  Future<int> insertCarbonFootprint(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('carbon_footprints', row);
  }

  Future<List<Map<String, dynamic>>> queryAllCarbonFootprints() async {
    Database db = await database;
    return await db.query('carbon_footprints');
  }

  Future<Map<String, dynamic>?> queryCarbonFootprint(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'carbon_footprints',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<int> updateCarbonFootprint(Map<String, dynamic> row) async {
    Database db = await database;
    String id = row['id'];
    return await db.update(
      'carbon_footprints',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCarbonFootprint(String id) async {
    Database db = await database;
    return await db.delete(
      'carbon_footprints',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- SustainableInvestment CRUD ---
  Future<int> insertSustainableInvestment(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('sustainable_investments', row);
  }

  Future<List<Map<String, dynamic>>> queryAllSustainableInvestments() async {
    Database db = await database;
    return await db.query('sustainable_investments');
  }

  Future<Map<String, dynamic>?> querySustainableInvestment(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'sustainable_investments',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<int> updateSustainableInvestment(Map<String, dynamic> row) async {
    Database db = await database;
    String id = row['id'];
    return await db.update(
      'sustainable_investments',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteSustainableInvestment(String id) async {
    Database db = await database;
    return await db.delete(
      'sustainable_investments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- EcoDonation CRUD ---
  Future<int> insertEcoDonation(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('eco_donations', row);
  }

  Future<List<Map<String, dynamic>>> queryAllEcoDonations() async {
    Database db = await database;
    return await db.query('eco_donations');
  }

  Future<Map<String, dynamic>?> queryEcoDonation(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'eco_donations',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<int> updateEcoDonation(Map<String, dynamic> row) async {
    Database db = await database;
    String id = row['id'];
    return await db.update(
      'eco_donations',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteEcoDonation(String id) async {
    Database db = await database;
    return await db.delete('eco_donations', where: 'id = ?', whereArgs: [id]);
  }
}
