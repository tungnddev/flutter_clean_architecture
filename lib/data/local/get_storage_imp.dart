import 'package:get_storage/get_storage.dart';
import 'package:flutter_clean_architecture/data/local/local_service.dart';

class GetStorageImp extends LocalService {
  @override
  String? get accessToken => GetStorage(prefBox).read(keyAccessToken);

  @override
  Future<void> initialize() {
    return GetStorage.init(prefBox);
  }

  @override
  Future<void> saveAccessToken(String accessToken) {
    return GetStorage(prefBox).write(keyAccessToken, accessToken);
  }

  @override
  String? get refreshToken => GetStorage(prefBox).read(keyRefreshToken);

  @override
  Future<void> saveRefreshToken(String refreshToken) {
    return GetStorage(prefBox).write(keyRefreshToken, refreshToken);
  }
}
