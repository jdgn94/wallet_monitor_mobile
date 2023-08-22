import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/functions/utils.functions.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.widget.dart';
import 'package:wallet_monitor/storage/index.dart';

enum DateType { month, day, year, range, all }

// ignore: must_be_immutable
class CalendarSelectorWidget extends StatefulWidget {
  final SharedPreferences pref;
  final Function(DateTime, DateTime, DateType) changeDates;
  DateTime firstCurrentDate;
  DateTime lastCurrentDate;
  DateType dateType;

  CalendarSelectorWidget({
    super.key,
    required this.pref,
    required this.changeDates,
    required this.firstCurrentDate,
    required this.lastCurrentDate,
    required this.dateType,
  });

  @override
  State<CalendarSelectorWidget> createState() => _CalendarSelectorWidgetState();
}

class _CalendarSelectorWidgetState extends State<CalendarSelectorWidget> {
  DateType dateType = DateType.month;
  DateTime firstCurrentDate = DateTime.now();
  DateTime? lastCurrentDate;

  @override
  void initState() {
    dateType = widget.dateType;
    firstCurrentDate = widget.firstCurrentDate;
    lastCurrentDate = widget.lastCurrentDate;
    super.initState();
  }

  void _changeDates() {
    widget.changeDates(firstCurrentDate, lastCurrentDate!, dateType);
  }

  void _substractDate() {
    final newFirstCurrentDate = dateType == DateType.month
        ? DateTime(firstCurrentDate.year, firstCurrentDate.month - 1)
        : dateType == DateType.year
            ? DateTime(firstCurrentDate.year - 1)
            : DateTime(firstCurrentDate.year, firstCurrentDate.month,
                firstCurrentDate.day - 1);
    setState(() {
      firstCurrentDate = newFirstCurrentDate;
      lastCurrentDate = newFirstCurrentDate;
    });
    _changeDates();
  }

  void _addDate() {
    final newFirstCurrentDate = dateType == DateType.month
        ? DateTime(firstCurrentDate.year, firstCurrentDate.month + 1)
        : dateType == DateType.year
            ? DateTime(firstCurrentDate.year + 1)
            : DateTime(firstCurrentDate.year, firstCurrentDate.month,
                firstCurrentDate.day + 1);
    setState(() {
      firstCurrentDate = newFirstCurrentDate;
      firstCurrentDate = newFirstCurrentDate;
    });
    _changeDates();
  }

  String _datesSelects() {
    switch (dateType.name) {
      case "month":
        return dateFormat(
          firstCurrentDate,
          dateType: DateTypeFormat.monthStringAndYearOnly,
        );
      case "year":
        return firstCurrentDate.year.toString();
      case "day":
        return dateFormat(
          firstCurrentDate,
          dateType: DateTypeFormat.monthString,
        );
      case "range":
        return "${dateFormat(firstCurrentDate, dateType: DateTypeFormat.monthString)} - ${dateFormat(lastCurrentDate!, dateType: DateTypeFormat.monthString)}";
      case "all":
        return S.current.allTime;
      default:
        return "Date not fount";
    }
  }

  void _openDialogSelectMonth() {
    showDialog(context: context, builder: _dialogDate);
  }

  void _openDialogRange() {
    Navigator.of(context).pop();
    showDialog(context: context, builder: _dialogRange);
  }

