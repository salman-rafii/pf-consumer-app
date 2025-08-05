import 'dart:convert';

class RegisterResponse {
  int? statusCode;
  String? statusMessage;
  dynamic accountno;
  String? schemenumber;
  String? membernumber;
  int? balance;
  int? contribution;
  int? retirement;
  int? savings;

  RegisterResponse({
    this.statusCode,
    this.statusMessage,
    this.accountno,
    this.schemenumber,
    this.membernumber,
    this.balance,
    this.contribution,
    this.retirement,
    this.savings,
  });

  factory RegisterResponse.fromMap(Map<String, dynamic> data) {
    return RegisterResponse(
      statusCode: data['status_code'] as int?,
      statusMessage: data['status_message'] as String?,
      accountno: data['accountno'] as dynamic,
      schemenumber: data['schemenumber'] as String?,
      membernumber: data['membernumber'] as String?,
      balance: data['balance'] as int?,
      contribution: data['contribution'] as int?,
      retirement: data['retirement'] as int?,
      savings: data['savings'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
    'status_code': statusCode,
    'status_message': statusMessage,
    'accountno': accountno,
    'schemenumber': schemenumber,
    'membernumber': membernumber,
    'balance': balance,
    'contribution': contribution,
    'retirement': retirement,
    'savings': savings,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RegisterResponse].
  factory RegisterResponse.fromJson(String data) {
    return RegisterResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RegisterResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
