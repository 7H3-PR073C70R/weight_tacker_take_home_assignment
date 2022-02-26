import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthenticationService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  String? get userID => _firebaseAuth.currentUser?.uid;

  Future<User?> anonymousLogin() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return authResult.user;
  }
}

final authProvider = Provider<AuthenticationService>(
    (_) => AuthenticationService());
