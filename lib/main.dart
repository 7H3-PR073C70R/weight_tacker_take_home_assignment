import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker/feature/auth/firebase_auth.dart';
import 'package:weight_tracker/feature/weight/view/weight_view.dart';
import 'feature/auth/login/view/login_view.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Very Important to do (Reason below)
  await Firebase.initializeApp(); // this connects our app with Firebase
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Weight Tracker',
      theme: ThemeData.dark(),
      home: ref.read(authProvider).userID == null
          ? const LoginScreen()
          : const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
