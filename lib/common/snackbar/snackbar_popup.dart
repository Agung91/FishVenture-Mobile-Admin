import 'package:admin/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

void snacBarPopUp(
  BuildContext context, {
  required String text,
  required Color color,
  required IconData icon,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1200),
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
                text,
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
