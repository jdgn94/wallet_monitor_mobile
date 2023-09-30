import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';
import 'package:wallet_monitor/src/widgets/settings/picker_color_selector.widget.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.widget.dart';
import 'package:wallet_monitor/src/widgets/utils/icon.widget.dart';

class IconSelectorWidget extends StatefulWidget {
  final Function(Color, String) confirm;
  final Color? defaultColor;
  final String? defaultIcon;
  final bool onlyIcon;
  const IconSelectorWidget({
    super.key,
    required this.confirm,
    this.defaultColor,
    this.defaultIcon,
    this.onlyIcon = false,
  });

  @override
  State<IconSelectorWidget> createState() => _IconSelectorWidgetState();
}

class _IconSelectorWidgetState extends State<IconSelectorWidget> {
  late TextEditingController _iconController;
  late String iconSelected;
  late Color colorSelected;
  late String iconCategory;
  late Color colorCategory;
  final List<String> _accountsIcons = [
    "bank",
    "bankOutline",
    "cash",
    "cashMultiple",
    "cash100",
    "creditCardOutline",
    "fileOutline",
    "giftOutline",
    "piggyBank",
    "piggyBankOutline",
    "simOutline",
    "wallet",
    "walletOutline",
    "walletBifold",
    "walletBifoldOutline",
    "walletGiftCard",
    "walletMembership",
  ];
  final List<String> _foodAndDrinkIcons = [
    "silverwareForkKnife",
    "silverwareVariant",
    "food",
    "foodOutline",
    "foodDrumstick",
    "foodDrumstickOutline",
    "pasta",
    "noodles",
    "pizza",
    "tea",
    "coffee",
    "cup",
    "beer",
    "glassWine",
    "glassCocktail",
    "glassMugVariant",
    "liquor",
  ];
  final List<String> _homeIcons = [
    "home",
    "garage",
    "alarmPanel",
    "fan",
    "bedEmpty",
    "mirror",
    "dresserOutline",
    "desk",
    "sofaOutline",
    "ceilingLight",
    "powerPlug",
    "lamp",
    "lightbulb",
    "connection",
    "door",
    "shower",
    "countertopOutline",
    "faucet",
    "faucetVariant",
    "blender",
    "stove",
    "fridgeOutline",
    "washingMachine",
    "broom",
    "sprayBottle",
    "formatPaint",
  ];
  final List<String> _personalCareIcons = [
    "contentCut",
    "faceWomanShimmer",
    "faceManShimmer",
    "hairDryerOutline",
    "lipstick",
    "lotion",
    "spray",
    "toothbrush",
    "toothbrushElectric",
    "toothbrushPaste",
  ];
  final List<String> _transportIcons = [
    "airplane",
    "airplaneTakeoff",
    "planeCar",
    "planeTrain",
    "helicopter",
    "airballoonOutline",
    "bagCarryOn",
    "bagChecked",
    "atv",
    "bicycle",
    "golfCart",
    "gondola",
    "scooter",
    "subwayVariant",
    "train",
    "trainCar",
    "trainCarCaboose",
    "bus",
    "car",
    "taxi",
    "truck",
    "vanUtility",
    "ferry",
    "sailBoat",
  ];
  final List<String> _educationIcons = [
    "book",
    "bookOutline",
    "bookMultiple",
    "bookMultipleOutline",
    "bookOpenVariant",
    "bookshelf",
    "notebook",
    "notebookOutline",
    "notebookMultiple",
    "notebookMultipleOutline",
    "bagPersonal",
    "bagPersonalOutline",
    "mathCompass",
    "pencil",
    "pencilOutline",
    "greasePencil",
    "fountainPen",
    "leadPencil",
    "pen",
    "pencilRuler",
    "pencilRulerOutline",
    "ruler",
    "rulerSquare",
    "paperclip",
    "note",
    "noteOutline",
    "noteMultiple",
    "noteMultipleOutline",
    "beakerOutline",
    "flaskOutline",
    "flaskRoundBottom",
    "testTube",
    "calculatorVariant",
    "calculatorVariantOutline",
    "translate",
    "translateVariant",
  ];
  final List<String> _healthAndMedicalIcons = [
    "accountHeart",
    "accountHeartOutline",
    "accountInjury",
    "accountInjuryOutline",
    "allergy",
    "bacteria",
    "bacteriaOutline",
    "virus",
    "virusOutline",
    "bloodBag",
    "clipboardPulse",
    "clipboardPulseOutline",
    "diabetes",
    "doctor",
    "earHearing",
    "emoticonSick",
    "emoticonSickOutline",
    "heart",
    "heartPulse",
    "hospitalBox",
    "hospitalBoxOutline",
    "hospitalBuilding",
    "humanCane",
    "humanWalker",
    "humanWheelchair",
    "humanWhiteCane",
    "lotionPlus",
    "lotionPlusOutline",
    "medicalBag",
    "medicalCottonSwab",
    "medication",
    "medicationOutline",
    "needle",
    "pill",
    "pillMultiple",
    "pulse",
    "reproduction",
    "stethoscope",
    "stomach",
    "lungs",
    "radiologyBox",
    "radiologyBoxOutline",
    "tooth",
    "toothOutline",
    "wheelchair",
  ];
  final List<String> _entertainmentIcons = [
    "gamepad",
    "gamepadRound",
    "gamepadCircle",
    "disc",
    "discPlayer",
    "popcorn",
    "filmstrip",
    "filmstripBox",
    "filmstripBoxMultiple",
    "multimedia",
    "music",
    "musicBox",
    "musicBoxMultiple",
    "musicCircle",
    "shoppingMusic",
    "cast",
  ];
  final List<String> _shopIcons = [
    "basket",
    "shopping",
    "cartOutline",
    "store",
    "storefront",
    "giftOutline",
    "glasses",
    "sunglasses",
    "hanger",
    "hatFedora",
    "lingerie",
    "necklace",
    "shoeCleat",
    "shoeFormal",
    "shoeHeel",
    "shoeSneaker",
    "tie",
    "tshirtCrew",
    "tshirtCrewOutline",
  ];
  final List<String> _technologyIcons = [
    "radio",
    "remoteTv",
    "controller",
    "controllerClassic",
    "gamepadVariant",
    "gamepadSquare",
    "setTopBox",
    "desktopClassic",
    "desktopTower",
    "desktopTowerMonitor",
    "laptop",
    "projector",
    "watch",
    "television",
    "televisionClassic",
    "monitor",
    "tablet",
    "cellphone",
    "camera",
    "earbuds",
    "headphones",
    "microphone",
    "robotOutline",
  ];
  final List<String> _sportIcons = [
    "badminton",
    "baseballOutline",
    "basketball",
    "bowling",
    "billiards",
    "football",
    "rugby",
    "volleyball",
    "soccer",
    "cricket",
    "tableTennis",
    "tennis",
    "dumbbell",
    "fencing",
    "arrowProjectile",
    "boxingGlove",
    "golf",
    "jumpRope",
    "kite",
    "skate",
    "rollerblade",
    "skateboard",
    "racingHelmet",
    "divingScubaMask",
    "divingScuba",
    "gymnastics",
    "paragliding",
    "hiking",
    "run",
    "karate",
    "swim",
    "rowing",
    "bike",
  ];
  final List<String> _natureIcons = [
    "bug",
    "ladybug",
    "bee",
    "spider",
    "paw",
    "beehiveOutline",
    "butterfly",
    "clover",
    "flower",
    "flowerPollen",
    "flowerPoppy",
    "flowerTulip",
    "cactus",
    "nature",
    "tree",
    "pineTree",
    "pineTreeVariant",
    "forest",
    "leaf",
    "leafMaple",
    "cannabis",
    "mushroom",
    "grass",
    "sprout",
    "seed",
    "greenhouse",
  ];
  final List<String> _serviceIcons = [
    "lock",
    "lockOutline",
    "alarmBell",
    "alarmLight",
    "cctv",
    "broom",
    "wrench",
    "pipe",
    "pipeLeak",
    "tankerTruck",
    "truckCargoContainer",
    "towTruck",
    "dumpTruck",
    "carWash",
    "carWireless",
    "carWrench",
    "gasStation",
    "phone",
    "sim",
    "lightbulbOnOutline",
    "lightningBolt",
    "waterOutline",
    "coffin",
  ];
  final List<String> _peopleIcons = [
    "account",
    "accountMultiple",
    "accountHardHat",
    "accountHeart",
    "accountTie",
    "accountSchool",
    "accountTieWoman",
    "baby",
    "babyBuggy",
    "cradle",
    "faceMan",
    "faceWoman",
    "humanDolly",
    "humanMale",
    "humanFemale",
  ];
  final List<String> _specialIcons = [
    "android",
    "apple",
    "_appStore",
    "_applePay",
    "facebook",
    "instagram",
    "linkedin",
    "twitter",
    "twitch",
    "youtube",
    "google",
    "googlePlay",
    "_googlePay",
    "microsoft",
    "microsoftAzure",
    "microsoftOffice",
    "_adobeCloud",
    "atlassian",
    "aws",
    "wordpress",
    "digitalOcean",
    "googleDrive",
    "dropbox",
    "_amazon",
    "_ebay",
    "_mercadoLibre",
    "nintendoSwitch",
    "sonyPlaystation",
    "microsoftXbox",
    "steam",
    "_epicGames",
    "origin",
    "_ea",
    "ubisoft",
    "unity",
    "unreal",
    "spotify",
    "_deezer",
    "soundcloud",
    "pandora",
    "_tidal",
    "_appleMusic",
    "_amazonMusic",
    "_youtubeMusic",
    "netflix",
    "_disneyPlus",
    "_primeVideo",
    "hulu",
    "_hboMax",
    "patreon",
    "_paypal",
    "_stripe",
  ];

