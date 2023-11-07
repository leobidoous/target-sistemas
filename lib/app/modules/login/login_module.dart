import 'package:flutter_modular/flutter_modular.dart';
import '../../core/load_mock.dart';
import 'login_page.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    i.add(LoadMock.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const LoginPage());
  }
}
