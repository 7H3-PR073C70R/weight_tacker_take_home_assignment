import 'package:flutter/material.dart';

class AppSpacing {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
      
  static const _mediumSpacing = 8.0;
  static const _smallSpacing = _mediumSpacing * 0.5;

  // vertical spacing
  static const verticalSpaceSmall = SizedBox(height: _smallSpacing);
  static const verticalSpaceMedium = SizedBox(height: _mediumSpacing);

  // horizontal spacing
  static const horizontalSpaceSmall = SizedBox(width: _smallSpacing);
  static const horizontalSpaceMedium = SizedBox(width: _mediumSpacing);
}
