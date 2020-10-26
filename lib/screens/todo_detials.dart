import 'package:flutter/material.dart';
import 'package:flutter_bool_app/core/route2/app2state.dart';
import 'package:flutter_bool_app/core/todo_model.dart';
import 'package:provider/provider.dart';

class TodoDetails extends StatefulWidget {
  final int todoId;

  const TodoDetails({Key key, this.todoId}) : super(key: key);

  @override
  _TodoDetailsState createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  Todo todo;
  @override
  void didChangeDependencies() {
    print('id recieved ${widget.todoId}');
    final model = Provider.of<App2State>(context);
    todo = model.todoById(widget.todoId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return todo == null
        ? Scaffold(
            body: Center(
              child: Text('Todo was not found'),
            ),
          )
        : Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(color: Colors.deepOrange, fontSize: 48),
                ),
                Text(
                  todo.content,
                ),
              ],
            ),
          );
  }
}
