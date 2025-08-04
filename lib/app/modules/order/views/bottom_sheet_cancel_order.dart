import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCancelOrderDialogIOS({required VoidCallback onYes}) {
  showCupertinoDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return CupertinoTheme(
        data: const CupertinoThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          barBackgroundColor: Colors.white,
        ),
        child: CupertinoAlertDialog(
          title: const Text(
            "Cancel Order",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          content: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Are you really sure to\ncancel the order?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
          actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          isDefaultAction: true,
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: CupertinoColors.systemGrey, // Gray text
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
            onYes();
          },
          isDestructiveAction: false,
          child: const Text(
            "Yes",
            style: TextStyle(
              color: Colors.black, // Black text
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
          ],
        ),
      );
    },
  );
}
