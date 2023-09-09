import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';

class IconWidget extends StatelessWidget {
  final String iconName;
  final double? size;
  final Color? color;

  const IconWidget({
    super.key,
    required this.iconName,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (iconName[0] == "_") {
      return SvgPicture.asset(
        "lib/src/assets/icons/${iconName.substring(1)}.svg",
        height: size ?? 20,
        colorFilter: ColorFilter.mode(
          color ?? Theme.of(context).colorScheme.onBackground,
          BlendMode.srcIn,
        ),
      );
    }

    return Icon(
      getIcon(iconName),
      size: size ?? 20,
      color: color ?? Theme.of(context).colorScheme.onBackground,
    );
  }
}
