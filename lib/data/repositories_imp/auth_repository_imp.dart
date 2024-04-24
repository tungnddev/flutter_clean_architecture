import 'package:flutter_clean_architecture/data/models/auth/auth.dart';
import 'package:flutter_clean_architecture/data/repositories_imp/exception_mapper.dart';
import 'package:flutter_clean_architecture/domain/repositories/auth_repository.dart';

import '../local/local_service.dart';
import '../remote/client/auth_client.dart';

class AuthRepositoryImp extends AuthRepository with ExceptionMapper {
  LocalService localService;
  AuthClient authClient;

  AuthRepositoryImp(this.localService, this.authClient);

  @override
  String? get cacheAccessToken => localService.accessToken;

  @override
  String? get cacheRefreshToken => localService.refreshToken;

  @override
  Future<void> saveCacheAccessToken(String accessToken) =>
      localService.saveAccessToken(accessToken);

  @override
  Future<void> saveCacheRefreshToken(String refreshToken) =>
      localService.saveRefreshToken(refreshToken);

  @override
  Future<String?> refreshToken() async {
    final refreshToken = localService.refreshToken;
    if (refreshToken == null) return null;
    final newToken = await authClient.refreshToken(refreshToken);
    if (newToken.data != null) {
      await saveCacheAccessToken(newToken.data!);
    }
    return newToken.data;
  }

  @override
  Future<void> login(String username, String password) async {
    try {
      final response =
          await authClient.login(LoginRequestModel(username, password));
      if (response.data != null) {
        await saveCacheAccessToken(response.data!.accessToken);
        await saveCacheRefreshToken(response.data!.refreshToken);
      }
    } catch (e) {
      throw mapException(e);
    }
  }
}
