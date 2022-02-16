import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_app_todo/model/repository/user_repository.dart';

import '../../main.dart';
import '../todo_response.dart';

class TodoRepository {
  Future<List<TodoResponse>> getTodoList() async {
    var url = Uri.parse('$baseUrl/todos');
    String? token = await UserRepository.getToken();
    return http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        List json = jsonDecode(value.body);
        return json
            .map(
              (e) => TodoResponse.fromJson(e),
            )
            .toList();
      } else {
        return [];
      }
    });
  }

  Future<bool> deleteTodo(int id) async {
    var url = Uri.parse('$baseUrl/todos/$id');
    String? token = await UserRepository.getToken();
    return http.delete(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });
  }
}
