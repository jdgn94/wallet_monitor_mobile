// ignore_for_file: prefer_const_constructors

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:wallet_monitor/src/db/models/account.model.dart';
import 'package:wallet_monitor/src/db/models/currency.model.dart';
import 'package:wallet_monitor/src/db/seeds/index.seed.dart';

export 'package:isar/isar.dart';

class DataBase {
  static late Isar db;

  DataBase();

  static Future<void> initDB() async {
    if (Isar.instanceNames.isEmpty) {
      db = await Isar.open(
        [
          CurrencySchema,
          AccountSchema,
        ],
        name: "dev",
        directory: (await pathProvider.getApplicationDocumentsDirectory()).path,
      );
    } else {
      db = await Future.value(Isar.getInstance());
    }

    await insertAllSeeds();
  }

  String generateUuid() {
    final uuid = Uuid();
    return uuid.v4();
  }
}
