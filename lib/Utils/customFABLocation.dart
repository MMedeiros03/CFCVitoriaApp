import 'package:flutter/material.dart';

class CustomFABLocation extends FloatingActionButtonLocation {
  final double xOffset;
  final double yOffset;

  CustomFABLocation({this.xOffset = 0, this.yOffset = 0});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = scaffoldGeometry.scaffoldSize.width -
        scaffoldGeometry.floatingActionButtonSize.width -
        16 +
        xOffset;
    final double fabY = scaffoldGeometry.scaffoldSize.height -
        scaffoldGeometry.floatingActionButtonSize.height -
        16 +
        yOffset;

    return Offset(fabX, fabY);
  }
}
