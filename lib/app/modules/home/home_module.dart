import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';
import 'home_router_guard.dart';
import 'home_store.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(HomeStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const HomePage(),
      guards: [HomeRouterGuard()],
    );
  }
}
