import 'package:flutter/material.dart';
import 'package:new_app_todo/model/repository/user_repository.dart';

class SignInPresenter extends ChangeNotifier {
  bool progress = false;
  final UserRepository _repository;

  SignInPresenter(this._repository);

  void login({
    required String email,
    required String senha,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {
    progress = true;
    notifyListeners();
    _repository.login(email, senha).then(
      (value) {
        onSuccess();
      },
    ).catchError(
      (_, error) {
        onFailure();
      },
    ).whenComplete(() {
      progress = false;
      notifyListeners();
    });
  }

  void verifyLogin(VoidCallback logged) {
    UserRepository.getToken().then((value) {
      if (value != null) {
        logged();
      }
    });
  }
}
