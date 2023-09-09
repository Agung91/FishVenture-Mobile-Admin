import 'package:admin/config/text_style.dart';
import 'package:admin/core/context.dart';
import 'package:flutter/material.dart';

void snacBarPopUp({
  required String message,
  required Color color,
  required IconData icon,
  int? duration,
}) {
  snackbarKey.currentState?.removeCurrentSnackBar();
  snackbarKey.currentState?.showSnackBar(SnackBar(
      duration: Duration(milliseconds: duration ?? 1200),
      // duration: const Duration(milliseconds: 10000000),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Container(
        // height: 74.0,

        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),

        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                message,
                style:
                    CustomTextStyle.body1Medium.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              icon,
              color: Colors.white,
              size: 20.0,
            )
          ],
        ),
      )));
}
