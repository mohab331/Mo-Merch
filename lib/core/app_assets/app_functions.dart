import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_clean_architecture/core/app_assets/index.dart';

class AppFunctions {
  /// Displays a toast message with the given [message] and background [color].
  /// Returns a [Future] that completes with a boolean value representing
  /// whether the toast was shown successfully or not.
  Future<bool?> showToast({
    required String message,
    required Color color,
  }) async {
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

  /// Shows a Cupertino-style alert dialog with the given [content], [title],
  /// and optional [showActions] flag to control the presence of actions.
  /// Returns a [Future] that completes with a boolean value representing
  /// whether the dialog was shown successfully or not.
  Future<bool?> showCupertinoAlertDialog(
    BuildContext context, {
    required Widget content,
    required String title,
    bool showNoAction = true,
  }) async {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: content,
        actions:  [
                CupertinoButton(
                  child: Text(R.strings.actionOk),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                if(showNoAction)
                CupertinoButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ]
            ,
      ),
    );
  }
}
