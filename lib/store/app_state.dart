import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'route_state.dart';
import '../route/pages.dart';
import '../api/guides.dart' as api;
import '../types/guide_unread_cnt.dart';
import '../api/config.dart' as config;
import '../types/app_user.dart';

class AppState extends ChangeNotifier {
  static const String ACCESS_TOKEN = 'accessToken';
  static const String APP_USER = 'appUser';
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  final RouteState _routeState;
  RouteState get routeState => _routeState;

  AppUser? _appUser;
  AppUser? get appUser => _appUser;

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  int _currentNavIndex = 0;
  int get currentNavIndex => _currentNavIndex;
  // set currentNavIndex(int index) {
  //   _currentNavIndex = index;
  //   notifyListeners();
  // }

  int _unreadCnt = 0;
  int get unreadCnt => _unreadCnt;
  set unreadCnt(int cnt) {
    _unreadCnt = cnt;
    notifyListeners();
  }

  // private constructor
  AppState._create(this._routeState);

  // public factory
  static Future<AppState> create(RouteState routeState) async {
    print('=============================================');
    print('[CONSTRUCTOR] AppState.create');
    print('=============================================');
    print('');

    // Call the private constructor
    final AppState appState = AppState._create(routeState);
    await appState.getLogInState();

    return appState;
  }

  // loading
  void startLoading() {
    toggleLoading(true);
  }

  void endLoading() {
    toggleLoading(false);
  }

  void toggleLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // auth
  Future<void> login(AppUser appUser) async {
    await saveLoginState(appUser);
  }

  Future<void> logout() async {
    await clearLoginState();
  }

  Future<void> saveLoginState(AppUser appUser) async {
    print('=============================================');
    print('[FUNC CALL] AppState.saveLoginState');
    print('=============================================');
    print('');

    String json = jsonEncode(appUser);
    await storage.write(key: APP_USER, value: json);
    await storage.write(key: ACCESS_TOKEN, value: appUser.accessToken);

    config.headers['Authorization'] = 'Bearer ${appUser.accessToken}';
    config.http.options.headers = config.headers;

    _appUser = appUser;
    _loggedIn = true;

    print('=============================================');
    print('notifyListeners');
    print('=============================================');
    print('');

    notifyListeners();
  }

  Future<void> getLogInState() async {
    print('=============================================');
    print('[FUNC CALL] AppState.getLogInState');
    print('=============================================');
    print('');

    String? accessToken = await storage.read(key: ACCESS_TOKEN);
    String? appUserData = await storage.read(key: APP_USER);

    print('=============================================');
    print('1) appUserData :');
    print(appUserData.toString());
    print('=============================================');
    print('2) accessToken :');
    print(accessToken.toString());
    print('=============================================');
    print('');

    if (accessToken != null && appUserData != null) {
      // should validate token !
      print('=============================================');
      print('[WARN] Token Validation is missing !');
      print('=============================================');
      print('');

      Map<String, dynamic> appUserMap = jsonDecode(appUserData);
      config.headers['Authorization'] = 'Bearer $accessToken';
      config.http.options.headers = config.headers;

      _appUser = AppUser.fromJson(appUserMap);
      _loggedIn = true;

      print('=============================================');
      print('_loggedIn : $_loggedIn');
      print('=============================================');
      print('');

      print('=============================================');
      print('notifyListeners');
      print('=============================================');
      print('');

      notifyListeners();
    } else {
      await clearLoginState();
    }
  }

  Future<void> clearLoginState() async {
    print('=============================================');
    print('[FUNC CALL] AppState.clearLoginState');
    print('=============================================');
    print('');

    // await storage.deleteAll();
    await storage.delete(key: ACCESS_TOKEN);
    await storage.delete(key: APP_USER);

    // api config update
    config.headers['Authorization'] = '';
    config.http.options.headers = config.headers;

    _appUser = null;
    _loggedIn = false;

    print('=============================================');
    print('notifyListeners');
    print('=============================================');
    print('');

    notifyListeners();
  }

  Future getGuideUnreadCnt() async {
    try {
      final data = await api.getGuideUnreadCnt();
      GuideUnreadCnt unreadData = GuideUnreadCnt.fromJson(data);
      _unreadCnt = unreadData.unreadContentCount;
    } catch (e) {
      print(e);
    }
  }

  void goHomeView() {
    print('=============================================');
    print('[FUNC CALL] AppState.goHomeView');
    print('=============================================');
    print('');

    routeState.currentPageAction =
        PageAction(pageState: PageState.replaceAll, pageConfig: homePageConfig);

    print('=============================================');
    print('notifyListeners');
    print('=============================================');
    print('');

    notifyListeners();
  }

  void goLoginView() {
    routeState.currentPageAction = PageAction(
        pageState: PageState.replaceAll, pageConfig: loginPageConfig);

    print('=============================================');
    print('[FUNC CALL] AppState.goLoginView');
    print('=============================================');
    print('');

    print('=============================================');
    print('notifyListeners');
    print('=============================================');
    print('');

    notifyListeners();
  }

  void goView(int index) {
    print('=============================================');
    print('[FUNC CALL] AppState.goView');
    print('* index : $index');
    print('=============================================');
    print('');

    _currentNavIndex = index;

    switch (index) {
      case 0:
        routeState.currentPageAction = PageAction(
            pageState: PageState.replaceAll, pageConfig: homePageConfig);
        break;
      case 1:
        routeState.currentPageAction = PageAction(
            pageState: PageState.replaceAll, pageConfig: feedPageConfig);
        break;
      case 2:
        routeState.currentPageAction = PageAction(
            pageState: PageState.replaceAll, pageConfig: recordPageConfig);
        break;
      case 3:
        routeState.currentPageAction = PageAction(
            pageState: PageState.replaceAll, pageConfig: guidesPageConfig);
        break;
      case 4:
        routeState.currentPageAction = PageAction(
            pageState: PageState.replaceAll, pageConfig: menuPageConfig);
        break;
    }

    print('=============================================');
    print('notifyListeners');
    print('=============================================');
    print('');

    notifyListeners();
  }

  void goBack(dynamic result) {
    routeState.currentPageAction = PageAction(
      pageState: PageState.pop,
      pageConfig: routeState.currentPageAction.pageConfig,
    );

    print('=============================================');
    print('[FUNC CALL] AppState.goBack');
    print('=============================================');
    print('');

    print('=============================================');
    print('notifyListeners');
    print('=============================================');
    print('');

    notifyListeners();
  }

  void pushNavigation(PageConfiguration pageConfig) {
    routeState.currentPageAction =
        PageAction(pageState: PageState.addPage, pageConfig: pageConfig);

    print('=============================================');
    print('[FUNC CALL] AppState.pushNavigation');
    print('=============================================');
    print('');

    print('=============================================');
    print('notifyListeners');
    print('=============================================');
    print('');

    notifyListeners();
  }
}
