import 'package:wallet_monitor/src/db/queries/currency.consult.dart';

class CurrenciesResponse {
  List<Currency?> currencies;
  String message;

  CurrenciesResponse({
    required this.currencies,
    required this.message,
  });

  factory CurrenciesResponse.fromJson(Map<String, dynamic> json) {
    print("in currencies response from json");
    print(json["currencies"]);
    return CurrenciesResponse(
      currencies: _formatCurrency(json["currencies"] as List<dynamic>),
      message: json["message"],
    );
  }
}

List<Currency> _formatCurrency(List<dynamic> json) {
  print("Formating currencies values from fetch");
  const hola = 126.0;
  hola.toInt();
  return json
      .map(
        (x) => Currency(
          id: x["id"],
          name: x["name"],
          code: x["code"],
          symbol: x["symbol"],
          exchangeRate: x["exchangeRate"].toDouble(),
          decimalDigits: x["decimalDigits"],
          deleted: x["deletedAt"] != null ? true : false,
        ),
      )
      .toList();
}
