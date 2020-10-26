import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bool_app/core/app_state.dart';
import 'package:flutter_bool_app/core/route2/app2state.dart';
import 'package:flutter_bool_app/core/route2/page_manager.dart';
import 'package:flutter_bool_app/core/route2/route2delegate.dart';
import 'package:flutter_bool_app/core/todo_model.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController titleCont;

  TextEditingController contentCont;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    titleCont = TextEditingController();
    contentCont = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleCont.dispose();
    contentCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<App2State>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleCont,
                validator: (s) {
                  if (s.length < 4) {
                    return 'Title is too short';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: contentCont,
                validator: (s) {
                  if (s.length < 10) {
                    return 'Content is too short';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: 150,
                child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    if (!formKey.currentState.validate()) return;
                    final todo = Todo(
                        id: model.todos.length,
                        title: titleCont.text,
                        content: contentCont.text,
                        dateTime: DateTime.now().microsecondsSinceEpoch,
                        done: false);
                    model.addTodo(todo);
                    PageManager.of(context).goBack();
                  },
                  child: Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
