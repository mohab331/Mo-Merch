import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_clean_architecture/core/app_assets/index.dart';
class AppFunctions {
  static Future<bool?> showToast(
      {required String message, required Color color,}) async {
    return await Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      backgroundColor: color,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static Future<bool?> showCupertinoAlertDialog(BuildContext context,
      {required Widget content,
      required String title,
      bool showActions = true}) async {
    return await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: content,
        actions: showActions
            ? [
                CupertinoButton(
                    child: Text(R.strings.actionOk),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ]
            : [],
      ),
    );
  }


}
