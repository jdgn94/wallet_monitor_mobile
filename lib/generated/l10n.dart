// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Initial configs`
  String get initialConfig {
    return Intl.message(
      'Initial configs',
      name: 'initialConfig',
      desc: '',
      args: [],
    );
  }

  /// `Color selector`
  String get colorSelector {
    return Intl.message(
      'Color selector',
      name: 'colorSelector',
      desc: '',
      args: [],
    );
  }

  /// `Theme selector`
  String get themeSelector {
    return Intl.message(
      'Theme selector',
      name: 'themeSelector',
      desc: '',
      args: [],
    );
  }

  /// `Select a color`
  String get selectAColor {
    return Intl.message(
      'Select a color',
      name: 'selectAColor',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Themes`
  String get theme {
    return Intl.message(
      'Themes',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Teal`
  String get teal {
    return Intl.message(
      'Teal',
      name: 'teal',
      desc: '',
      args: [],
    );
  }

  /// `Purple`
  String get purple {
    return Intl.message(
      'Purple',
      name: 'purple',
      desc: '',
      args: [],
    );
  }

  /// `Pink`
  String get pink {
    return Intl.message(
      'Pink',
      name: 'pink',
      desc: '',
      args: [],
    );
  }

  /// `Blue`
  String get blue {
    return Intl.message(
      'Blue',
      name: 'blue',
      desc: '',
      args: [],
    );
  }

  /// `Orange`
  String get orange {
    return Intl.message(
      'Orange',
      name: 'orange',
      desc: '',
      args: [],
    );
  }

  /// `Red`
  String get red {
    return Intl.message(
      'Red',
      name: 'red',
      desc: '',
      args: [],
    );
  }

  /// `Green`
  String get green {
    return Intl.message(
      'Green',
      name: 'green',
      desc: '',
      args: [],
    );
  }

  /// `Chameleon`
  String get chameleon {
    return Intl.message(
      'Chameleon',
      name: 'chameleon',
      desc: '',
      args: [],
    );
  }

  /// `Personal`
  String get personal {
    return Intl.message(
      'Personal',
      name: 'personal',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Lighting`
  String get lighting {
    return Intl.message(
      'Lighting',
      name: 'lighting',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Night`
  String get night {
    return Intl.message(
      'Night',
      name: 'night',
      desc: '',
      args: [],
    );
  }

  /// `General Mode`
  String get generalMode {
    return Intl.message(
      'General Mode',
      name: 'generalMode',
      desc: '',
      args: [],
    );
  }

  /// `Light Style`
  String get lightStyle {
    return Intl.message(
      'Light Style',
      name: 'lightStyle',
      desc: '',
      args: [],
    );
  }

  /// `Dark Style`
  String get darkStyle {
    return Intl.message(
      'Dark Style',
      name: 'darkStyle',
      desc: '',
      args: [],
    );
  }

  /// `Currency config`
  String get currencyConfig {
    return Intl.message(
      'Currency config',
      name: 'currencyConfig',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Currencies`
  String get currencies {
    return Intl.message(
      'Currencies',
      name: 'currencies',
      desc: '',
      args: [],
    );
  }

  /// `Primary`
  String get primary {
    return Intl.message(
      'Primary',
      name: 'primary',
      desc: '',
      args: [],
    );
  }

  /// `Currency Format`
  String get currencyFormat {
    return Intl.message(
      'Currency Format',
      name: 'currencyFormat',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Format`
  String get format {
    return Intl.message(
      'Format',
      name: 'format',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Accounts`
  String get accounts {
    return Intl.message(
      'Accounts',
      name: 'accounts',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Operations`
  String get operations {
    return Intl.message(
      'Operations',
      name: 'operations',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `AlbaniaLek`
  String get AlbaniaLek {
    return Intl.message(
      'AlbaniaLek',
      name: 'AlbaniaLek',
      desc: '',
      args: [],
    );
  }

  /// `Afghanistan Afghani`
  String get AfghanistanAfghani {
    return Intl.message(
      'Afghanistan Afghani',
      name: 'AfghanistanAfghani',
      desc: '',
      args: [],
    );
  }

  /// `Argentina Peso`
  String get ArgentinaPeso {
    return Intl.message(
      'Argentina Peso',
      name: 'ArgentinaPeso',
      desc: '',
      args: [],
    );
  }

  /// `Aruba Guilder`
  String get ArubaGuilder {
    return Intl.message(
      'Aruba Guilder',
      name: 'ArubaGuilder',
      desc: '',
      args: [],
    );
  }

  /// `Australia Dollar`
  String get AustraliaDollar {
    return Intl.message(
      'Australia Dollar',
      name: 'AustraliaDollar',
      desc: '',
      args: [],
    );
  }

  /// `Azerbaijan Manat`
  String get AzerbaijanManat {
    return Intl.message(
      'Azerbaijan Manat',
      name: 'AzerbaijanManat',
      desc: '',
      args: [],
    );
  }

  /// `Bahamas Dollar`
  String get BahamasDollar {
    return Intl.message(
      'Bahamas Dollar',
      name: 'BahamasDollar',
      desc: '',
      args: [],
    );
  }

  /// `Barbados Dollar`
  String get BarbadosDollar {
    return Intl.message(
      'Barbados Dollar',
      name: 'BarbadosDollar',
      desc: '',
      args: [],
    );
  }

  /// `Belarus Ruble`
  String get BelarusRuble {
    return Intl.message(
      'Belarus Ruble',
      name: 'BelarusRuble',
      desc: '',
      args: [],
    );
  }

  /// `Belize Dollar`
  String get BelizeDollar {
    return Intl.message(
      'Belize Dollar',
      name: 'BelizeDollar',
      desc: '',
      args: [],
    );
  }

  /// `Bermuda Dollar`
  String get BermudaDollar {
    return Intl.message(
      'Bermuda Dollar',
      name: 'BermudaDollar',
      desc: '',
      args: [],
    );
  }

  /// `Bolivia Boliviano`
  String get BoliviaBoliviano {
    return Intl.message(
      'Bolivia Boliviano',
      name: 'BoliviaBoliviano',
      desc: '',
      args: [],
    );
  }

  /// `Bosnia and Herzegovina Convertible Mark`
  String get BosniaAndHerzegovinaConvertibleMark {
    return Intl.message(
      'Bosnia and Herzegovina Convertible Mark',
      name: 'BosniaAndHerzegovinaConvertibleMark',
      desc: '',
      args: [],
    );
  }

  /// `Botswana Pula`
  String get BotswanaPula {
    return Intl.message(
      'Botswana Pula',
      name: 'BotswanaPula',
      desc: '',
      args: [],
    );
  }

  /// `Bulgaria Lev`
  String get BulgariaLev {
    return Intl.message(
      'Bulgaria Lev',
      name: 'BulgariaLev',
      desc: '',
      args: [],
    );
  }

  /// `Brazil Real`
  String get BrazilReal {
    return Intl.message(
      'Brazil Real',
      name: 'BrazilReal',
      desc: '',
      args: [],
    );
  }

  /// `Brunei Darussalam Dollar`
  String get BruneiDarussalamDollar {
    return Intl.message(
      'Brunei Darussalam Dollar',
      name: 'BruneiDarussalamDollar',
      desc: '',
      args: [],
    );
  }

  /// `Cambodia Riel`
  String get CambodiaRiel {
    return Intl.message(
      'Cambodia Riel',
      name: 'CambodiaRiel',
      desc: '',
      args: [],
    );
  }

  /// `Canada Dollar`
  String get CanadaDollar {
    return Intl.message(
      'Canada Dollar',
      name: 'CanadaDollar',
      desc: '',
      args: [],
    );
  }

  /// `Cayman Islands Dollar`
  String get CaymanIslandsDollar {
    return Intl.message(
      'Cayman Islands Dollar',
      name: 'CaymanIslandsDollar',
      desc: '',
      args: [],
    );
  }

  /// `Chile Peso`
  String get ChilePeso {
    return Intl.message(
      'Chile Peso',
      name: 'ChilePeso',
      desc: '',
      args: [],
    );
  }

  /// `China Yuan Renminbi`
  String get ChinaYuanRenminbi {
    return Intl.message(
      'China Yuan Renminbi',
      name: 'ChinaYuanRenminbi',
      desc: '',
      args: [],
    );
  }

  /// `Colombia Peso`
  String get ColombiaPeso {
    return Intl.message(
      'Colombia Peso',
      name: 'ColombiaPeso',
      desc: '',
      args: [],
    );
  }

  /// `Costa Rica Colon`
  String get CostaRicaColon {
    return Intl.message(
      'Costa Rica Colon',
      name: 'CostaRicaColon',
      desc: '',
      args: [],
    );
  }

  /// `Croatia Kuna`
  String get CroatiaKuna {
    return Intl.message(
      'Croatia Kuna',
      name: 'CroatiaKuna',
      desc: '',
      args: [],
    );
  }

  /// `Cuba Peso`
  String get CubaPeso {
    return Intl.message(
      'Cuba Peso',
      name: 'CubaPeso',
      desc: '',
      args: [],
    );
  }

  /// `Czech Republic Koruna`
  String get CzechRepublicKoruna {
    return Intl.message(
      'Czech Republic Koruna',
      name: 'CzechRepublicKoruna',
      desc: '',
      args: [],
    );
  }

  /// `Denmark Krone`
  String get DenmarkKrone {
    return Intl.message(
      'Denmark Krone',
      name: 'DenmarkKrone',
      desc: '',
      args: [],
    );
  }

  /// `Dominican Republic Peso`
  String get DominicanRepublicPeso {
    return Intl.message(
      'Dominican Republic Peso',
      name: 'DominicanRepublicPeso',
      desc: '',
      args: [],
    );
  }

  /// `East Caribbean Dollar`
  String get EastCaribbeanDollar {
    return Intl.message(
      'East Caribbean Dollar',
      name: 'EastCaribbeanDollar',
      desc: '',
      args: [],
    );
  }

  /// `Egypt Pound`
  String get EgyptPound {
    return Intl.message(
      'Egypt Pound',
      name: 'EgyptPound',
      desc: '',
      args: [],
    );
  }

  /// `El Salvador Colon`
  String get ElSalvadorColon {
    return Intl.message(
      'El Salvador Colon',
      name: 'ElSalvadorColon',
      desc: '',
      args: [],
    );
  }

  /// `Euro`
  String get EuroMemberCountries {
    return Intl.message(
      'Euro',
      name: 'EuroMemberCountries',
      desc: '',
      args: [],
    );
  }

  /// `Falkland Islands Malvinas Pound`
  String get FalklandIslandsMalvinasPound {
    return Intl.message(
      'Falkland Islands Malvinas Pound',
      name: 'FalklandIslandsMalvinasPound',
      desc: '',
      args: [],
    );
  }

  /// `Fiji Dollar`
  String get FijiDollar {
    return Intl.message(
      'Fiji Dollar',
      name: 'FijiDollar',
      desc: '',
      args: [],
    );
  }

  /// `Ghana Cedi`
  String get GhanaCedi {
    return Intl.message(
      'Ghana Cedi',
      name: 'GhanaCedi',
      desc: '',
      args: [],
    );
  }

  /// `Gibraltar Pound`
  String get GibraltarPound {
    return Intl.message(
      'Gibraltar Pound',
      name: 'GibraltarPound',
      desc: '',
      args: [],
    );
  }

  /// `Guatemala Quetzal`
  String get GuatemalaQuetzal {
    return Intl.message(
      'Guatemala Quetzal',
      name: 'GuatemalaQuetzal',
      desc: '',
      args: [],
    );
  }

  /// `Guernsey Pound`
  String get GuernseyPound {
    return Intl.message(
      'Guernsey Pound',
      name: 'GuernseyPound',
      desc: '',
      args: [],
    );
  }

  /// `Guyana Dollar`
  String get GuyanaDollar {
    return Intl.message(
      'Guyana Dollar',
      name: 'GuyanaDollar',
      desc: '',
      args: [],
    );
  }

  /// `Honduras Lempira`
  String get HondurasLempira {
    return Intl.message(
      'Honduras Lempira',
      name: 'HondurasLempira',
      desc: '',
      args: [],
    );
  }

  /// `Hong Kong Dollar`
  String get HongKongDollar {
    return Intl.message(
      'Hong Kong Dollar',
      name: 'HongKongDollar',
      desc: '',
      args: [],
    );
  }

  /// `Hungary Forint`
  String get HungaryForint {
    return Intl.message(
      'Hungary Forint',
      name: 'HungaryForint',
      desc: '',
      args: [],
    );
  }

  /// `Iceland Krona`
  String get IcelandKrona {
    return Intl.message(
      'Iceland Krona',
      name: 'IcelandKrona',
      desc: '',
      args: [],
    );
  }

  /// `India Rupee`
  String get IndiaRupee {
    return Intl.message(
      'India Rupee',
      name: 'IndiaRupee',
      desc: '',
      args: [],
    );
  }

  /// `Indonesia Rupiah`
  String get IndonesiaRupiah {
    return Intl.message(
      'Indonesia Rupiah',
      name: 'IndonesiaRupiah',
      desc: '',
      args: [],
    );
  }

  /// `Iran Rial`
  String get IranRial {
    return Intl.message(
      'Iran Rial',
      name: 'IranRial',
      desc: '',
      args: [],
    );
  }

  /// `Isle of Man Pound`
  String get IsleOfManPound {
    return Intl.message(
      'Isle of Man Pound',
      name: 'IsleOfManPound',
      desc: '',
      args: [],
    );
  }

  /// `Israel Shekel`
  String get IsraelShekel {
    return Intl.message(
      'Israel Shekel',
      name: 'IsraelShekel',
      desc: '',
      args: [],
    );
  }

  /// `Jamaica Dollar`
  String get JamaicaDollar {
    return Intl.message(
      'Jamaica Dollar',
      name: 'JamaicaDollar',
      desc: '',
      args: [],
    );
  }

  /// `Japan Yen`
  String get JapanYen {
    return Intl.message(
      'Japan Yen',
      name: 'JapanYen',
      desc: '',
      args: [],
    );
  }

  /// `Jersey Pound`
  String get JerseyPound {
    return Intl.message(
      'Jersey Pound',
      name: 'JerseyPound',
      desc: '',
      args: [],
    );
  }

  /// `Kazakhstan Tenge`
  String get KazakhstanTenge {
    return Intl.message(
      'Kazakhstan Tenge',
      name: 'KazakhstanTenge',
      desc: '',
      args: [],
    );
  }

  /// `Korea (North) Won`
  String get KoreaNorthWon {
    return Intl.message(
      'Korea (North) Won',
      name: 'KoreaNorthWon',
      desc: '',
      args: [],
    );
  }

  /// `Korea (South) Won`
  String get KoreaSouthWon {
    return Intl.message(
      'Korea (South) Won',
      name: 'KoreaSouthWon',
      desc: '',
      args: [],
    );
  }

  /// `Kyrgyzstan Som`
  String get KyrgyzstanSom {
    return Intl.message(
      'Kyrgyzstan Som',
      name: 'KyrgyzstanSom',
      desc: '',
      args: [],
    );
  }

  /// `Laos Kip`
  String get LaosKip {
    return Intl.message(
      'Laos Kip',
      name: 'LaosKip',
      desc: '',
      args: [],
    );
  }

  /// `Lebanon Pound`
  String get LebanonPound {
    return Intl.message(
      'Lebanon Pound',
      name: 'LebanonPound',
      desc: '',
      args: [],
    );
  }

  /// `Liberia Dollar`
  String get LiberiaDollar {
    return Intl.message(
      'Liberia Dollar',
      name: 'LiberiaDollar',
      desc: '',
      args: [],
    );
  }

  /// `Macedonia Denar`
  String get MacedoniaDenar {
    return Intl.message(
      'Macedonia Denar',
      name: 'MacedoniaDenar',
      desc: '',
      args: [],
    );
  }

  /// `Malaysia Ringgit`
  String get MalaysiaRinggit {
    return Intl.message(
      'Malaysia Ringgit',
      name: 'MalaysiaRinggit',
      desc: '',
      args: [],
    );
  }

  /// `Mauritius Rupee`
  String get MauritiusRupee {
    return Intl.message(
      'Mauritius Rupee',
      name: 'MauritiusRupee',
      desc: '',
      args: [],
    );
  }

  /// `Mexico Peso`
  String get MexicoPeso {
    return Intl.message(
      'Mexico Peso',
      name: 'MexicoPeso',
      desc: '',
      args: [],
    );
  }

  /// `Mongolia Tughrik`
  String get MongoliaTughrik {
    return Intl.message(
      'Mongolia Tughrik',
      name: 'MongoliaTughrik',
      desc: '',
      args: [],
    );
  }

  /// `Mozambique Metical`
  String get MozambiqueMetical {
    return Intl.message(
      'Mozambique Metical',
      name: 'MozambiqueMetical',
      desc: '',
      args: [],
    );
  }

  /// `Namibia Dollar`
  String get NamibiaDollar {
    return Intl.message(
      'Namibia Dollar',
      name: 'NamibiaDollar',
      desc: '',
      args: [],
    );
  }

  /// `Nepal Rupee`
  String get NepalRupee {
    return Intl.message(
      'Nepal Rupee',
      name: 'NepalRupee',
      desc: '',
      args: [],
    );
  }

  /// `Netherlands Antilles Guilder`
  String get NetherlandsAntillesGuilder {
    return Intl.message(
      'Netherlands Antilles Guilder',
      name: 'NetherlandsAntillesGuilder',
      desc: '',
      args: [],
    );
  }

  /// `New Zealand Dollar`
  String get NewZealandDollar {
    return Intl.message(
      'New Zealand Dollar',
      name: 'NewZealandDollar',
      desc: '',
      args: [],
    );
  }

  /// `Nicaragua Cordoba`
  String get NicaraguaCordoba {
    return Intl.message(
      'Nicaragua Cordoba',
      name: 'NicaraguaCordoba',
      desc: '',
      args: [],
    );
  }

  /// `Nigeria Naira`
  String get NigeriaNaira {
    return Intl.message(
      'Nigeria Naira',
      name: 'NigeriaNaira',
      desc: '',
      args: [],
    );
  }

  /// `Norway Krone`
  String get NorwayKrone {
    return Intl.message(
      'Norway Krone',
      name: 'NorwayKrone',
      desc: '',
      args: [],
    );
  }

  /// `Oman Rial`
  String get OmanRial {
    return Intl.message(
      'Oman Rial',
      name: 'OmanRial',
      desc: '',
      args: [],
    );
  }

  /// `Pakistan Rupee`
  String get PakistanRupee {
    return Intl.message(
      'Pakistan Rupee',
      name: 'PakistanRupee',
      desc: '',
      args: [],
    );
  }

  /// `Panama Balboa`
  String get PanamaBalboa {
    return Intl.message(
      'Panama Balboa',
      name: 'PanamaBalboa',
      desc: '',
      args: [],
    );
  }

  /// `Paraguay Guarani`
  String get ParaguayGuarani {
    return Intl.message(
      'Paraguay Guarani',
      name: 'ParaguayGuarani',
      desc: '',
      args: [],
    );
  }

  /// `Peru Sol`
  String get PeruSol {
    return Intl.message(
      'Peru Sol',
      name: 'PeruSol',
      desc: '',
      args: [],
    );
  }

  /// `Philippines Peso`
  String get PhilippinesPeso {
    return Intl.message(
      'Philippines Peso',
      name: 'PhilippinesPeso',
      desc: '',
      args: [],
    );
  }

  /// `Poland Zloty`
  String get PolandZloty {
    return Intl.message(
      'Poland Zloty',
      name: 'PolandZloty',
      desc: '',
      args: [],
    );
  }

  /// `Qatar Riyal`
  String get QatarRiyal {
    return Intl.message(
      'Qatar Riyal',
      name: 'QatarRiyal',
      desc: '',
      args: [],
    );
  }

  /// `Romania Leu`
  String get RomaniaLeu {
    return Intl.message(
      'Romania Leu',
      name: 'RomaniaLeu',
      desc: '',
      args: [],
    );
  }

  /// `Russia Ruble`
  String get RussiaRuble {
    return Intl.message(
      'Russia Ruble',
      name: 'RussiaRuble',
      desc: '',
      args: [],
    );
  }

  /// `Saint Helena Pound`
  String get SaintHelenaPound {
    return Intl.message(
      'Saint Helena Pound',
      name: 'SaintHelenaPound',
      desc: '',
      args: [],
    );
  }

  /// `Saudi Arabia Riyal`
  String get SaudiArabiaRiyal {
    return Intl.message(
      'Saudi Arabia Riyal',
      name: 'SaudiArabiaRiyal',
      desc: '',
      args: [],
    );
  }

  /// `Serbia Dinar`
  String get SerbiaDinar {
    return Intl.message(
      'Serbia Dinar',
      name: 'SerbiaDinar',
      desc: '',
      args: [],
    );
  }

  /// `Seychelles Rupee`
  String get SeychellesRupee {
    return Intl.message(
      'Seychelles Rupee',
      name: 'SeychellesRupee',
      desc: '',
      args: [],
    );
  }

  /// `Singapore Dollar`
  String get SingaporeDollar {
    return Intl.message(
      'Singapore Dollar',
      name: 'SingaporeDollar',
      desc: '',
      args: [],
    );
  }

  /// `Solomon Islands Dollar`
  String get SolomonIslandsDollar {
    return Intl.message(
      'Solomon Islands Dollar',
      name: 'SolomonIslandsDollar',
      desc: '',
      args: [],
    );
  }

  /// `Somalia Shilling`
  String get SomaliaShilling {
    return Intl.message(
      'Somalia Shilling',
      name: 'SomaliaShilling',
      desc: '',
      args: [],
    );
  }

  /// `South Africa Rand`
  String get SouthAfricaRand {
    return Intl.message(
      'South Africa Rand',
      name: 'SouthAfricaRand',
      desc: '',
      args: [],
    );
  }

  /// `Sri Lanka Rupee`
  String get SriLankaRupee {
    return Intl.message(
      'Sri Lanka Rupee',
      name: 'SriLankaRupee',
      desc: '',
      args: [],
    );
  }

  /// `Sweden Krona`
  String get SwedenKrona {
    return Intl.message(
      'Sweden Krona',
      name: 'SwedenKrona',
      desc: '',
      args: [],
    );
  }

  /// `Switzerland Franc`
  String get SwitzerlandFranc {
    return Intl.message(
      'Switzerland Franc',
      name: 'SwitzerlandFranc',
      desc: '',
      args: [],
    );
  }

  /// `Suriname Dollar`
  String get SurinameDollar {
    return Intl.message(
      'Suriname Dollar',
      name: 'SurinameDollar',
      desc: '',
      args: [],
    );
  }

  /// `Syria Pound`
  String get SyriaPound {
    return Intl.message(
      'Syria Pound',
      name: 'SyriaPound',
      desc: '',
      args: [],
    );
  }

  /// `Taiwan New Dollar`
  String get TaiwanNewDollar {
    return Intl.message(
      'Taiwan New Dollar',
      name: 'TaiwanNewDollar',
      desc: '',
      args: [],
    );
  }

  /// `Thailand Baht`
  String get ThailandBaht {
    return Intl.message(
      'Thailand Baht',
      name: 'ThailandBaht',
      desc: '',
      args: [],
    );
  }

  /// `Trinidad and Tobago Dollar`
  String get TrinidadAndTobagoDollar {
    return Intl.message(
      'Trinidad and Tobago Dollar',
      name: 'TrinidadAndTobagoDollar',
      desc: '',
      args: [],
    );
  }

  /// `Turkey Lira`
  String get TurkeyLira {
    return Intl.message(
      'Turkey Lira',
      name: 'TurkeyLira',
      desc: '',
      args: [],
    );
  }

  /// `Tuvalu Dollar`
  String get TuvaluDollar {
    return Intl.message(
      'Tuvalu Dollar',
      name: 'TuvaluDollar',
      desc: '',
      args: [],
    );
  }

  /// `Ukraine Hryvnia`
  String get UkraineHryvnia {
    return Intl.message(
      'Ukraine Hryvnia',
      name: 'UkraineHryvnia',
      desc: '',
      args: [],
    );
  }

  /// `United Kingdom Pound`
  String get UnitedKingdomPound {
    return Intl.message(
      'United Kingdom Pound',
      name: 'UnitedKingdomPound',
      desc: '',
      args: [],
    );
  }

  /// `United States Dollar`
  String get UnitedStatesDollar {
    return Intl.message(
      'United States Dollar',
      name: 'UnitedStatesDollar',
      desc: '',
      args: [],
    );
  }

  /// `Uruguay Peso`
  String get UruguayPeso {
    return Intl.message(
      'Uruguay Peso',
      name: 'UruguayPeso',
      desc: '',
      args: [],
    );
  }

  /// `Uzbekistan Som`
  String get UzbekistanSom {
    return Intl.message(
      'Uzbekistan Som',
      name: 'UzbekistanSom',
      desc: '',
      args: [],
    );
  }

  /// `Venezuela Bolivar`
  String get VenezuelaBolivar {
    return Intl.message(
      'Venezuela Bolivar',
      name: 'VenezuelaBolivar',
      desc: '',
      args: [],
    );
  }

  /// `Vietnam Dong`
  String get VietnamDong {
    return Intl.message(
      'Vietnam Dong',
      name: 'VietnamDong',
      desc: '',
      args: [],
    );
  }

  /// `Yemen Rial`
  String get YemenRial {
    return Intl.message(
      'Yemen Rial',
      name: 'YemenRial',
      desc: '',
      args: [],
    );
  }

  /// `Zimbabwe Dollar`
  String get ZimbabweDollar {
    return Intl.message(
      'Zimbabwe Dollar',
      name: 'ZimbabweDollar',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get card {
    return Intl.message(
      'Card',
      name: 'card',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Icon`
  String get icon {
    return Intl.message(
      'Icon',
      name: 'icon',
      desc: '',
      args: [],
    );
  }

  /// `AccountType`
  String get accountType {
    return Intl.message(
      'AccountType',
      name: 'accountType',
      desc: '',
      args: [],
    );
  }

  /// `Regular`
  String get regular {
    return Intl.message(
      'Regular',
      name: 'regular',
      desc: '',
      args: [],
    );
  }

  /// `Saving`
  String get saving {
    return Intl.message(
      'Saving',
      name: 'saving',
      desc: '',
      args: [],
    );
  }

  /// `Account Currency`
  String get accountCurrency {
    return Intl.message(
      'Account Currency',
      name: 'accountCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Current Balance`
  String get currentBalance {
    return Intl.message(
      'Current Balance',
      name: 'currentBalance',
      desc: '',
      args: [],
    );
  }

  /// `Goal`
  String get goal {
    return Intl.message(
      'Goal',
      name: 'goal',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Enable`
  String get enable {
    return Intl.message(
      'Enable',
      name: 'enable',
      desc: '',
      args: [],
    );
  }

  /// `Disable`
  String get disable {
    return Intl.message(
      'Disable',
      name: 'disable',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Regular Accounts.`
  String get regularAccounts {
    return Intl.message(
      'Regular Accounts.',
      name: 'regularAccounts',
      desc: '',
      args: [],
    );
  }

  /// `Savings Accounts.`
  String get savingsAccounts {
    return Intl.message(
      'Savings Accounts.',
      name: 'savingsAccounts',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Minimum Amount`
  String get minimumAmount {
    return Intl.message(
      'Minimum Amount',
      name: 'minimumAmount',
      desc: '',
      args: [],
    );
  }

  /// `Icons`
  String get icons {
    return Intl.message(
      'Icons',
      name: 'icons',
      desc: '',
      args: [],
    );
  }

  /// `Select Icon`
  String get selectIcon {
    return Intl.message(
      'Select Icon',
      name: 'selectIcon',
      desc: '',
      args: [],
    );
  }

  /// `Select Color`
  String get selectColor {
    return Intl.message(
      'Select Color',
      name: 'selectColor',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Primary currency cannot be changed.`
  String get currencyNotChange {
    return Intl.message(
      'Primary currency cannot be changed.',
      name: 'currencyNotChange',
      desc: '',
      args: [],
    );
  }

  /// `Create Category`
  String get createCategory {
    return Intl.message(
      'Create Category',
      name: 'createCategory',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get january {
    return Intl.message(
      'January',
      name: 'january',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get february {
    return Intl.message(
      'February',
      name: 'february',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get march {
    return Intl.message(
      'March',
      name: 'march',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get april {
    return Intl.message(
      'April',
      name: 'april',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get may {
    return Intl.message(
      'May',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `Jun`
  String get jun {
    return Intl.message(
      'Jun',
      name: 'jun',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get july {
    return Intl.message(
      'July',
      name: 'july',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get august {
    return Intl.message(
      'August',
      name: 'august',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get september {
    return Intl.message(
      'September',
      name: 'september',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get october {
    return Intl.message(
      'October',
      name: 'october',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get november {
    return Intl.message(
      'November',
      name: 'november',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get december {
    return Intl.message(
      'December',
      name: 'december',
      desc: '',
      args: [],
    );
  }

  /// `Select Month`
  String get selectMonth {
    return Intl.message(
      'Select Month',
      name: 'selectMonth',
      desc: '',
      args: [],
    );
  }

  /// `All Time`
  String get allTime {
    return Intl.message(
      'All Time',
      name: 'allTime',
      desc: '',
      args: [],
    );
  }

  /// `Select Year`
  String get selectYear {
    return Intl.message(
      'Select Year',
      name: 'selectYear',
      desc: '',
      args: [],
    );
  }

  /// `Select Day`
  String get selectDay {
    return Intl.message(
      'Select Day',
      name: 'selectDay',
      desc: '',
      args: [],
    );
  }

  /// `Select Range`
  String get selectRange {
    return Intl.message(
      'Select Range',
      name: 'selectRange',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
