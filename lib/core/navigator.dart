// ignore_for_file: implementation_imports

import 'package:go_router/src/router.dart';

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
