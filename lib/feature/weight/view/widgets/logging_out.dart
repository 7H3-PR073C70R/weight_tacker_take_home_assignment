import 'package:flutter/material.dart';
import 'package:weight_tracker/constants/app_colors.dart';
import 'package:weight_tracker/constants/app_spacing.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_styles.dart';

class LoggingOutWidget extends StatelessWidget {
  const LoggingOutWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
      height: 100,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.kcButtonBackgroundColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(AppString.loggingOutText, style: AppTextStyles.headerTextStyle,),
          AppSpacing.horizontalSpaceMedium,
           CircularProgressIndicator(
             color: AppColors.kcWhiteColor,
           ),
        ],
      ),
      ),
    );
  }
}