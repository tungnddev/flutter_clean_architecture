import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:flutter_clean_architecture/data/models/auth/auth.dart';

import '../../models/models.dart';
part 'auth_client.g.dart';

@RestApi()
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @POST('/refresh_token')
  Future<BaseResponse<String>> refreshToken(@Field("refreshToken") String refreshToken);

  @POST('/login')
  Future<BaseResponse<LoginModel>> login(@Body() LoginRequestModel model);
}