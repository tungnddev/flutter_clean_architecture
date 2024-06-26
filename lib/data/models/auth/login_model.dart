import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  String accessToken;
  String refreshToken;

  LoginModel(this.accessToken, this.refreshToken);

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);
}