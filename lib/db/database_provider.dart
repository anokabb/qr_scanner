import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import '../bloc/qr_bloc.dart';
import '../models/QR.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static const String TABLE_QR = "qr";
  static const String COLUMN_ID = "id";
  static const String COLUMN_VALUE = "value";
  static const String COLUMN_TYPE = "type";
  static const String COLUMN_IS_SCANNED = "isScanned";
  static const String COLUMN_DATE = "date";

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
          "$COLUMN_IS_SCANNED INTEGER,"
          "$COLUMN_DATE INTEGER"
          ")",
        );
      },
    );
  }

  Future<List<QR>> getQrs(BuildContext context) async {
    final db = await database;

    List<Map<String, Object?>> QRs = await db.query(TABLE_QR, columns: [
      COLUMN_ID,
      COLUMN_VALUE,
      COLUMN_TYPE,
      COLUMN_IS_SCANNED,
      COLUMN_DATE
    ]);

    List<QR> QR_List = [];

    QRs.forEach((currentQR) {
      QR_List.add(QR.fromMap(currentQR));
    });
    QR_List.forEach((element) {
      print(element.toString());
    });

    BlocProvider.of<QrBloc>(context).add(SetQrs(QR_List.reversed.toList()));

    return QR_List;
  }

  Future<QR> insert(BuildContext context, QR qr) async {
    final db = await database;
    qr.id = await db.insert(TABLE_QR, qr.toMap());
    // BlocProvider.of<QrBloc>(context).add(AddQR(qr));
    getQrs(context);

    print('database insert id : ${qr.id}');
    return qr;
  }

  Future<int> delete(BuildContext context, int id) async {
    final db = await database;

    int res = await db.delete(
      TABLE_QR,
      where: "id = ?",
      whereArgs: [id],
    );
    print('database delete id : $id');
    // if (res != 0) {
    // BlocProvider.of<QrBloc>(context).add(DeleteQR(id));
    getQrs(context);
    // }
    return res;
  }

  Future<int> update(BuildContext context, QR qr) async {
    final db = await database;

    int res = await db.update(
      TABLE_QR,
      qr.toMap(),
      where: "id = ?",
      whereArgs: [qr.id],
    );
    print('database update id : ${qr.id}');
    // BlocProvider.of<QrBloc>(context).add(UpdateQR(qr, qr.id!));
    getQrs(context);
    return res;
  }
}
