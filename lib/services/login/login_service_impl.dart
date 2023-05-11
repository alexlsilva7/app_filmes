import 'package:app_filmes/repositories/login/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './login_service.dart';

class LoginServiceImpl implements LoginService {
  final LoginRepository _repository;

  LoginServiceImpl({required LoginRepository repository})
      : _repository = repository;

  @override
  Future<UserCredential> login() => _repository.login();

  @override
  Future<void> logout() => _repository.logout();
}
