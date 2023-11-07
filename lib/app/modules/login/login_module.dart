import 'package:flutter_modular/flutter_modular.dart';

import 'login_page.dart';
import 'login_store.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    i.add(LoginStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const LoginPage());
  }
}
