import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/repositories/login_repository.dart';

class AuthRepositoryImp implements AuthRepositoy {
  final FirebaseAuth firebaseAuth;
  const AuthRepositoryImp({required this.firebaseAuth});
  @override
  Future<void> loginAnonymously() async {
    try {
      await firebaseAuth.signInAnonymously();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  String? uid() => firebaseAuth.currentUser?.uid;
}

final authRepository = Provider<AuthRepositoryImp>((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  return AuthRepositoryImp(firebaseAuth: firebaseAuth);
});
