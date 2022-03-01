abstract class AuthRepositoy {
  String? uid();
  Future<void> loginAnonymously();
  Future<void> logout();
}
