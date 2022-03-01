import 'package:flutter/material.dart';

import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/app_text_styles.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade800),
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          AppString.noDataText,
          style: AppTextStyles.buttonTextStyle,
        ),
      ),
    );
  }
}
