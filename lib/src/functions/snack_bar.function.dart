import "package:flutter/material.dart";
import "package:wallet_monitor/src/utils/icons.utils.dart";

enum Type { info, warning, error, success }

void showMessage({
  required BuildContext context,
  required Type type,
  required String message,
}) {
  final Color color = type == Type.info
      ? Colors.blue
      : type == Type.warning
          ? Colors.orange
          : type == Type.success
              ? Colors.green
              : Colors.red;

  final icon = type == Type.info
      ? "info"
      : type == Type.warning
          ? "warning"
          : type == Type.success
              ? "success"
              : "error";

  final snackBar = SnackBar(
    backgroundColor: color,
    duration: const Duration(seconds: 5),
    showCloseIcon: true,
    behavior: SnackBarBehavior.floating,
    content: Row(
      children: [
        Icon(getIcon(icon), color: Colors.white),
        const SizedBox(width: 10),
        Text(
          message,
          maxLines: 3,
          style: const TextStyle(
            color: Colors.white,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
