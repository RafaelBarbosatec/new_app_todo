import 'package:flutter/material.dart';
import 'package:new_app_todo/model/todo_response.dart';
import 'package:new_app_todo/persenter/home_presenter.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    context.read<HomePresenter>().load();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Consumer<HomePresenter>(
        builder: (_, controller, child) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: controller.todos.length,
                itemBuilder: (context, index) {
                  final todo = controller.todos[index];
                  return Card(
                    child: ListTile(
                      title: Text(todo.title ?? ''),
                      subtitle: Text(todo.description ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _buildDialog(todo, controller);
                        },
                      ),
                    ),
                  );
                },
              ),
              if (controller.progress)
                Container(
                  color: Colors.white.withOpacity(0.8),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  _buildDialog(TodoResponse todo, HomePresenter presenter) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Realmente deseja excluir o todo: ${todo.title}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                presenter.deleteTodo(todo);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
