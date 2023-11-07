import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRouterGuard extends RouteGuard {
  HomeRouterGuard() : super(redirectTo: '/login/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    return SharedPreferences.getInstance().then((value) {
      final response = value.getString('session');
      return !(response == null || response.isEmpty);
    });
  }
}
