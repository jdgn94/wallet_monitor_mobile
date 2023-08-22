import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/bloc/settings/settings_bloc.dart';
import 'package:wallet_monitor/storage/index.dart';

class ThemeSelectorWidget extends StatefulWidget {
  final SharedPreferences pref;

  const ThemeSelectorWidget({super.key, required this.pref});

  @override
  State<ThemeSelectorWidget> createState() => _ThemeSelectorWidgetState();
}

class _ThemeSelectorWidgetState extends State<ThemeSelectorWidget> {
  late TextEditingController _inputController;
  late String theme;
  late String lightTheme;
  late String darkTheme;

  @override
  void initState() {
    theme = widget.pref.getString('theme') ?? 'system';
    darkTheme = widget.pref.getString('darkTheme') ?? 'dark';
    String themeName = theme == 'system'
        ? S.current.system
        : theme == 'light'
            ? S.current.light
            : S.current.dark;
    String darkName = darkTheme == 'dark' ? S.current.dark : S.current.night;

    _inputController = TextEditingController(text: "$themeName, $darkName");
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _openSelector() {
    showDialog(context: context, builder: _dialog);
  }

  void changeThemes(String systemStyle, String darkStyle) {
    setState(() {
      theme = systemStyle;
      darkTheme = darkStyle;
    });
    String themeName = systemStyle == 'system'
        ? S.current.system
        : theme == 'light'
            ? S.current.light
            : S.current.dark;
    String darkName = darkStyle == 'dark' ? S.current.dark : S.current.night;

    _inputController.text = "$themeName, $darkName";

    BlocProvider.of<SettingsBloc>(context)
        .add(ChangeTheme(systemStyle, 'light', darkStyle));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.current.themeSelector, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 10),
            _selector(),
          ],
        ),
      ),
    );
  }

  TextField _selector() {
    return TextField(
      controller: _inputController,
      readOnly: true,
      onTap: _openSelector,
      decoration: InputDecoration(
        label: Text(S.current.theme),
        suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
      ),
    );
  }

  StatefulBuilder _dialog(BuildContext context) {
    String generalTheme = theme;
    String darkStyle = darkTheme;

    return StatefulBuilder(builder: (localContext, localSetState) {
      void confirm() {
        changeThemes(generalTheme, darkStyle);
        Navigator.of(context).pop();
      }

      void changeGeneralTheme(String value) {
        localSetState(() {
          generalTheme = value;
        });
      }

      void changeDarkStyle(String value) {
        localSetState(() {
          darkStyle = value;
        });
      }

      return AlertDialog(
        title: Text(S.current.theme),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _subtitle(S.current.generalMode),
              _generalList(generalTheme, changeGeneralTheme),
              _subtitle(S.current.darkStyle),
              _listDarkStyle(darkStyle, changeDarkStyle),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(localContext).pop,
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

  Text _subtitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Column _generalList(String theme, void Function(String) changeValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <RadioListTile<String>>[
        RadioListTile(
          title: Row(
            children: [
              Icon(MdiIcons.themeLightDark),
              const SizedBox(width: 10),
              Text(S.current.system),
            ],
          ),
          value: 'system',
          groupValue: theme,
          onChanged: (String? value) => changeValue(value!),
        ),
        RadioListTile(
          title: Row(
            children: [
              const Icon(Icons.sunny),
              const SizedBox(width: 10),
              Text(S.current.light),
            ],
          ),
          value: 'light',
          groupValue: theme,
          onChanged: (String? value) => changeValue(value!),
        ),
        RadioListTile(
          title: Row(
            children: [
              Icon(MdiIcons.weatherNight),
              const SizedBox(width: 10),
              Text(S.current.dark),
            ],
          ),
          value: 'dark',
          groupValue: theme,
          onChanged: (String? value) => changeValue(value!),
        ),
      ],
    );
  }

  Column _listDarkStyle(String darkStyle, void Function(String) changeValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile(
          title: Row(
            children: [
              Icon(MdiIcons.lightbulbOff),
              const SizedBox(width: 10),
              Text(S.current.dark),
            ],
          ),
          value: 'dark',
          groupValue: darkStyle,
          onChanged: (String? value) => changeValue(value!),
        ),
        RadioListTile(
          title: Row(
            children: [
              Icon(MdiIcons.weatherNight),
              const SizedBox(width: 10),
              Text(S.current.night),
            ],
          ),
          value: 'night',
          groupValue: darkStyle,
          onChanged: (String? value) => changeValue(value!),
        ),
      ],
    );
  }
}
