import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:wallet_monitor/src/db/models/currencies_response.model.dart';
import 'package:wallet_monitor/src/db/queries/currency.consult.dart';
import 'package:wallet_monitor/src/db/seeds/currencies.seed.dart';

abstract class FetchController {
  static const String _baseUrl = "http://192.168.1.10:3000/api";
  // static const String _baseUrl = "http://192.168.10.109:3000/api";

  static Future<void> getAllCurrencies() async {
    print("Estoy consultando el api para la busqueda de las monedas");
    try {
      final url = Uri.parse("$_baseUrl/currency/all");

      final response = await http.get(url);
      print(response.statusCode);

      if (response.statusCode != 200) throw "error on getAllCurrencies";

      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      final responseFormate = CurrenciesResponse.fromJson(responseJson);

      for (final Currency? currency in responseFormate.currencies) {
        if (currency == null) continue;
        CurrencyConsult.insertOrUpdate(
          id: currency.id,
          code: currency.code,
          name: currency.name,
          decimalDigits: currency.decimalDigits,
          exchangeRate: currency.exchangeRate,
          symbol: currency.symbol,
          deleted: currency.deleted,
        );
      }
    } catch (e) {
      // aquí tengo que correr la semilla
      print(e);
      final currencies = await CurrencyConsult.getAll();
      if (currencies.isEmpty) {
        insertCurrencies();
      }
    }
  }
}
