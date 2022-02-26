import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../firebase_auth.dart';

class LoginNotifier extends ChangeNotifier {
  final Ref ref;
  LoginNotifier(this.ref);
  bool isLoading = false;

  void setState() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> loginAnonymously() async {
    setState();
    try {
      await ref.read(authProvider).anonymousLogin();
      setState();
    } catch (e) {
      setState();
      rethrow;
    }
  }
}

final loginProvider = ChangeNotifierProvider((ref) => LoginNotifier(ref));
