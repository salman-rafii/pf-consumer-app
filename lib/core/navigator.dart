// ignore_for_file: implementation_imports

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/src/router.dart';
import 'package:pf_consumer_app/core/router.dart';

final navigationProviderProvider = Provider<PPTNavigator>((ref) {
  return PPTNavigator(ref.watch(routerProvider));
});

class PPTNavigator {
  PPTNavigator(this.router);
  GoRouter router;

  void push(String name) {
    router.push(router.namedLocation(name));
  }

  void go(String name) {
    router.pushNamed(router.namedLocation(name));
  }
}
