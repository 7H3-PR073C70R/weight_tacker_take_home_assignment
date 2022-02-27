import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker/feature/auth/login/view/login_view.dart';
import 'package:weight_tracker/feature/weight/weight_provider.dart';
import 'package:weight_tracker/feature/weight/view/widgets/add_and_update_dialog.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_string.dart';
import '../../../constants/app_text_styles.dart';
import '../model/weight.dart';
import 'widgets/logging_out.dart';
import 'widgets/no_data.dart';
import 'widgets/widget_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.appNameText,
          style: AppTextStyles.headerTextStyle,
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddAndUpdateDialog(),
                );
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                await ref.read(weightProvider).logOut();
                Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(builder: (_) => const LoginScreen()));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: StreamBuilder<QuerySnapshot>(
              stream: ref.watch(weightProvider).weightStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kcWhiteColor,
                    ),
                  );
                } else {
                  if (snapshot.data!.docs.isEmpty) {
                    return const NoDataFoundWidget();
                  }
                  return ListView.separated(
                      itemBuilder: ((context, index) {
                        final weight = Weight.fromJson(snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>);
                        return WeightCard(
                          weight: weight,
                        );
                      }),
                      separatorBuilder: (_, __) => const Divider(
                            thickness: 1,
                          ),
                      itemCount: snapshot.data!.docs.length);
                }
              },
            ),
          ),
          if(ref.watch(weightProvider).isBusy) 
          const LoggingOutWidget(), 
        ],
      ),
    );
  }
}