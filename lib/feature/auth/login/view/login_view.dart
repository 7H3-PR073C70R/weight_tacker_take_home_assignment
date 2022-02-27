import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker/constants/app_colors.dart';
import 'package:weight_tracker/feature/auth/login/login_state.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../shared/dummie_widgets/app_button.dart';
import '../../../weight/view/weight_view.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 38),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppString.appStatementText,
                  style: AppTextStyles.bodyTextStyle,
                ),
                AppSpacing.verticalSpaceMedium,
                AppButton(
                    text: AppString.anonymousLoginText,
                    isLoading: ref.watch(loginProvider).isLoading,
                    onTap: () async {
                      try {
                        await ref.read(loginProvider).loginAnonymously();
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                                builder: (_) => const HomeScreen()));
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: AppColors.kcErrorColor,
                          content: Text(
                            AppString.errorText,
                            style: AppTextStyles.bodyTextStyle,
                          ),
                        ));
                      }
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