  @override
  void initState() {
    _iconController = TextEditingController(text: " ");
    iconCategory = widget.defaultIcon ?? "none";
    colorCategory = widget.defaultColor ??
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);
    super.initState();
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  void _openChangeIcon() {
    setState(() {
      iconSelected = iconCategory;
      colorSelected = colorCategory;
    });
    showDialog(context: context, builder: _dialogIcon);
  }

  void changeIconSubcategory(String newIcon) {
    print(newIcon);
    setState(() {
      iconCategory = newIcon;
    });
  }

  void openIconSelectorSubcategory() {
    showDialog(
      context: context,
      builder: (context) => _dialogIconSelector(
        context,
        setState,
        iconCategory,
        changeIconSubcategory,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onlyIcon) {
      return Column(
        children: [
          Text(S.current.icon),
          const SizedBox(
            height: 5,
            width: double.infinity,
          ),
          InkWell(
            onTap: openIconSelectorSubcategory,
            child: _iconPreview(iconCategory, colorCategory),
          ),
        ],
      );
    } else {
      return SizedBox(
        height: 64,
        child: Stack(
          children: [
            TextField(
              controller: _iconController,
              readOnly: true,
              onTap: _openChangeIcon,
              decoration: InputDecoration(
                label: Text(S.current.icon),
                filled: true,
                fillColor: colorCategory.withAlpha(50),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: _openChangeIcon,
                child: IconWidget(
                  iconName: iconCategory,
                  color: colorCategory.withAlpha(255),
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  StatefulBuilder _dialogIcon(BuildContext context) {
    String iconCategoryTemp = iconCategory;
    Color colorCategoryTemp = colorCategory;
    return StatefulBuilder(builder: (localContext, localSetState) {
      void changeIcon(String newIcon) {
        print(newIcon);
        localSetState(() {
          iconCategoryTemp = newIcon;
        });
      }

      void openIconSelector() {
        showDialog(
          context: context,
          builder: (context) => _dialogIconSelector(
            context,
            localSetState,
            iconCategoryTemp,
            changeIcon,
          ),
        );
      }

      void changeColorAndIcon() {
        setState(() {
          iconCategory = iconCategoryTemp;
          colorCategory = colorCategoryTemp;
        });
        Navigator.of(localContext).pop();
        widget.confirm(colorCategory, iconCategory);
      }

      void changeColor(Color newColor) {
        localSetState(() {
          colorCategoryTemp = newColor;
        });
      }

      return OrientationBuilder(builder: (context, orientation) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                _iconPreview(iconCategoryTemp, colorCategoryTemp),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      onPressed: openIconSelector,
                      icon: getIcon("search"),
                      text: S.current.selectIcon,
                      type: ButtonType.selector,
                    ),
                    PickerColorSelectorWidget(
                      type: ButtonType.selector,
                      color: colorCategoryTemp,
                      confirm: changeColor,
                      icon: getIcon("palette"),
                      text: S.current.selectColor,
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(localContext).pop,
              child: Text(S.current.cancel),
            ),
            TextButton(
              onPressed: changeColorAndIcon,
              child: Text(S.current.confirm),
            ),
          ],
        );
      });
    });
  }

  Container _iconPreview(String icon, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withAlpha(50),
      ),
      child: IconWidget(iconName: icon, color: color, size: 35),
    );
  }

  AlertDialog _dialogIconSelector(
    BuildContext context,
    StateSetter changeState,
    String iconSelected,
    Function(String) changeIcon,
  ) {
    return AlertDialog(
      title: Text(S.current.icons),
      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _title(S.current.accounts),
              _iconList(_accountsIcons, iconSelected, changeIcon),
              _title(S.current.foodAndDrink),
              _iconList(_foodAndDrinkIcons, iconSelected, changeIcon),
              _title(S.current.home),
              _iconList(_homeIcons, iconSelected, changeIcon),
              _title(S.current.personalCare),
              _iconList(_personalCareIcons, iconSelected, changeIcon),
              _title(S.current.transport),
              _iconList(_transportIcons, iconSelected, changeIcon),
              _title(S.current.education),
              _iconList(_educationIcons, iconSelected, changeIcon),
              _title(S.current.healthAndMedical),
              _iconList(_healthAndMedicalIcons, iconSelected, changeIcon),
              _title(S.current.entertainment),
              _iconList(_entertainmentIcons, iconSelected, changeIcon),
              _title(S.current.shop),
              _iconList(_shopIcons, iconSelected, changeIcon),
              _title(S.current.technology),
              _iconList(_technologyIcons, iconSelected, changeIcon),
              _title(S.current.sport),
              _iconList(_sportIcons, iconSelected, changeIcon),
              _title(S.current.nature),
              _iconList(_natureIcons, iconSelected, changeIcon),
              _title(S.current.service),
              _iconList(_serviceIcons, iconSelected, changeIcon),
              _title(S.current.people),
              _iconList(_peopleIcons, iconSelected, changeIcon),
              _title(S.current.special),
              _iconList(_specialIcons, iconSelected, changeIcon),
            ],
          ),
        ),
      ),
    );
  }

  Padding _title(String text) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Divider(color: primaryColor)),
          const SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: primaryColor,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(child: Divider(color: primaryColor)),
        ],
      ),
    );
  }

  Material _iconList(
    List<String> list,
    String iconSelected,
    Function(String) changeIcon,
  ) {
    return Material(
      color: Colors.transparent,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: list
            .map((item) => _iconButton(item, iconSelected, changeIcon))
            .toList(),
      ),
    );
  }

  Widget _iconButton(
    String iconName,
    String iconSelected,
    Function(String) action,
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        action(iconName);
      },
      borderRadius: BorderRadius.circular(60),
      child: Ink(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: iconName == iconSelected
              ? Theme.of(context).colorScheme.primary
              : null,
        ),
        child: Center(
          child: IconWidget(
            iconName: iconName,
            size: 40,
            color: iconName == iconSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
