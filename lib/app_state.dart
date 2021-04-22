import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/route/pages.dart';
import 'route/pages.dart';
import 'api/config.dart' as config;

final AppState appState = AppState();

class AppState extends ChangeNotifier {
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  PageAction _currentAction = PageAction(page: homePageConfig);
  PageAction get currentAction => _currentAction;
  set currentAction(PageAction action) {
    _currentAction = action;
    notifyListeners();
  }

  String? _routeParam;
  String? get routeParam => _routeParam;
  set routeParam(String? param) {
    _routeParam = param;
    notifyListeners();
  }

  int _currentNavIndex = 0;
  int get currentNavIndex => _currentNavIndex;
  set currentNavIndex(int index) {
    _currentNavIndex = index;
    notifyListeners();
  }

  int _unreadCnt = 0;
  int get unreadCnt => _unreadCnt;
  set unreadCnt(int cnt) {
    _unreadCnt = cnt;
    notifyListeners();
  }

  AppState() {
    getLoggedInState();
  }

  void resetCurrentAction() {
    _currentAction = PageAction(page: homePageConfig);
    notifyListeners();
  }

  void goBack(dynamic result) {
    _currentAction = PageAction(
        state: PageState.pop, page: _currentAction.page, result: result);
    notifyListeners();
  }

  void redirectLoginPage() {
    _currentAction =
        PageAction(state: PageState.replaceAll, page: loginPageConfig);
    notifyListeners();
  }

  void changeNavPage(int index) {
    _currentNavIndex = index;

    switch (index) {
      case 0:
        _currentAction =
            PageAction(state: PageState.replaceAll, page: homePageConfig);
        break;
      case 1:
        _currentAction =
            PageAction(state: PageState.replaceAll, page: feedPageConfig);
        break;
      case 2:
        _currentAction =
            PageAction(state: PageState.replaceAll, page: recordPageConfig);
        break;
      case 3:
        _currentAction =
            PageAction(state: PageState.replaceAll, page: guidesPageConfig);
        break;
      case 4:
        _currentAction =
            PageAction(state: PageState.replaceAll, page: menuPageConfig);
        break;
    }

    notifyListeners();
  }

  void pushNavigation(PageConfiguration pageConfig) {
    _currentAction = PageAction(state: PageState.addPage, page: pageConfig);
    notifyListeners();
  }

  void login() {
    _loggedIn = true;
    saveLoginState(loggedIn);
    _currentAction =
        PageAction(state: PageState.replaceAll, page: homePageConfig);
    notifyListeners();
  }

  void logout() {
    // api config update
    config.headers['Authorization'] = '';

    _loggedIn = false;
    saveLoginState(loggedIn);
    _currentAction =
        PageAction(state: PageState.replaceAll, page: loginPageConfig);
    notifyListeners();
  }

  void saveLoginState(bool loggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('LoggedInKey', loggedIn);
  }

  void getLoggedInState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _loggedIn = prefs.getBool('LoggedInKey') ?? false;
    if (_loggedIn == null) {
      _loggedIn = false;
    }
  }
}
