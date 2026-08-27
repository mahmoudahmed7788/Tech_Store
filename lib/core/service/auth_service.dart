import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService({
    FirebaseAuth? firebaseAuth,
  }) : _auth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  // =========================================================
  // REGISTER
  // =========================================================

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  // =========================================================
  // LOGIN
  // =========================================================

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  // =========================================================
  // UPDATE USER NAME
  // =========================================================

  Future<void> updateDisplayName({
    required User user,
    required String firstName,
    required String lastName,
  }) async {
    await user.updateDisplayName(
      '$firstName $lastName',
    );
  }

  // =========================================================
  // SEND EMAIL VERIFICATION
  // =========================================================

  Future<void> sendEmailVerification(User user) async {
    await user.sendEmailVerification();
  }

  // =========================================================
  // CHECK EMAIL VERIFIED
  // =========================================================

  Future<bool> checkEmailVerified() async {
    final user = _auth.currentUser;

    if (user == null) {
      return false;
    }

    await user.reload();

    final updatedUser = _auth.currentUser;

    return updatedUser?.emailVerified ?? false;
  }

  // =========================================================
  // CURRENT USER
  // =========================================================

  User? get currentUser => _auth.currentUser;

  // =========================================================
  // LOGOUT
  // =========================================================

  Future<void> logout() async {
    await _auth.signOut();
  }
}