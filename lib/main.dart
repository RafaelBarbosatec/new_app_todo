import 'package:flutter/material.dart';
import 'package:new_app_todo/model/repository/user_repository.dart';
import 'package:new_app_todo/persenter/sign_in_presenter.dart';
import 'package:new_app_todo/view/home/home_page.dart';
import 'package:new_app_todo/view/sign_in/sign_in_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignInPresenter(userRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (_) => const SignInPage(),
          '/home': (_) => const HomePage(),
        },
      ),
    );
  }
}
