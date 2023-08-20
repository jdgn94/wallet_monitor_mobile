// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

import 'package:wallet_monitor/generated/l10n.dart';

import 'package:wallet_monitor/storage/index.dart';

abstract class CurrencyFunctions {
  static String formatNumber({
    required String symbol,
    required int decimalDigits,
    required double amount,
  }) {
    final pref = SettingsLocalStorage.pref;
    final formatNumber = _numberDigits(decimalDigits);

    return "$symbol\t${NumberFormat(formatNumber, pref.getString("formatNumber")!).format(amount)}";
  }

  static String name(String value) {
    switch (value) {
      case "AlbaniaLek":
        return S.current.AlbaniaLek;
      case "AfghanistanAfghani":
        return S.current.AfghanistanAfghani;
      case "ArgentinaPeso":
        return S.current.ArgentinaPeso;
      case "ArubaGuilder":
        return S.current.ArubaGuilder;
      case "AustraliaDollar":
        return S.current.AustraliaDollar;
      case "AzerbaijanManat":
        return S.current.AzerbaijanManat;
      case "BahamasDollar":
        return S.current.BahamasDollar;
      case "BarbadosDollar":
        return S.current.BarbadosDollar;
      case "BelarusRuble":
        return S.current.BelarusRuble;
      case "BelizeDollar":
        return S.current.BelizeDollar;
      case "BermudaDollar":
        return S.current.BermudaDollar;
      case "BoliviaBoliviano":
        return S.current.BoliviaBoliviano;
      case "BosniaAndHerzegovinaConvertibleMark":
        return S.current.BosniaAndHerzegovinaConvertibleMark;
      case "BotswanaPula":
        return S.current.BotswanaPula;
      case "BulgariaLev":
        return S.current.BulgariaLev;
      case "BrazilReal":
        return S.current.BrazilReal;
      case "BruneiDarussalamDollar":
        return S.current.BruneiDarussalamDollar;
      case "CambodiaRiel":
        return S.current.CambodiaRiel;
      case "CanadaDollar":
        return S.current.CanadaDollar;
      case "CaymanIslandsDollar":
        return S.current.CaymanIslandsDollar;
      case "ChilePeso":
        return S.current.ChilePeso;
      case "ChinaYuanRenminbi":
        return S.current.ChinaYuanRenminbi;
      case "ColombiaPeso":
        return S.current.ColombiaPeso;
      case "CostaRicaColon":
        return S.current.CostaRicaColon;
      case "CroatiaKuna":
        return S.current.CroatiaKuna;
      case "CubaPeso":
        return S.current.CubaPeso;
      case "CzechRepublicKoruna":
        return S.current.CzechRepublicKoruna;
      case "DenmarkKrone":
        return S.current.DenmarkKrone;
      case "DominicanRepublicPeso":
        return S.current.DominicanRepublicPeso;
      case "EastCaribbeanDollar":
        return S.current.EastCaribbeanDollar;
      case "EgyptPound":
        return S.current.EgyptPound;
      case "ElSalvadorColon":
        return S.current.ElSalvadorColon;
      case "EuroMemberCountries":
        return S.current.EuroMemberCountries;
      case "FalklandIslandsMalvinasPound":
        return S.current.FalklandIslandsMalvinasPound;
      case "FijiDollar":
        return S.current.FijiDollar;
      case "GhanaCedi":
        return S.current.GhanaCedi;
      case "GibraltarPound":
        return S.current.GibraltarPound;
      case "GuatemalaQuetzal":
        return S.current.GuatemalaQuetzal;
      case "GuernseyPound":
        return S.current.GuernseyPound;
      case "GuyanaDollar":
        return S.current.GuyanaDollar;
      case "HondurasLempira":
        return S.current.HondurasLempira;
      case "HongKongDollar":
        return S.current.HongKongDollar;
      case "HungaryForint":
        return S.current.HungaryForint;
      case "IcelandKrona":
        return S.current.IcelandKrona;
      case "IndiaRupee":
        return S.current.IndiaRupee;
      case "IndonesiaRupiah":
        return S.current.IndonesiaRupiah;
      case "IranRial":
        return S.current.IranRial;
      case "IsleOfManPound":
        return S.current.IsleOfManPound;
      case "IsraelShekel":
        return S.current.IsraelShekel;
      case "JamaicaDollar":
        return S.current.JamaicaDollar;
      case "JapanYen":
        return S.current.JapanYen;
      case "JerseyPound":
        return S.current.JerseyPound;
      case "KazakhstanTenge":
        return S.current.KazakhstanTenge;
      case "KoreaNorthWon":
        return S.current.KoreaNorthWon;
      case "KoreaSouthWon":
        return S.current.KoreaSouthWon;
      case "KyrgyzstanSom":
        return S.current.KyrgyzstanSom;
      case "LaosKip":
        return S.current.LaosKip;
      case "LebanonPound":
        return S.current.LebanonPound;
      case "LiberiaDollar":
        return S.current.LiberiaDollar;
      case "MacedoniaDenar":
        return S.current.MacedoniaDenar;
      case "MalaysiaRinggit":
        return S.current.MalaysiaRinggit;
      case "MauritiusRupee":
        return S.current.MauritiusRupee;
      case "MexicoPeso":
        return S.current.MexicoPeso;
      case "MongoliaTughrik":
        return S.current.MongoliaTughrik;
      case "MozambiqueMetical":
        return S.current.MozambiqueMetical;
      case "NamibiaDollar":
        return S.current.NamibiaDollar;
      case "NepalRupee":
        return S.current.NepalRupee;
      case "NetherlandsAntillesGuilder":
        return S.current.NetherlandsAntillesGuilder;
      case "NewZealandDollar":
        return S.current.NewZealandDollar;
      case "NicaraguaCordoba":
        return S.current.NicaraguaCordoba;
      case "NigeriaNaira":
        return S.current.NigeriaNaira;
      case "NorwayKrone":
        return S.current.NorwayKrone;
      case "OmanRial":
        return S.current.OmanRial;
      case "PakistanRupee":
        return S.current.PakistanRupee;
      case "PanamaBalboa":
        return S.current.PanamaBalboa;
      case "ParaguayGuarani":
        return S.current.ParaguayGuarani;
      case "PeruSol":
        return S.current.PeruSol;
      case "PhilippinesPeso":
        return S.current.PhilippinesPeso;
      case "PolandZloty":
        return S.current.PolandZloty;
      case "QatarRiyal":
        return S.current.QatarRiyal;
      case "RomaniaLeu":
        return S.current.RomaniaLeu;
      case "RussiaRuble":
        return S.current.RussiaRuble;
      case "SaintHelenaPound":
        return S.current.SaintHelenaPound;
      case "SaudiArabiaRiyal":
        return S.current.SaudiArabiaRiyal;
      case "SerbiaDinar":
        return S.current.SerbiaDinar;
      case "SeychellesRupee":
        return S.current.SeychellesRupee;
      case "SingaporeDollar":
        return S.current.SingaporeDollar;
      case "SolomonIslandsDollar":
        return S.current.SolomonIslandsDollar;
      case "SomaliaShilling":
        return S.current.SomaliaShilling;
      case "SouthAfricaRand":
        return S.current.SouthAfricaRand;
      case "SriLankaRupee":
        return S.current.SriLankaRupee;
      case "SwedenKrona":
        return S.current.SwedenKrona;
      case "SwitzerlandFranc":
        return S.current.SwitzerlandFranc;
      case "SurinameDollar":
        return S.current.SurinameDollar;
      case "SyriaPound":
        return S.current.SyriaPound;
      case "TaiwanNewDollar":
        return S.current.TaiwanNewDollar;
      case "ThailandBaht":
        return S.current.ThailandBaht;
      case "TrinidadAndTobagoDollar":
        return S.current.TrinidadAndTobagoDollar;
      case "TurkeyLira":
        return S.current.TurkeyLira;
      case "TuvaluDollar":
        return S.current.TuvaluDollar;
      case "UkraineHryvnia":
        return S.current.UkraineHryvnia;
      case "UnitedKingdomPound":
        return S.current.UnitedKingdomPound;
      case "UnitedStatesDollar":
        return S.current.UnitedStatesDollar;
      case "UruguayPeso":
        return S.current.UruguayPeso;
      case "UzbekistanSom":
        return S.current.UzbekistanSom;
      case "VenezuelaBolivar":
        return S.current.VenezuelaBolivar;
      case "VietnamDong":
        return S.current.VietnamDong;
      case "YemenRial":
        return S.current.YemenRial;
      case "ZimbabweDollar":
        return S.current.ZimbabweDollar;
      default:
        return S.current.none;
    }
  }
}

String _numberDigits(int value) {
  switch (value) {
    case 1:
      return "#,##0.0";
    case 2:
      return "#,##0.00";
    case 3:
      return "#,##0.000";
    case 4:
      return "#,##0.0000";
    case 5:
      return "#,##0.00000";
    default:
      return "#,##0";
  }
}
