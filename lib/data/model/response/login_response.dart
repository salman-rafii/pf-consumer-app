import 'dart:convert';

class LoginResponse {
  bool? success;
  String? accessToken;
  String? message;

  LoginResponse({this.success, this.accessToken, this.message});

  factory LoginResponse.fromMap(Map<String, dynamic> data) => LoginResponse(
    success: data['success'] as bool?,
    accessToken: data['access_token'] as String?,
    message: data['message'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'success': success,
    'access_token': accessToken,
    'message': message,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginResponse].
  factory LoginResponse.fromJson(String data) {
    return LoginResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
