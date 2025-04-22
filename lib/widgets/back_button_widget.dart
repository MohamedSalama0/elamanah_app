import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Transform.rotate(
        angle: math.pi,
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 24.h,
        ),
      ),
    );
  }
}
