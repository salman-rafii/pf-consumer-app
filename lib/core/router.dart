import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pf_consumer_app/views/root.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return PPTRouter(ref).router;
});

class PPTRouter {
  final Ref ref;
  PPTRouter(this.ref);
  static const String root = '/';
  static const String signUp = '/signUp';
  static const String login = '/login';
  static const String pin = 'pin';
  static const String changePin = 'change_pin';
  static const String dashboard = '/dashboard';

  ///
  static const String webview = '/webview';
  static const String signedMembers = 'signedMembers';

  GoRouter get router => GoRouter(
    debugLogDiagnostics: true,
    initialLocation: root,
    routes: [GoRoute(path: root, builder: (context, state) => const Root())],
  );
}
