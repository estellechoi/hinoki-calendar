import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import './views/index.dart';

// Run App
void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

// App Stateful
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// App State
class _MyAppState extends State<MyApp> {
  AppRouterDelegate _routerDelegate = AppRouterDelegate();
  AppRouteInformationParser _routeInformationParser =
      AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Hinoki Calendar',
        theme: ThemeData(primaryColor: Colors.white),
        routerDelegate: _routerDelegate,
        routeInformationParser: _routeInformationParser);
  }
}

// AppRoutePath
class AppRoutePath {
  final String? id;

  AppRoutePath.home() : id = null;
  AppRoutePath.todos(this.id);

  bool get isHomePage => id == null;
  bool get isTodosPage => id != null;
}

// AppRouteInformationParser
class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location.toString());

    if (uri.pathSegments.length >= 2) {
      String pathId = uri.pathSegments[1];
      return AppRoutePath.todos(pathId);
    } else {
      return AppRoutePath.home();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoutePath path) {
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }

    if (path.isTodosPage) {
      return RouteInformation(location: '/todos/${path.id}');
    }

    return null;
  }
}

// AppRouterDelegate
class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  // Navigator Key
  final GlobalKey<NavigatorState> navigatorKey;

  String? _selectedDate;

  void onTabbed(String _newDate) {
    _selectedDate = _newDate;
    notifyListeners();
  }

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  AppRoutePath get currentConfiguration =>
      _selectedDate == null ? AppRoutePath.home() : AppRoutePath.todos('1');

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        // transitionDelegate: NoAnimationTransitionDelegate(),
        pages: [
          MaterialPage(key: ValueKey('IndexPage'), child: Views()),
          if (_selectedDate != null)
            AnimationPage(child: Views(), title: 'index')
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          _selectedDate = null;
          notifyListeners();

          return true;
        });
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    if (path.isTodosPage) {
      _selectedDate = '2021-05-01';
    }
  }
}

// Route Page - Animation
class AnimationPage extends Page {
  final child;
  final title;

  AnimationPage({required this.child, required this.title})
      : super(key: ValueKey(title));

  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, animation2) {
          final tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
          final curveTween = CurveTween(curve: Curves.easeInOut);
          return SlideTransition(
              position: animation.drive(curveTween).drive(tween), child: child);
        });
  }
}

// routes: Map.fromEntries(routes.map((route) => MapEntry(route.route, route.builder))),

// final routes = [
//   Route(
//       name: 'Home',
//       route: '/home',
//       builder: (context) => Home(title: 'Hinoki Calendar')
//   ),
//   Route(
//       name: 'Todos',
//       route: '/todos',
//       builder: (context) => Todos(title: 'Hinoki Calendar')
//   ),
// ];
//
// class Route {
//   final String name;
//   final String route;
//   final WidgetBuilder builder;
//
//   const Route({ required this.name, required this.route, required this.builder });
// }
//
