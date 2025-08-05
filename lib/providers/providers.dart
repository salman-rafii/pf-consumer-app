import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pf_consumer_app/data/api/api_client.dart';
import 'package:pf_consumer_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
// api client provider
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    appBaseUrl: AppConstants.baseUrl,
    sharedPreferences: ref.watch(sharedPreferenceProvider),
    ref: ref,
  );
});
