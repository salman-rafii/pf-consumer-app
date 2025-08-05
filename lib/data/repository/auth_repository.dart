import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pf_consumer_app/data/api/api_client.dart';
import 'package:pf_consumer_app/providers/providers.dart';

import '../model/response.dart';

final authRepoProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(apiClientProvider));
});

class AuthRepository {
  AuthRepository(this.api);

  ApiClient api;

  Future<Response> requestOtp(String phone) {
    return api.postData('/send-otp', {'mobile': phone, 'source': 'app'});
  }

  Future<Response> getMember(String phone) {
    return api.getData('/getMember/$phone');
  }

  Future<Response> register(Map<String, dynamic> payload) {
    return api.postData('/register', {
      ...payload,
      'source': 'APP',
      'code': 'PPS',
    });
  }

  Future<Response> login(String phone, String pin) {
    return api.postData('/login', {'mobile': phone, 'pin': pin});
  }

  Future<Response> logout() {
    return api.getData('/logout');
  }
}
