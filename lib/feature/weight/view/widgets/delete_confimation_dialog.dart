import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../shared/dummie_widgets/app_button.dart';
import '../../weight_provider.dart';

class ConfirmationAlertDialog extends ConsumerWidget {
  const ConfirmationAlertDialog({
    Key? key,
    required this.weightId,
  }) : super(key: key);

  final String weightId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      content: RichText(
        text: TextSpan(
            text: AppString.areYouSureText,
            style: AppTextStyles.bodyTextStyle,
            children: [
              TextSpan(
                  text: AppString.deleteWarning,
                  style: AppTextStyles.headerTextStyle
                      .copyWith(color: AppColors.kcErrorColor))
            ]),
      ),
      actions: [
        InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              AppString.cancelText,
              style: AppTextStyles.bodyTextStyle,
            )),
        AppSpacing.horizontalSpaceMedium,
        SizedBox(
            width: 150,
            child: AppButton(
                text: AppString.deleteButtonText,
                onTap: () {
                  ref.read(weightProvider).deleteWeight(weightId);
                  Navigator.of(context).pop();
                })),
      ],
    );
  }
}
