import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:weight_tracker/src/features/home/presentation/pages/home.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/shared/app_button.dart';
import '../logic/login_state.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                                builder: (_) => const HomePage()));
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
