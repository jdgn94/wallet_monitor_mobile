import 'package:flutter/material.dart';

enum ButtonType { tonal, outline, text, color, selector }

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
          if (icon != null && personalIcon == null) Icon(icon, size: size),
          if ((icon != null || personalIcon != null) && text != null)
            const SizedBox(width: 10.0),
          if (text != null)
            Expanded(
              child: Text(
                text!,
                style: TextStyle(
                  fontSize: size,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          if ((rightIcon != null && text != null)) const SizedBox(width: 10.0),
          if (rightIcon != null) Icon(rightIcon, size: size),
        ],
      ),
    );
  }
}
