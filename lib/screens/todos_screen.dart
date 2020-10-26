import 'package:flutter/material.dart';
import 'package:flutter_bool_app/core/app_state.dart';
import 'package:flutter_bool_app/core/route2/app2state.dart';
import 'package:flutter_bool_app/core/route2/page_manager.dart';
import 'package:flutter_bool_app/core/route2/route2delegate.dart';
import 'package:provider/provider.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<App2State>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: model.todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.note),
            title: Text(model.todos[index].title),
            subtitle: Text(model.todos[index].content),
            onTap: () {
              PageManager.of(context).openTodoDetails(model.todos[index].id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PageManager.of(context).openAddTodo();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
