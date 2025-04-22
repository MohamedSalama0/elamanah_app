import 'package:farm_project/core/resources/color_manager.dart';
import 'package:farm_project/core/resources/styles_manager.dart';
import 'package:farm_project/core/utils/custom_extension_and_checkers.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static void showMySnackbar(BuildContext context, String message,
      {bool warning = false, int duration = 1500}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: warning ? kRed.withValues(alpha: 0.6) : kDarkBlue,
        // const Color.fromARGB(207, 255, 123, 113),
        margin: EdgeInsets.only(
          bottom: sizedH(context) * 0.10,
          left: sizedW(context) * 0.06,
          right: sizedW(context) * 0.06,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: sizedW(context) * 0.12,
          vertical: sizedH(context) * 0.02,
        ),
        content: Text(
          message.isEmpty ? 'حدث خطأ ما' : message,
          textAlign: TextAlign.center,
          style: getRegularStyle(color: kWhite),
        ),
        duration: Duration(milliseconds: duration),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }
}
