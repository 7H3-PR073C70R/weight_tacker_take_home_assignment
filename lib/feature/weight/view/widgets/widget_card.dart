import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/feature/weight/view/widgets/add_and_update_dialog.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_text_styles.dart';
import '../../model/weight.dart';
import 'delete_confimation_dialog.dart';

class WeightCard extends StatelessWidget {
  final Weight weight;
  const WeightCard({
    Key? key,
    required this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.kcButtonBackgroundColor),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: AppSpacing.screenWidth(context) * 0.5,
            child: Text(
              'You weight as of ${DateFormat('MMM dd, yyyy').format(weight.date.toDate())} is ${weight.userWeight.toStringAsFixed(2)}kg',
              style: AppTextStyles.bodyTextStyle,
              maxLines: 2,
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AddAndUpdateDialog(
                          isEdit: true,
                          weight: weight,
                        ));
              },
              icon: const Icon(Icons.edit)),
          AppSpacing.horizontalSpaceSmall,
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) =>
                        ConfirmationAlertDialog(weightId: weight.id));
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
    );
  }
}
