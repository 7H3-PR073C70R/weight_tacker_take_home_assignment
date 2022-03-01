import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker/src/features/home/presentation/pages/home.dart';
import 'src/features/login/data/repositories/login_repository_impl.dart';
import 'src/features/login/presentation/pages/login_page.dart';

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
      home: ref.read(authRepository).uid == null
          ? const LoginPage()
          : const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
