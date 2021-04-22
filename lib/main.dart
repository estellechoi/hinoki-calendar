import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'route/router_delegate.dart';
import 'route/router_parser.dart';
import 'route/back_dispatcher.dart';
import 'route/pages.dart';
import 'app_state.dart';
import 'widgets/styles/colors.dart' as colors;

// main()
Future main() async {
  await DotEnv.load(fileName: '.env');
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

// Root App
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// Root App State
class _MyAppState extends State<MyApp> {
  final AppRouteInformationParser _routeInformationParser =
      AppRouteInformationParser();
  late final AppBackButtonDispatcher _backButtonDispatcher;
  late final AppRouterDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();

    // create delegate with appState field
    _routerDelegate = AppRouterDelegate(appState);
    // set up initial route of this app
    _routerDelegate.setNewRoutePath(homePageConfig);
    // link back displatcher with router delegate
    _backButtonDispatcher = AppBackButtonDispatcher(_routerDelegate);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Hinoki Calendar',
        theme: ThemeData(
          primaryColor: colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerDelegate: _routerDelegate,
        routeInformationParser: _routeInformationParser,
        backButtonDispatcher: _backButtonDispatcher);
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
