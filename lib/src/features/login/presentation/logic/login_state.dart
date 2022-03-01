import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repositories/login_repository_impl.dart';

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
      await ref.read(authRepository).loginAnonymously();
      setState();
    } catch (e) {
      setState();
      rethrow;
    }
  }
}

final loginProvider = ChangeNotifierProvider((ref) => LoginNotifier(ref));
