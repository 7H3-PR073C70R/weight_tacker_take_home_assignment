import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker/feature/auth/firebase_auth.dart';
import 'package:weight_tracker/feature/auth/login/view/login_view.dart';
import 'package:weight_tracker/feature/weight/use_cases.dart/add_and_update_weight/add_and_update_dialog.dart';
import '../../../constants/app_string.dart';
import '../../../constants/app_text_styles.dart';
import '../../../repositoy/weight_repository.dart';
import '../model/weight.dart';
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
                  builder: (context) => const AddAndUpdateDialog(),
                );
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                ref.read(authProvider).logout();
                Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(builder: (_) => const LoginScreen()));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: ref.watch(weightRepositoryProvider).weightStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data!.docs.isEmpty) {
                return const _NoDataFoundWidget();
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
    );
  }
}

class _NoDataFoundWidget extends StatelessWidget {
  const _NoDataFoundWidget({
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
