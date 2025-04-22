import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';

extension ImageTool on ImageProvider {
  Future<Uint8List?> getBytes(BuildContext context, {ImageByteFormat format = ImageByteFormat.rawRgba}) async {
    final imageStream = resolve(createLocalImageConfiguration(context));
    final Completer<Uint8List?> completer = Completer<Uint8List?>();
    final ImageStreamListener listener = ImageStreamListener(
      (imageInfo, synchronousCall) async {
        final bytes = await imageInfo.image.toByteData(format: format);
        if (!completer.isCompleted) {
          completer.complete(bytes?.buffer.asUint8List());
        }
      },
    );
    imageStream.addListener(listener);
    final imageBytes = await completer.future;
    imageStream.removeListener(listener);
    return imageBytes;
  }
}


String formatNumberWithCommas(double number) {
  String formattedString = number.toStringAsFixed(0);
  return formattedString.replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]},',
  );
}

double sizedH(BuildContext context) => MediaQuery.sizeOf(context).height;
double sizedW(BuildContext context) => MediaQuery.sizeOf(context).width;

enum Category {
  hotels,
  clubs,
  realEstate,
  gym,
}