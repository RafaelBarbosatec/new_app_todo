import 'package:flutter/material.dart';
import 'package:new_app_todo/persenter/sign_in_presenter.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void didChangeDependencies() {
    context.read<SignInPresenter>().verifyLogin(
      () {
       Navigator.of(context).pushNamedAndRemoveUntil(
            '/home',
            (_) => false,
          );
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInPresenter>(
      builder: (_, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Campo obrigatório';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            hintText: 'Senha',
                          ),
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Campo obrigatório';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.login(
                                  email: _emailController.text,
                                  senha: _passwordController.text,
                                  onFailure: () {
                                    const snackBar = SnackBar(
                                      content:
                                          Text('Opa! Email ou senha inválidos'),
                                      backgroundColor: Colors.red,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  onSuccess: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      '/home',
                                      (_) => false,
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text('Entrar'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (controller.progress)
                Container(
                  color: Colors.white.withOpacity(0.8),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
