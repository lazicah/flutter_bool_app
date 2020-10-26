import 'package:flutter/material.dart';
import 'package:flutter_bool_app/core/app_state.dart';
import 'package:flutter_bool_app/core/route2/app2state.dart';
import 'package:flutter_bool_app/core/route2/page_manager.dart';
import 'package:flutter_bool_app/core/route2/view_routes.dart';
import 'package:flutter_bool_app/main.dart';
import 'package:flutter_bool_app/screens/todos_screen.dart';
import 'package:provider/provider.dart';

class Route2Delegate extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  final PageManager pageManager = PageManager();

  Route2Delegate() {
    pageManager.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PageManager>.value(
      value: pageManager,
      child: Consumer<PageManager>(
        builder: (context, pageManager, child) {
          return Navigator(
            key: navigatorKey,
            onPopPage: _handlePopPage,
            pages: List.of(pageManager.pages),
          );
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) async {
    pageManager.setNewRoutePath(configuration);
  }

  @override
  List<RouteSettings> get currentConfiguration => pageManager.configuration;

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    Page page = route.settings;
    print('popped ${page.name}');
    if (page.key == ValueKey<String>('home')) {
      assert(!route.willHandlePopInternally);
      // Do not pop the home page.
      return false;
    }

    final bool popped = route.didPop(result);
    assert(popped);

    pageManager.didPop(page);

    assert(false); // We should never be asked to pop anything else.
    return true;
  }
}
