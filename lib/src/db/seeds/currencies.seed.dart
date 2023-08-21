import 'package:wallet_monitor/src/db/queries/currency.consult.dart';

final List<Map<String, String>> currencies = [
  {
    "id": "1",
    "symbol": "Lek",
    "name": "AlbaniaLek",
    "code": "AMD",
    "decimalDigits": "0"
  },
  {
    "id": "2",
    "symbol": "؋",
    "name": "AfghanistanAfghani",
    "code": "AFN",
    "decimalDigits": "0"
  },
  {
    "id": "3",
    "symbol": "\$",
    "name": "ArgentinaPeso",
    "code": "ARS",
    "decimalDigits": "2"
  },
  {
    "id": "4",
    "symbol": "ƒ",
    "name": "ArubaGuilder",
    "code": "AWG",
    "decimalDigits": "2"
  },
  {
    "id": "5",
    "symbol": "\$",
    "name": "AustraliaDollar",
    "code": "AUD",
    "decimalDigits": "2"
  },
  {
    "id": "6",
    "symbol": "₼",
    "name": "AzerbaijanManat",
    "code": "AZN",
    "decimalDigits": "2"
  },
  {
    "id": "7",
    "symbol": "\$",
    "name": "BahamasDollar",
    "code": "BSD",
    "decimalDigits": "2"
  },
  {
    "id": "8",
    "symbol": "\$",
    "name": "BarbadosDollar",
    "code": "BBD",
    "decimalDigits": "2"
  },
  {
    "id": "9",
    "symbol": "Br",
    "name": "BelarusRuble",
    "code": "BYN",
    "decimalDigits": "2"
  },
  {
    "id": "10",
    "symbol": "BZ\$",
    "name": "BelizeDollar",
    "code": "BZD",
    "decimalDigits": "2"
  },
  {
    "id": "11",
    "symbol": "\$",
    "name": "BermudaDollar",
    "code": "BMD",
    "decimalDigits": "2"
  },
  {
    "id": "12",
    "symbol": "\$b",
    "name": "BoliviaBoliviano",
    "code": "BOB",
    "decimalDigits": "2"
  },
  {
    "id": "13",
    "symbol": "KM",
    "name": "BosniaAndHerzegovinaConvertibleMark",
    "code": "BAM",
    "decimalDigits": "2"
  },
  {
    "id": "14",
    "symbol": "P",
    "name": "BotswanaPula",
    "code": "BWP",
    "decimalDigits": "2"
  },
  {
    "id": "15",
    "symbol": "лв",
    "name": "BulgariaLev",
    "code": "BGN",
    "decimalDigits": "2"
  },
  {
    "id": "16",
    "symbol": "R\$",
    "name": "BrazilReal",
    "code": "BRL",
    "decimalDigits": "2"
  },
  {
    "id": "17",
    "symbol": "\$",
    "name": "BruneiDarussalamDollar",
    "code": "BND",
    "decimalDigits": "2"
  },
  {
    "id": "18",
    "symbol": "៛",
    "name": "CambodiaRiel",
    "code": "KHR",
    "decimalDigits": "2"
  },
  {
    "id": "19",
    "symbol": "\$",
    "name": "CanadaDollar",
    "code": "CAD",
    "decimalDigits": "2"
  },
  {
    "id": "20",
    "symbol": "\$",
    "name": "CaymanIslandsDollar",
    "code": "KYD",
    "decimalDigits": "2"
  },
  {
    "id": "21",
    "symbol": "\$",
    "name": "ChilePeso",
    "code": "CLP",
    "decimalDigits": "0"
  },
  {
    "id": "22",
    "symbol": "¥",
    "name": "ChinaYuanRenminbi",
    "code": "CNY",
    "decimalDigits": "2"
  },
  {
    "id": "23",
    "symbol": "\$",
    "name": "ColombiaPeso",
    "code": "COP",
    "decimalDigits": "0"
  },
  {
    "id": "24",
    "symbol": "₡",
    "name": "CostaRicaColon",
    "code": "CRC",
    "decimalDigits": "0"
  },
  {
    "id": "25",
    "symbol": "kn",
    "name": "CroatiaKuna",
    "code": "HRK",
    "decimalDigits": "2"
  },
  {
    "id": "26",
    "symbol": "₱",
    "name": "CubaPeso",
    "code": "CUC",
    "decimalDigits": "2"
  },
  {
    "id": "27",
    "symbol": "Kč",
    "name": "CzechRepublicKoruna",
    "code": "CZK",
    "decimalDigits": "2"
  },
  {
    "id": "28",
    "symbol": "kr",
    "name": "DenmarkKrone",
    "code": "DKK",
    "decimalDigits": "2"
  },
  {
    "id": "29",
    "symbol": "DR\$",
    "name": "DominicanRepublicPeso",
    "code": "DOP",
    "decimalDigits": "2"
  },
  {
    "id": "30",
    "symbol": "\$",
    "name": "EastCaribbeanDollar",
    "code": "XCD",
    "decimalDigits": "2"
  },
  {
    "id": "31",
    "symbol": "£",
    "name": "EgyptPound",
    "code": "EGP",
    "decimalDigits": "2"
  },
  {
    "id": "32",
    "symbol": "\$",
    "name": "ElSalvadorColon",
    "code": "SVC",
    "decimalDigits": "2"
  },
  {
    "id": "33",
    "symbol": "̄€",
    "name": "EuroMemberCountries",
    "code": "EUR",
    "decimalDigits": "2"
  },
  {
    "id": "34",
    "symbol": "£",
    "name": "FalklandIslandsMalvinasPound",
    "code": "FKP",
    "decimalDigits": "2"
  },
  {
    "id": "35",
    "symbol": "\$",
    "name": "FijiDollar",
    "code": "FJD",
    "decimalDigits": "2"
  },
  {
    "id": "36",
    "symbol": "¢",
    "name": "GhanaCedi",
    "code": "GHS",
    "decimalDigits": "2"
  },
  {
    "id": "37",
    "symbol": "£",
    "name": "GibraltarPound",
    "code": "GIP",
    "decimalDigits": "2"
  },
  {
    "id": "38",
    "symbol": "Q",
    "name": "GuatemalaQuetzal",
    "code": "GTQ",
    "decimalDigits": "2"
  },
  {
    "id": "39",
    "symbol": "£",
    "name": "GuernseyPound",
    "code": "GGP",
    "decimalDigits": "2"
  },
  {
    "id": "40",
    "symbol": "\$",
    "name": "GuyanaDollar",
    "code": "GYD",
    "decimalDigits": "2"
  },
  {
    "id": "41",
    "symbol": "L",
    "name": "HondurasLempira",
    "code": "HNL",
    "decimalDigits": "2"
  },
  {
    "id": "42",
    "symbol": "\$",
    "name": "HongKongDollar",
    "code": "HKD",
    "decimalDigits": "2"
  },
  {
    "id": "43",
    "symbol": "Ft",
    "name": "HungaryForint",
    "code": "HUF",
    "decimalDigits": "2"
  },
  {
    "id": "44",
    "symbol": "kr",
    "name": "IcelandKrona",
    "code": "ISK",
    "decimalDigits": "0"
  },
  {
    "id": "45",
    "symbol": "₹",
    "name": "IndiaRupee",
    "code": "INR",
    "decimalDigits": "2"
  },
  {
    "id": "46",
    "symbol": "Rp",
    "name": "IndonesiaRupiah",
    "code": "IDK",
    "decimalDigits": "0"
  },
  {
    "id": "47",
    "symbol": "﷼",
    "name": "IranRial",
    "code": "IRR",
    "decimalDigits": "0"
  },
  {
    "id": "49",
    "symbol": "₪",
    "name": "IsraelShekel",
    "code": "ILS",
    "decimalDigits": "2"
  },
  {
    "id": "50",
    "symbol": "J\$",
    "name": "JamaicaDollar",
    "code": "JMD",
    "decimalDigits": "2"
  },
  {
    "id": "51",
    "symbol": "¥",
    "name": "JapanYen",
    "code": "JPY",
    "decimalDigits": "0"
  },
  {
    "id": "52",
    "symbol": "£",
    "name": "JerseyPound",
    "code": "JEP",
    "decimalDigits": "2"
  },
  {
    "id": "53",
    "symbol": "лв",
    "name": "KazakhstanTenge",
    "code": "KZT",
    "decimalDigits": "2"
  },
  {
    "id": "54",
    "symbol": "₩",
    "name": "KoreaNorthWon",
    "code": "KPW",
    "decimalDigits": "2"
  },
  {
    "id": "55",
    "symbol": "₩",
    "name": "KoreaSouthWon",
    "code": "KRW",
    "decimalDigits": "2"
  },
  {
    "id": "56",
    "symbol": "лв",
    "name": "KyrgyzstanSom",
    "code": "KGS",
    "decimalDigits": "2"
  },
  {
    "id": "57",
    "symbol": "₭",
    "name": "LaosKip",
    "code": "LAK",
    "decimalDigits": "0"
  },
  {
    "id": "58",
    "symbol": "£",
    "name": "LebanonPound",
    "code": "LBP",
    "decimalDigits": "0"
  },
  {
    "id": "59",
    "symbol": "\$",
    "name": "LiberiaDollar",
    "code": "LRD",
    "decimalDigits": "2"
  },
  {
    "id": "60",
    "symbol": "ден",
    "name": "MacedoniaDenar",
    "code": "MKD",
    "decimalDigits": "2"
  },
  {
    "id": "61",
    "symbol": "RM",
    "name": "MalaysiaRinggit",
    "code": "MYR",
    "decimalDigits": "2"
  },
  {
    "id": "62",
    "symbol": "₹",
    "name": "MauritiusRupee",
    "code": "MRO",
    "decimalDigits": "2"
  },
  {
    "id": "63",
    "symbol": "\$",
    "name": "MexicoPeso",
    "code": "MXN",
    "decimalDigits": "2"
  },
  {
    "id": "64",
    "symbol": "₮",
    "name": "MongoliaTughrik",
    "code": "MNT",
    "decimalDigits": "2"
  },
  {
    "id": "65",
    "symbol": "MT",
    "name": "MozambiqueMetical",
    "code": "MZN",
    "decimalDigits": "2"
  },
  {
    "id": "66",
    "symbol": "\$",
    "name": "NamibiaDollar",
    "code": "NAD",
    "decimalDigits": "2"
  },
  {
    "id": "67",
    "symbol": "₹",
    "name": "NepalRupee",
    "code": "NPR",
    "decimalDigits": "2"
  },
  {
    "id": "68",
    "symbol": "ƒ",
    "name": "NetherlandsAntillesGuilder",
    "code": "ANG",
    "decimalDigits": "2"
  },
  {
    "id": "69",
    "symbol": "\$",
    "name": "NewZealandDollar",
    "code": "NZD",
    "decimalDigits": "2"
  },
  {
    "id": "70",
    "symbol": "C\$",
    "name": "NicaraguaCordoba",
    "code": "NIO",
    "decimalDigits": "2"
  },
  {
    "id": "71",
    "symbol": "₦",
    "name": "NigeriaNaira",
    "code": "NGN",
    "decimalDigits": "2"
  },
  {
    "id": "72",
    "symbol": "kr",
    "name": "NorwayKrone",
    "code": "NOK",
    "decimalDigits": "2"
  },
  {
    "id": "73",
    "symbol": "﷼",
    "name": "OmanRial",
    "code": "OMR",
    "decimalDigits": "3"
  },
  {
    "id": "74",
    "symbol": "₹",
    "name": "PakistanRupee",
    "code": "PKR",
    "decimalDigits": "0"
  },
  {
    "id": "75",
    "symbol": "B/.",
    "name": "PanamaBalboa",
    "code": "PAB",
    "decimalDigits": "2"
  },
  {
    "id": "76",
    "symbol": "₲",
    "name": "ParaguayGuarani",
    "code": "PYG",
    "decimalDigits": "0"
  },
  {
    "id": "77",
    "symbol": "S/.",
    "name": "PeruSol",
    "code": "PEN",
    "decimalDigits": "2"
  },
  {
    "id": "78",
    "symbol": "₱",
    "name": "PhilippinesPeso",
    "code": "PHP",
    "decimalDigits": "2"
  },
  {
    "id": "79",
    "symbol": "zł",
    "name": "PolandZloty",
    "code": "PLN",
    "decimalDigits": "2"
  },
  {
    "id": "80",
    "symbol": "﷼",
    "name": "QatarRiyal",
    "code": "QAR",
    "decimalDigits": "2"
  },
  {
    "id": "81",
    "symbol": "lei",
    "name": "RomaniaLeu",
    "code": "RON",
    "decimalDigits": "2"
  },
  {
    "id": "82",
    "symbol": "₽",
    "name": "RussiaRuble",
    "code": "RUB",
    "decimalDigits": "2"
  },
  {
    "id": "83",
    "symbol": "£",
    "name": "SaintHelenaPound",
    "code": "SHP",
    "decimalDigits": "2"
  },
  {
    "id": "84",
    "symbol": "﷼",
    "name": "SaudiArabiaRiyal",
    "code": "",
    "decimalDigits": "2"
  },
  {
    "id": "85",
    "symbol": "Дин.",
    "name": "SerbiaDinar",
    "code": "SAR",
    "decimalDigits": "2"
  },
  {
    "id": "86",
    "symbol": "₹",
    "name": "SeychellesRupee",
    "code": "SRC",
    "decimalDigits": "2"
  },
  {
    "id": "87",
    "symbol": "\$",
    "name": "SingaporeDollar",
    "code": "SGD",
    "decimalDigits": "2"
  },
  {
    "id": "88",
    "symbol": "\$",
    "name": "SolomonIslandsDollar",
    "code": "SBD",
    "decimalDigits": "2"
  },
  {
    "id": "89",
    "symbol": "S",
    "name": "SomaliaShilling",
    "code": "SOS",
    "decimalDigits": "0"
  },
  {
    "id": "90",
    "symbol": "R",
    "name": "SouthAfricaRand",
    "code": "ZAR",
    "decimalDigits": "2"
  },
  {
    "id": "91",
    "symbol": "₹",
    "name": "SriLankaRupee",
    "code": "LKR",
    "decimalDigits": "2"
  },
  {
    "id": "92",
    "symbol": "Kr",
    "name": "SwedenKrona",
    "code": "SEK",
    "decimalDigits": "2"
  },
  {
    "id": "93",
    "symbol": "CHF",
    "name": "SwitzerlandFranc",
    "code": "CHF",
    "decimalDigits": "2"
  },
  {
    "id": "94",
    "symbol": "\$",
    "name": "SurinameDollar",
    "code": "SRD",
    "decimalDigits": "2"
  },
  {
    "id": "95",
    "symbol": "£",
    "name": "SyriaPound",
    "code": "SYP",
    "decimalDigits": "0"
  },
  {
    "id": "96",
    "symbol": "NT\$",
    "name": "TaiwanNewDollar",
    "code": "TWD",
    "decimalDigits": "2"
  },
  {
    "id": "97",
    "symbol": "฿",
    "name": "ThailandBaht",
    "code": "THB",
    "decimalDigits": "2"
  },
  {
    "id": "98",
    "symbol": "TT\$",
    "name": "TrinidadAndTobagoDollar",
    "code": "TTD",
    "decimalDigits": "2"
  },
  {
    "id": "99",
    "symbol": "₺",
    "name": "TurkeyLira",
    "code": "TRY",
    "decimalDigits": "2"
  },
  {
    "id": "101",
    "symbol": "₴",
    "name": "UkraineHryvnia",
    "code": "UAH",
    "decimalDigits": "2"
  },
  {
    "id": "103",
    "symbol": "\$",
    "name": "UnitedStatesDollar",
    "code": "USD",
    "decimalDigits": "2"
  },
  {
    "id": "104",
    "symbol": "\$U",
    "name": "UruguayPeso",
    "code": "UYU",
    "decimalDigits": "2"
  },
  {
    "id": "105",
    "symbol": "лв",
    "name": "UzbekistanSom",
    "code": "UZS",
    "decimalDigits": "2"
  },
  {
    "id": "106",
    "symbol": "Bs",
    "name": "VenezuelaBolivar",
    "code": "VEF",
    "decimalDigits": "2"
  },
  {
    "id": "107",
    "symbol": "₫",
    "name": "VietnamDong",
    "code": "VDM",
    "decimalDigits": "0"
  },
  {
    "id": "108",
    "symbol": "﷼",
    "name": "YemenRial",
    "code": "YER",
    "decimalDigits": "0"
  },
  {
    "id": "109",
    "symbol": "Z\$",
    "name": "ZimbabweDollar",
    "code": "ZWL",
    "decimalDigits": "2"
  },
];

Future<void> insertCurrencies() async {
  for (final currency in currencies) {
    await CurrencyConsult.insertOrUpdate(
      id: int.parse(currency["id"]!),
      code: currency["code"]!,
      name: currency["name"]!,
      decimalDigits: int.parse(currency["decimalDigits"]!),
      exchangeRate: 1,
      symbol: currency["symbol"]!,
      deleted: false,
    );
  }
}
