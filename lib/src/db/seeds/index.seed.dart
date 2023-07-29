import 'package:wallet_monitor/src/db/seeds/currencies.seed.dart';

Future<void> insertAllSeeds() async {
  await insertsAllCurrencies();
}
