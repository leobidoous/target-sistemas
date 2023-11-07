import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/load_mock.dart';
import 'infra/models/user_model.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  @observable
  bool isLoading = false;
  @observable
  Exception? error;

  @action
  Future<void> onLogin() async {
    isLoading = true;
    await LoadMock.fromAsset('login.json').then((value) {
      value.fold((left) {
        error = left;
      }, (right) async {
        await SharedPreferences.getInstance().then((value) async {
          try {
            final saved = await value.setString(
              'session',
              UserModel.fromMap(right).toJson(),
            );
            if (saved) {
            } else {
              error = Exception('Não foi possível salvar a sessão do usuário');
            }
          } catch (e) {
            error = Exception(e);
          }
        });
        isLoading = false;
      });
    }).whenComplete(() => isLoading = false);
  }
}
