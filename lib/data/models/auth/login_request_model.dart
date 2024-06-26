import 'package:json_annotation/json_annotation.dart';
part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel {
  String username;
  String password;
  LoginRequestModel(this.username, this.password);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}