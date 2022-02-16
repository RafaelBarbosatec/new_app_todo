import 'package:flutter/material.dart';
import 'package:new_app_todo/model/repository/todo_repository.dart';
import 'package:new_app_todo/model/todo_response.dart';

class HomePresenter extends ChangeNotifier {
  final TodoRepository _repository;

  List<TodoResponse> todos = [];
  bool progress = true;

  HomePresenter(this._repository);

  void load() {
    _repository
        .getTodoList()
        .then((value) {
          todos = value;
        })
        .catchError((_error) {})
        .whenComplete(
          () {
            progress = false;
            notifyListeners();
          },
        );
  }

  void deleteTodo(TodoResponse todo) {
    progress = true;
    notifyListeners();
    _repository.deleteTodo(todo.id!).then((value) {
      if (value) {
        todos.remove(todo);
      }
    }).whenComplete(() {
      progress = false;
      notifyListeners();
    });
  }
}
