import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/shared/app_button.dart';
import '../../domain/entities/weight.dart';
import '../logic/weight_provider.dart';

class AddAndUpdateDialog extends HookConsumerWidget {
  final bool isEdit;
  final Weight? weight;
  AddAndUpdateDialog({Key? key, this.isEdit = false, this.weight})
      : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(
        text: weight == null ? '' : weight!.userWeight.toString());
    return Dialog(
      child: Container(
        height: 210,
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
            Form(
              key: _formKey,
              child: TextFormField(
                style: AppTextStyles.bodyTextStyle,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppString.invalidFormText;
                  } else if (double.tryParse(value) == null) {
                    return AppString.invalidData;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: _outlineBorder(),
                  focusedBorder: _outlineBorder(),
                  hintText: AppString.weightHintText,
                  hintStyle: AppTextStyles.bodyTextStyle
                      .copyWith(color: Colors.grey.shade400),
                ),
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
                      onTap: () => _addOrUpdateWeight(
                          ref: ref, controller: controller, context: context)),
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

  void _addOrUpdateWeight(
      {required WidgetRef ref,
      required TextEditingController controller,
      required BuildContext context}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();
    try {
      !isEdit
          ? await ref.read(weightProvider).addWeight(Weight(
              userWeight: double.tryParse(controller.text) ?? 0,
              id: '',
              date: Timestamp.now()))
          : await ref.read(weightProvider).editWeight(weight!
              .copyWith(userWeight: double.tryParse(controller.text) ?? 0));
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
  }
}
