import 'package:flutter/material.dart';
import 'package:new_app_todo/model/repository/todo_repository.dart';
import 'package:new_app_todo/model/repository/user_repository.dart';
import 'package:new_app_todo/persenter/home_presenter.dart';
import 'package:new_app_todo/persenter/sign_in_presenter.dart';
import 'package:new_app_todo/view/home/home_page.dart';
import 'package:new_app_todo/view/sign_in/sign_in_page.dart';
import 'package:provider/provider.dart';

const baseUrl = 'https://todo-lovepeople.herokuapp.com';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    final todoRepository = TodoRepository();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignInPresenter(userRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => HomePresenter(todoRepository),
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
