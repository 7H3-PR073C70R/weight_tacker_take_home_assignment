import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';

import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/app_text_styles.dart';

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