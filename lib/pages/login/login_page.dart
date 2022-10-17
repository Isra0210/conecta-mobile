import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/get_snack_bar.dart';
import 'components/button_component.dart';
import 'components/login_as_component.dart';
import 'components/text_form_field_component.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ILoginPresenter presenter = Get.find<ILoginPresenter>();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0XFF1e224c),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 15,
                offset: Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.black12,
                // spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(vertical: 30),
          width: width * 0.9,
          height: height * 0.8,
          child: Obx(() {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: presenter.isToRegister
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    presenter.isToRegister
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: IconButton(
                              onPressed: () {
                                presenter.isToRegister = false;
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_left_sharp,
                                size: 40,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const Text(
                      'Conecta +PG',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            presenter.isToRegister
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 20.0,
                                    ),
                                    child: TextFormFieldComponent(
                                      onChanged: (value) {
                                        nameController.text = value;
                                      },
                                      presenter: presenter,
                                      obscureText: false,
                                      labelText: 'Nome completo',
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Campo obrigatório!";
                                        }
                                        if (value.length < 5) {
                                          return "Mínimo 5 caractere!";
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                            TextFormFieldComponent(
                              onChanged: (value) {
                                emailController.text = value;
                              },
                              presenter: presenter,
                              obscureText: false,
                              labelText: 'Email',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Campo obrigatório!";
                                }
                                if (!GetUtils.isEmail(value)) {
                                  return "E-mail inválido";
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: TextFormFieldComponent(
                                onChanged: (value) {
                                  passwordController.text = value;
                                },
                                presenter: presenter,
                                obscureText: true,
                                labelText: 'Senha',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Campo obrigatório!";
                                  }
                                  if (presenter.isToRegister) {
                                    if (value.length < 5) {
                                      return "Mínimo 5 caractere!";
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            presenter.loading
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                          Color(0XFF1e224c),
                                        ),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      !presenter.isToRegister
                                          ? ButtonComponent(
                                              buttonText: "Entrar",
                                              onPressed: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  await presenter.signIn(
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                    showSnackBar: (error) =>
                                                        getSnackBar(
                                                      context,
                                                      title: "Ops!",
                                                      message: error,
                                                    ),
                                                  );
                                                }
                                              },
                                            )
                                          : const SizedBox(),
                                      const SizedBox(height: 16),
                                      ButtonComponent(
                                        buttonText: "Registrar",
                                        isOutilinedButton: false,
                                        onPressed: () async {
                                          if (presenter.isToRegister) {
                                            if (formKey.currentState!
                                                .validate()) {
                                              await presenter.register(
                                                name: nameController.text,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                showSnackBar: (error) =>
                                                    getSnackBar(
                                                  context,
                                                  title: "Ops!",
                                                  message: error,
                                                ),
                                              );
                                            }
                                          }
                                          presenter.isToRegister = true;
                                        },
                                      ),
                                    ],
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey.shade300,
                                      height: 50,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text("Continue como"),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey[400],
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: const [
                                Expanded(
                                  child: LoginAsComponent(
                                    imagePath: 'lib/assets/images/google.png',
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Expanded(
                                  child: LoginAsComponent(
                                    imagePath: 'lib/assets/images/facebook.png',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
