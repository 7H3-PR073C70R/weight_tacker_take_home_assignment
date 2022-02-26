import 'package:flutter/material.dart';
import 'package:weight_tracker/constants/app_colors.dart';
import 'package:weight_tracker/constants/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  const AppButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white,
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.kcButtonBackgroundColor,
        ),
        child: !isLoading
            ? Text(text, style: AppTextStyles.buttonTextStyle)
            : const CircularProgressIndicator(color: AppColors.kcWhiteColor,),
      ),
    );
  }
}
