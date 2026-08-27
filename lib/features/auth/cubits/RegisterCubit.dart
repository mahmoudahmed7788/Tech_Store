import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_store/core/service/auth_service.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    AuthService? authService,
  })  : _authService = authService ?? AuthService(),
        super(RegisterInitial());

  final AuthService _authService;

  // =========================================================
  // REGISTER
  // =========================================================

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(RegisterLoading());

    try {
      print('========================================');
      print('REGISTER START');
      print('EMAIL: ${email.trim()}');
      print('========================================');

      // =====================================================
      // CREATE USER
      // =====================================================

      final credential = await _authService.register(
        email: email,
        password: password,
      );

      final user = credential.user;

      print('USER CREATED: ${user?.uid}');

      if (user != null) {
        // ===================================================
        // SAVE USER NAME
        // ===================================================

        await _authService.updateDisplayName(
          user: user,
          firstName: firstName,
          lastName: lastName,
        );

        print('DISPLAY NAME UPDATED');

        // ===================================================
        // SEND VERIFICATION EMAIL
        // ===================================================

        await _authService.sendEmailVerification(user);

        print('VERIFICATION EMAIL SENT');
      }

      print('REGISTER SUCCESS');
      print('========================================');

      emit(RegisterSuccess());
    }

    // =========================================================
    // FIREBASE ERROR
    // =========================================================

    on FirebaseAuthException catch (e) {
      print('========================================');
      print('FIREBASE REGISTER ERROR');
      print('CODE: ${e.code}');
      print('MESSAGE: ${e.message}');
      print('========================================');

      emit(
        RegisterFailure(
          _getErrorMessage(e.code),
        ),
      );
    }

    // =========================================================
    // UNKNOWN ERROR
    // =========================================================

    catch (e) {
      print('========================================');
      print('REGISTER UNKNOWN ERROR');
      print(e);
      print('========================================');

      emit(
        RegisterFailure(
          e.toString(),
        ),
      );
    }
  }

  // =========================================================
  // CHECK EMAIL VERIFIED
  // =========================================================

  Future<bool> checkEmailVerified() async {
    try {
      return await _authService.checkEmailVerified();
    } catch (e) {
      print('VERIFY CHECK ERROR: $e');
      return false;
    }
  }

  // =========================================================
  // FIREBASE ERROR MESSAGES
  // =========================================================

  String _getErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'Password is too weak.';

      case 'email-already-in-use':
        return 'This email is already registered.';

      case 'invalid-email':
        return 'Please enter a valid email.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'operation-not-allowed':
        return 'Email & Password authentication is not enabled in Firebase.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'user-disabled':
        return 'This account has been disabled.';

      default:
        return 'Firebase Error: $code';
    }
  }
}

// =========================================================
// STATES
// =========================================================

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure(this.message);
}