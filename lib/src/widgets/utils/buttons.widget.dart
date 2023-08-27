import 'package:flutter/material.dart';
import 'package:wallet_monitor/src/db/models/category.model.dart';
import 'package:wallet_monitor/src/db/models/currency.model.dart';
import 'package:wallet_monitor/src/functions/currency.function.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';

enum ButtonType { tonal, outline, text, color, selector, category }

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ButtonType type;
  final Color? color;
  final Color? backgroundColor;
  final Color? overlayColor;
  final double? width;
  final double? height;
  final IconData? icon;
  final IconData? rightIcon;
  final String? personalIcon;
  final String? text;
  final double size;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final MainAxisAlignment? alignment;
  final String message;
  final bool disabled;
  final bool loading;
  final bool selected;
  final Color? borderColor;
  final Color? textColor;
  final double? iconSize;
  final Category? category;
  final Currency? currency;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.type = ButtonType.tonal,
    this.color,
    this.backgroundColor,
    this.overlayColor,
    this.width,
    this.height,
    this.icon,
    this.rightIcon,
    this.personalIcon,
    this.text,
    this.size = 17,
    this.padding,
    this.margin,
    this.alignment,
    this.message = "",
    this.disabled = false,
    this.loading = false,
    this.selected = false,
    this.borderColor,
    this.textColor,
    this.iconSize,
    this.category,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Container(
        margin: margin,
        child: _buttonStyle(context),
      ),
    );
  }

  Widget _buttonStyle(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final colorDisabled =
        color != null ? color!.withOpacity(0.5) : primaryColor.withOpacity(0.5);

    if (type == ButtonType.outline) {
      return OutlinedButton(
        onPressed: disabled ? null : onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(
            disabled ? colorDisabled : textColor ?? color ?? primaryColor,
          ),
          overlayColor: MaterialStatePropertyAll(
            (disabled ? colorDisabled : color ?? primaryColor).withAlpha(50),
          ),
          backgroundColor: MaterialStatePropertyAll(backgroundColor),
          side: MaterialStatePropertyAll(
            BorderSide(
              color: disabled
                  ? colorDisabled
                  : borderColor ?? color ?? primaryColor,
              width: 2,
            ),
          ),
        ),
        child: _buttonContainer(context),
      );
    }

    if (type == ButtonType.text) {
      return TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(disabled
              ? colorDisabled
              : disabled
                  ? colorDisabled
                  : color ?? primaryColor),
          overlayColor: MaterialStatePropertyAll(
              (disabled ? colorDisabled : color ?? primaryColor).withAlpha(50)),
          backgroundColor: MaterialStatePropertyAll(backgroundColor),
        ),
        onPressed: disabled ? null : onPressed,
        child: _buttonContainer(context),
      );
    }

    if (type == ButtonType.selector) {
      return InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10.0),
        child: Ink(
          width: MediaQuery.of(context).size.width / 2 - 70,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Icon(icon),
              const SizedBox(height: 10.0),
              Text(text ?? ""),
            ],
          ),
        ),
      );
    }

    if (type == ButtonType.color) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: (color ?? Colors.grey).withAlpha(selected ? 90 : 30),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Ink(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (color ?? Colors.grey).withAlpha(70),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: color ?? Colors.grey,
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Text(
                    text ?? "",
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (type == ButtonType.category) {
      final categoryColor = Color(int.parse("0x${category!.color}"));

      return Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width / 2 - 15,
          constraints: const BoxConstraints(
            maxWidth: 300,
          ),
          child: InkWell(
            onTap: disabled ? null : onPressed,
            borderRadius: BorderRadius.circular(10.0),
            focusColor: categoryColor.withAlpha(30),
            hoverColor: categoryColor.withAlpha(30),
            splashColor: categoryColor.withAlpha(30),
            highlightColor: categoryColor.withAlpha(30),
            child: Ink(
              decoration: BoxDecoration(
                color: categoryColor.withAlpha(50),
                borderRadius: BorderRadius.circular(10.0),
                // border: Border.all(width: 1.5, color: categoryColor),
              ),
              height: 50.0,
              child: Row(
                children: [
                  Ink(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: categoryColor.withAlpha(50),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                    child: Icon(getIcon(category!.icon), color: categoryColor),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          category!.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        CurrencyFunctions.formatNumber(
                          symbol: currency!.symbol,
                          decimalDigits: currency!.decimalDigits,
                          amount: category!.maxAmount,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
            disabled ? colorDisabled : color ?? primaryColor),
        foregroundColor: MaterialStatePropertyAll(overlayColor ?? Colors.white),
        overlayColor: MaterialStatePropertyAll(
          overlayColor != null ? overlayColor!.withAlpha(25) : Colors.white10,
        ),
      ),
      child: _buttonContainer(context),
    );
  }

  Widget _buttonContainer(BuildContext context) {
    if (loading) {
      return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: type == ButtonType.tonal ? Colors.white : color,
        ),
      );
    }
    return Container(
      padding: padding,
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: alignment ?? MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null && personalIcon == null)
            Icon(icon, size: iconSize ?? size),
          if ((icon != null || personalIcon != null) && text != null)
            const SizedBox(width: 3),
          if (text != null)
            Expanded(
              child: Text(
                text!,
                style: TextStyle(
                  fontSize: size,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          if ((rightIcon != null && text != null)) const SizedBox(width: 3),
          if (rightIcon != null) Icon(rightIcon, size: iconSize ?? size),
        ],
      ),
    );
  }
}
