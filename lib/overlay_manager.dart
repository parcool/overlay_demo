import 'package:flutter/widgets.dart';

Widget? smallWindowInApp;

OverlayEntry globalOverlayEntry = OverlayEntry(builder: (context) {
  if (smallWindowInApp != null) {
    return smallWindowInApp!;
  } else {
    return const SizedBox.shrink();
  }
});
