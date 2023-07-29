import 'package:flutter/material.dart';

class SettingsSecondPage extends StatefulWidget {
  const SettingsSecondPage({Key? key}) : super(key: key);

  @override
  State<SettingsSecondPage> createState() => _SettingsSecondPageState();
}

class _SettingsSecondPageState extends State<SettingsSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                logo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return Container();
  }
}
