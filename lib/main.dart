import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/store/auth_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'route/router_delegate.dart';
import 'route/router_parser.dart';
import 'route/back_dispatcher.dart';
import 'route/pages.dart';
import 'store/route_state.dart';
import 'store/app_state.dart';
import 'widgets/styles/colors.dart' as colors;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'utils/fcm_controller.dart';

Future<void> _handleFirebaseMessage(RemoteMessage message) async {
  print("A background message: ${message.messageId}");
}

Future<void> main() async {
  // main 메소드에서 서버나 SharedPreferences 등 비동기로 데이터를 다룬 다음 runApp을 실행해야하는 경우
  WidgetsFlutterBinding.ensureInitialized();

  await DotEnv.load(fileName: '.env');

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_handleFirebaseMessage);

  initializeDateFormatting().then((_) => runApp(MyApp()));
}

// Root App
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// Root App State
class _MyAppState extends State<MyApp> {
  final RouteState _routeState = RouteState();
  late final AppState _appState;
  late final AppRouteInformationParser _routeInformationParser;
  late final AppBackButtonDispatcher _backButtonDispatcher;
  late final AppRouterDelegate _routerDelegate;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late final FCMController _fcmController;

  @override
  void initState() {
    super.initState();
    _appState = AppState(_routeState);
    _routerDelegate = AppRouterDelegate(_appState);
    _routerDelegate.setNewRoutePath(homePageConfig);
    _routeInformationParser = AppRouteInformationParser(_appState);
    _backButtonDispatcher = AppBackButtonDispatcher(_routerDelegate);

    _fcmController = FCMController(_fcm);
    if (Platform.isIOS) _fcmController.requestPermission();
    _fcmController.getMessage();

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('FirebaseMessaging.onMessageOpenedApp listened !');
      print(message.data);
    });
  }

  // AppRouterDelegate getRouterDelegate(BuildContext context) {
  //   return AppRouterDelegate(getAppState(context));
  // }

  // AppState getAppState(BuildContext context) {
  //   return context.read<AppState>();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (BuildContext ctx) => _appState),
          Provider(
            create: (BuildContext ctx) => AuthProvider(FirebaseAuth.instance),
          ),
          StreamProvider(
              create: (BuildContext ctx) =>
                  ctx.read<AuthProvider>().authStateChanges,
              initialData: null)
        ],
        child: MaterialApp.router(
            title: 'Hinoki Calendar',
            theme: ThemeData(
              primaryColor: colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            routerDelegate: _routerDelegate,
            routeInformationParser: _routeInformationParser,
            backButtonDispatcher: _backButtonDispatcher));
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
