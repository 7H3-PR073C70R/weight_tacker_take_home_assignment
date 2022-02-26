import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../shared/dummie_widgets/app_button.dart';
import '../../model/weight.dart';
import '../../controller.dart';

class AddAndUpdateDialog extends HookConsumerWidget {
  final bool isEdit;
  final Weight? weight;
  const AddAndUpdateDialog({Key? key, this.isEdit = false, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(
        text: weight == null
            ? AppString.weightHintText
            : weight!.userWeight.toString());
    return Dialog(
      child: Container(
        height: 200,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              !isEdit ? AppString.addWeightText : AppString.editWeightText,
              style: AppTextStyles.headerTextStyle,
            ),
            const Divider(
              thickness: 5,
            ),
            const Spacer(),
            TextFormField(
              style: AppTextStyles.bodyTextStyle,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: controller,
              decoration: InputDecoration(
                border: _outlineBorder(),
                focusedBorder: _outlineBorder(),
                hintText: AppString.weightHintText,
                hintStyle: AppTextStyles.bodyTextStyle
                    .copyWith(color: Colors.grey.shade400),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                      isLoading: ref.watch(weightProvider).isBusy,
                      text: !isEdit
                          ? AppString.addButtonText
                          : AppString.editWeightText,
                      onTap: () async {
                        try {
                          !isEdit
                              ? await ref.read(weightProvider).addWeight(Weight(
                                  userWeight: double.tryParse(controller.text) ?? 0,
                                  id: '',
                                  date: Timestamp.now()))
                              : await ref.read(weightProvider).editWeight(weight!
                                  .copyWith(
                                      userWeight:
                                          double.tryParse(controller.text) ?? 0));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: AppColors.kcErrorColor,
                              content: Text(
                                AppString.errorText,
                                style: AppTextStyles.bodyTextStyle,
                              ),
                            ),
                          );
                        }
                        Navigator.of(context).pop();
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  OutlineInputBorder _outlineBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.kcWhiteColor));
  }
}
