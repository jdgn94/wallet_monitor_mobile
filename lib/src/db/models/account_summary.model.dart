class SummaryAccount {
  int totalAccounts;
  double totalAmounts;
  String currencyName;
  String currencySymbol;
  double exchangeRate;
  int decimalDigits;

  SummaryAccount({
    required this.totalAccounts,
    required this.totalAmounts,
    required this.currencyName,
    required this.currencySymbol,
    required this.exchangeRate,
    required this.decimalDigits,
  });

  factory SummaryAccount.fromJson(Map<String, dynamic> json) => SummaryAccount(
        totalAccounts: json["total_accounts"],
        totalAmounts: json["total_amounts"],
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
        exchangeRate: json["exchange_rate"],
        decimalDigits: json["decimal_digits"],
      );
}

List<SummaryAccount?> summaryAccountFromJson(List<Map<String, dynamic>> json) =>
    json.isEmpty ? [] : json.map((x) => SummaryAccount.fromJson(x)).toList();
