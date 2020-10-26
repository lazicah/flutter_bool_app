import 'package:flutter/material.dart';
import 'package:flutter_bool_app/core/app_state.dart';
import 'package:flutter_bool_app/core/route2/app2state.dart';
import 'package:flutter_bool_app/core/route2/route2delegate.dart';
import 'package:flutter_bool_app/core/route2/route2infoParser.dart';
import 'package:flutter_bool_app/core/routing/route_parser.dart';
import 'package:flutter_bool_app/core/routing/router_delegate.dart';
import 'package:provider/provider.dart';

import 'core/route2/page_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<App2State>(
          create: (context) => App2State(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        routerDelegate: Route2Delegate(),
        routeInformationParser: Route2InfoParser(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Todo App',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              onPressed: () {
                PageManager.of(context).openTodos();
              },
              child: Text('Open Todo'),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