  void _openDialogMonth(bool onlyYear) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => _dialogMonth(context, onlyYear),
    );
  }

  Future<DateTime?> _showDatePicker(
      {DateTime? minDate, DateTime? maxDate}) async {
    return await showDatePicker(
      context: context,
      firstDate: minDate ?? DateTime(2000),
      initialDate: maxDate ?? DateTime.now(),
      lastDate: maxDate ?? DateTime.now(),
      locale: Locale(widget.pref.getString("lang") ?? "en"),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: S.current.selectDay,
      confirmText: S.current.confirm,
      cancelText: S.current.cancel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buttonPassMonth(),
          _actualMonth(),
          _buttonNextMonth(),
        ],
      ),
    );
  }

  Widget _buttonPassMonth() {
    return IconButton(
      onPressed: dateType == DateType.range ||
              dateType == DateType.all ||
              (dateType == DateType.day &&
                  firstCurrentDate.compareTo(DateTime(2000)) <= 0) ||
              (dateType == DateType.month &&
                  firstCurrentDate.compareTo(DateTime(2000)) <= 0) ||
              (dateType == DateType.year &&
                  firstCurrentDate.compareTo(DateTime(2000)) <= 0)
          ? null
          : _substractDate,
      icon: const Icon(Icons.chevron_left_rounded),
    );
  }

  Widget _actualMonth() {
    return Expanded(
      child: InkWell(
        onTap: _openDialogSelectMonth,
        focusColor: Theme.of(context).colorScheme.primary.withAlpha(100),
        hoverColor: Theme.of(context).colorScheme.primary.withAlpha(100),
        splashColor: Theme.of(context).colorScheme.primary.withAlpha(100),
        highlightColor: Theme.of(context).colorScheme.primary.withAlpha(100),
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.all(7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _datesSelects(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.arrow_drop_down_rounded)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonNextMonth() {
    return IconButton(
      onPressed: dateType == DateType.range ||
              dateType == DateType.all ||
              (dateType == DateType.day &&
                  firstCurrentDate.compareTo(DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day)) >=
                      0) ||
              (dateType == DateType.month &&
                  firstCurrentDate.compareTo(DateTime(
                          DateTime.now().year, DateTime.now().month)) >=
                      0) ||
              (dateType == DateType.year &&
                  firstCurrentDate.compareTo(DateTime(DateTime.now().year)) >=
                      0)
          ? null
          : _addDate,
      icon: const Icon(Icons.chevron_right_rounded),
    );
  }

  StatefulBuilder _dialogDate(BuildContext context) {
    Future<void> selectDate() async {
      final date = await _showDatePicker();

      if (date != null) {
        setState(() {
          firstCurrentDate = date;
          lastCurrentDate = date;
          dateType = DateType.day;
        });
        Navigator.of(context).pop();
        _changeDates();
      }
    }

    void selectAllDates() {
      setState(() {
        firstCurrentDate = DateTime(2000);
        lastCurrentDate = DateTime.now();
        dateType = DateType.all;
      });
      Navigator.of(context).pop();
      _changeDates();
    }

    return StatefulBuilder(builder: (localContext, localSetState) {
      return AlertDialog(
        title: Text(S.current.selectFilter),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 270,
            child: Wrap(
              spacing: 5,
              alignment: WrapAlignment.center,
              children: [
                _buttonBase(
                  asset: "lib/src/assets/icons/calendar_range.svg",
                  text: S.current.selectRange,
                  action: _openDialogRange,
                  width: 265,
                  topLeft: 20,
                  topRight: 20,
                  borderTop: true,
                  borderLeft: true,
                  borderRight: true,
                ),
                _buttonBase(
                  asset: "lib/src/assets/icons/calendar_infinity.svg",
                  text: S.current.allTime,
                  action: selectAllDates,
                  borderLeft: true,
                ),
                _buttonBase(
                  asset: "lib/src/assets/icons/calendar_year.svg",
                  text: S.current.selectYear,
                  action: () => _openDialogMonth(true),
                  borderRight: true,
                ),
                _buttonBase(
                  asset: "lib/src/assets/icons/calendar_month.svg",
                  text: S.current.selectMonth,
                  action: () => _openDialogMonth(false),
                  bottomLeft: 20,
                  borderLeft: true,
                  borderButton: true,
                ),
                _buttonBase(
                  asset: "lib/src/assets/icons/calendar_today.svg",
                  action: selectDate,
                  text: S.current.selectDay,
                  bottomRight: 20,
                  borderRight: true,
                  borderButton: true,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(S.current.cancel),
          ),
        ],
      );
    });
  }

  StatefulBuilder _dialogRange(BuildContext context) {
    DateTime? firstDate;
    DateTime? lastDate;
    return StatefulBuilder(builder: (localContext, localSetState) {
      Future<void> openDatePicker(bool changeFirstDate) async {
        final dateSelected = await _showDatePicker(
          minDate: changeFirstDate ? null : firstDate,
          maxDate: changeFirstDate ? lastDate : null,
        );
        if (dateSelected != null) {
          localSetState(() {
            if (changeFirstDate) {
              firstDate = dateSelected;
            } else {
              lastDate = dateSelected;
            }
          });
        }
      }

      void confirm() {
        setState(() {
          firstCurrentDate = firstDate!;
          lastCurrentDate = lastDate!;
          dateType = DateType.range;
        });
        Navigator.of(context).pop();
        _changeDates();
      }

      return AlertDialog(
        title: Text(S.current.selectRange),
        content: SizedBox(
          width: 270,
          child: Wrap(
            spacing: 5,
            alignment: WrapAlignment.center,
            children: [
              _buttonBase(
                asset: "lib/src/assets/icons/calendar_today.svg",
                action: () => openDatePicker(true),
                text: firstDate == null
                    ? S.current.initDay
                    : dateFormat(firstDate!),
                height: 110,
                bottomLeft: 20,
                topLeft: 20,
                borderButton: true,
                borderLeft: true,
                borderTop: true,
              ),
              _buttonBase(
                asset: "lib/src/assets/icons/calendar_today.svg",
                action: () => openDatePicker(false),
                text: lastDate == null
                    ? S.current.lastDay
                    : dateFormat(lastDate!),
                height: 110,
                topRight: 20,
                bottomRight: 20,
                borderButton: true,
                borderRight: true,
                borderTop: true,
                mirror: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _openDialogSelectMonth();
            },
            child: Text(S.current.cancel),
          ),
          TextButton(
            onPressed: firstDate == null || lastDate == null ? null : confirm,
            child: Text(S.current.confirm),
          ),
        ],
      );
    });
  }

  StatefulBuilder _dialogMonth(BuildContext context, bool onlyYear) {
    final color = Theme.of(context).colorScheme.primary;
    DateTime dateSelected = DateTime.now();
    bool onYear = onlyYear;
    List<int> yearList = [];
    List<int> monthList = [];

    for (int i = 2000; i <= DateTime.now().year; i++) {
      yearList.add(i);
    }

    for (int i = 1; i <= 12; i++) {
      monthList.add(i);
    }
    return StatefulBuilder(builder: (localContext, localSetState) {
      void confirm() {
        setState(() {
          firstCurrentDate = DateTime(
            dateSelected.year,
            onlyYear ? 1 : dateSelected.month,
            1,
          );
          firstCurrentDate = DateTime(
            dateSelected.year,
            onlyYear ? 12 : dateSelected.month,
            31,
          );
          dateType = onlyYear ? DateType.year : DateType.month;
        });
        Navigator.of(context).pop();
        _changeDates();
      }

      void changeCalendarType(bool yearType) {
        localSetState(() {
          onYear = yearType;
        });
      }

      void changeYear(int year) {
        localSetState(() {
          dateSelected = DateTime(year, dateSelected.month);
        });
        if (!onlyYear) changeCalendarType(false);
      }

      void changeMonth(int month) {
        localSetState(() {
          dateSelected = DateTime(dateSelected.year, month);
        });
      }

      List<CustomButton> listMonth() {
        return monthList
            .map(
              (month) => _buttonSpecialDatePicker(
                text: translateMonth(month),
                valueSelect: month == dateSelected.month,
                width: 85,
                action: () => changeMonth(month),
              ),
            )
            .toList();
      }

      List<CustomButton> listYear() {
        return yearList
            .map(
              (year) => _buttonSpecialDatePicker(
                text: year.toString(),
                valueSelect: year == dateSelected.year,
                width: 40,
                action: () => changeYear(year),
              ),
            )
            .toList();
      }

      return AlertDialog(
        title: Text(onYear ? S.current.selectYear : S.current.selectMonth),
        content: SizedBox(
          width: 280,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible: !onYear,
                  child: InkWell(
                    onTap: () => changeCalendarType(true),
                    focusColor: color.withAlpha(50),
                    hoverColor: color.withAlpha(50),
                    splashColor: color.withAlpha(50),
                    borderRadius: BorderRadius.circular(20),
                    child: Ink(
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Text(
                            dateSelected.year.toString(),
                            style: const TextStyle(fontSize: 25),
                          ),
                          const Icon(Icons.arrow_drop_down_rounded, size: 40),
                        ],
                      ),
                    ),
                  ),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  children: onYear ? listYear() : listMonth(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _openDialogSelectMonth();
            },
            child: Text(S.current.cancel),
          ),
          TextButton(
            onPressed: confirm,
            child: Text(S.current.confirm),
          ),
        ],
      );
    });
  }

  Widget _buttonBase({
    required String asset,
    required String text,
    required Function() action,
    double? width,
    double? height,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    bool borderButton = false,
    bool borderTop = false,
    bool borderLeft = false,
    bool borderRight = false,
    bool mirror = false,
  }) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final background = Theme.of(context).scaffoldBackgroundColor;
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InkWell(
        onTap: action,
        focusColor: primaryColor.withAlpha(50),
        hoverColor: primaryColor.withAlpha(50),
        splashColor: primaryColor.withAlpha(50),
        highlightColor: primaryColor.withAlpha(50),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft ?? 0),
          topRight: Radius.circular(topRight ?? 0),
          bottomLeft: Radius.circular(bottomLeft ?? 0),
          bottomRight: Radius.circular(bottomRight ?? 0),
        ),
        child: Ink(
          width: width ?? 130.0,
          height: height ?? 130,
          decoration: BoxDecoration(
            color: background.withAlpha(200),
            border: Border(
              bottom: BorderSide(
                color: primaryColor,
                width: borderButton ? 1.5 : 0.3,
              ),
              left: BorderSide(
                color: primaryColor,
                width: borderLeft ? 1.5 : 0.3,
              ),
              top: BorderSide(
                color: primaryColor,
                width: borderTop ? 1.5 : 0.3,
              ),
              right: BorderSide(
                color: primaryColor,
                width: borderRight ? 1.5 : 0.3,
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft ?? 0),
              topRight: Radius.circular(topRight ?? 0),
              bottomLeft: Radius.circular(bottomLeft ?? 0),
              bottomRight: Radius.circular(bottomRight ?? 0),
            ),
          ),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(mirror ? math.pi : 0),
                child: SvgPicture.asset(asset, height: 55),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Text(
                  text,
                  maxLines: 2,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomButton _buttonSpecialDatePicker({
    required String text,
    required bool valueSelect,
    required double width,
    required Function() action,
  }) {
    return CustomButton(
      onPressed: action,
      text: text,
      borderColor: Colors.transparent,
      textColor: Theme.of(context).colorScheme.onBackground,
      type: valueSelect ? ButtonType.tonal : ButtonType.outline,
      width: width,
    );
  }
}
