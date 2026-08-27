
import 'package:tech_store/core/service/ApiService.dart';

class RegisterRepo {
  final ApiService apiService;

  RegisterRepo(this.apiService);

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    await apiService.register(
      email: email.trim(),
      password: password,
      firstName: firstName.trim(),
      lastName: lastName.trim(),
    );
  }
}

