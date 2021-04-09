import 'package:path/path.dart';
import 'package:qr_scanner/models/QR.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static const String TABLE_QR = "qr";
  static const String COLUMN_ID = "id";
  static const String COLUMN_VALUE = "value";
  static const String COLUMN_TYPE = "type";
  static const String COLUMN_IS_SCANNED = "isScanned";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database? _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database!;
    }

    _database = await createDatabase();

    return _database!;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'qr.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating QR table");

        await database.execute(
          "CREATE TABLE $TABLE_QR ("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_VALUE TEXT,"
          "$COLUMN_TYPE INTEGER,"
          "$COLUMN_IS_SCANNED INTEGER"
          ")",
        );
      },
    );
  }

  Future<List<QR>> getFoods() async {
    final db = await database;

    var QRs = await db.query(TABLE_QR,
        columns: [COLUMN_ID, COLUMN_VALUE, COLUMN_TYPE, COLUMN_IS_SCANNED]);

    List<QR> QR_List = [];

    QRs.forEach((currentQR) {
      QR_List.add(QR.fromMap(currentQR));
    });

    return QR_List;
  }

  Future<QR> insert(QR qr) async {
    final db = await database;
    qr.id = await db.insert(TABLE_QR, qr.toMap());
    return qr;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_QR,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(QR qr) async {
    final db = await database;

    return await db.update(
      TABLE_QR,
      qr.toMap(),
      where: "id = ?",
      whereArgs: [qr.id],
    );
  }
}
