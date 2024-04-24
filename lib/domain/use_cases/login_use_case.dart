import 'package:flutter_clean_architecture/domain/models/exceptions/app_exception.dart';
import 'package:flutter_clean_architecture/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture/domain/utils/either.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Either<void, AppException>> execute(
      String username, String password) async {
    try {
      await _authRepository.login(username, password);
      return const Left(null);
    } on AppException catch (e) {
      return Right(e);
    }
  }
}
