import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/extensions/build_context_extensions.dart';
import '../../core/themes/app_theme.dart';
import '../../core/themes/spacing/spacing.dart';
import '../../core/themes/typography/typography_constants.dart';
import '../style_sheet/buttons/custom_button.dart';
import '../style_sheet/custom_alert.dart';
import '../style_sheet/custom_dialog.dart';
import '../style_sheet/inputs/custom_input_field.dart';
import '../style_sheet/inputs/input_label.dart';
import 'login_store.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final store = Modular.get<LoginStore>();
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController(text: 'leonardo.bido@bido.com');
  final passwordController = TextEditingController(text: 'Mudar.dev');
  bool isObscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.primary,
              AppTheme.secondary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(Spacing.sm.value),
            child: Observer(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: _loginForm),
                    Semantics(
                      button: true,
                      child: InkWell(
                        onTap: () async {
                          await launchUrl(
                            Uri.parse('https://www.google.com.br/'),
                          );
                        },
                        child: Text(
                          'Políticas de privacidade',
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.background,
                            fontWeight: AppFontWeight.bold.value,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget get _loginForm {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomInputField(
            labelWidget: const InputLabel(label: 'Usuário'),
            controller: emailController,
            hintText: 'Informe seu e-mail',
            prefixIcon: const Icon(Icons.person_rounded),
            validators: [
              (input) => !(input ?? '').trim().contains('@')
                  ? 'E-mail inválido'
                  : null,
            ],
          ),
          Spacing.md.vertical,
          CustomInputField(
            labelWidget: const InputLabel(label: 'Senha'),
            hintText: 'Informe sua senha',
            controller: passwordController,
            prefixIcon: const Icon(Icons.password_rounded),
            obscureText: isObscureText,
            validators: [
              (input) => (input ?? '').length < 8
                  ? 'Campo deve conter ao menos 8 caracteres'
                  : null,
            ],
            suffixIcon: Semantics(
              button: true,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                child: Icon(
                  isObscureText
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
              ),
            ),
          ),
          Spacing.md.vertical,
          CustomButton.text(
            text: 'Entrar',
            isLoading: store.isLoading,
            onPressed: () async {
              if (!(formKey.currentState?.validate() ?? false)) return;
              await store
                  .onLogin(
                email: emailController.text,
                password: passwordController.text,
              )
                  .then((value) {
                if (store.error != null) {
                  CustomDialog.show(
                    context,
                    CustomAlert(
                      title: 'Ocorreu um erro no Login',
                      btnConfirmLabel: 'Fechar',
                      subtitle: store.error?.toString() ?? '',
                      onConfirm: Navigator.of(context).pop,
                    ),
                    showClose: true,
                  );
                  return;
                }
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (route) => route.isFirst,
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
