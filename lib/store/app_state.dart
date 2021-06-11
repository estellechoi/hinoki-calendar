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

  final RouteState _routeState;
  RouteState get routeState => _routeState;

  final FlutterSecureStorage storage = new FlutterSecureStorage();

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

  // constructor
  AppState(this._routeState) {
    getLogInState();
  }

  // nav bar index
  void changeNavPage(index) {
    _currentNavIndex = index;
    goView(index);
    notifyListeners();
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
  void login(AppUser appUser) {
    saveLoginState(appUser);
    goHomeView();
  }

  void logout() {
    clearLoginState();
  }

  Future<void> saveLoginState(AppUser appUser) async {
    String json = jsonEncode(appUser);
    await storage.write(key: APP_USER, value: json);
    await storage.write(key: ACCESS_TOKEN, value: appUser.accessToken);
    config.headers['Authorization'] = 'Bearer ${appUser.accessToken}';
    _appUser = appUser;
    _loggedIn = true;
    notifyListeners();
  }

  Future<void> getLogInState() async {
    String? accessToken = await storage.read(key: ACCESS_TOKEN);
    String? appUserData = await storage.read(key: APP_USER);

    if (accessToken != null && appUserData != null) {
      // should validate token !

      Map<String, dynamic> appUserMap = jsonDecode(appUserData);
      config.headers['Authorization'] = 'Bearer $accessToken';
      _appUser = AppUser.fromJson(appUserMap);
      _loggedIn = true;
      notifyListeners();
    } else {
      clearLoginState();
    }
  }

  Future<void> clearLoginState() async {
    // await storage.deleteAll();
    await storage.delete(key: ACCESS_TOKEN);
    await storage.delete(key: APP_USER);

    // api config update
    config.headers['Authorization'] = '';
    _appUser = null;
    _loggedIn = false;
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

  // routeState mutating
  void setRouteParam(String? param) {
    routeState.routeParam = param;
    notifyListeners();
  }

  void goHomeView() {
    routeState.currentAction =
        PageAction(state: PageState.replaceAll, page: homePageConfig);
    notifyListeners();
  }

  void goLoginView() {
    routeState.currentAction =
        PageAction(state: PageState.replaceAll, page: loginPageConfig);
    notifyListeners();
  }

  void goView(int index) {
    switch (index) {
      case 0:
        routeState.currentAction =
            PageAction(state: PageState.replaceAll, page: homePageConfig);
        break;
      case 1:
        routeState.currentAction =
            PageAction(state: PageState.replaceAll, page: feedPageConfig);
        break;
      case 2:
        routeState.currentAction =
            PageAction(state: PageState.replaceAll, page: recordPageConfig);
        break;
      case 3:
        routeState.currentAction =
            PageAction(state: PageState.replaceAll, page: guidesPageConfig);
        break;
      case 4:
        routeState.currentAction =
            PageAction(state: PageState.replaceAll, page: menuPageConfig);
        break;
    }
    notifyListeners();
  }

  void goBack(dynamic result) {
    routeState.currentAction = PageAction(
        state: PageState.pop,
        page: routeState.currentAction.page,
        result: result);
    notifyListeners();
  }

  void pushNavigation(PageConfiguration pageConfig) {
    routeState.currentAction =
        PageAction(state: PageState.addPage, page: pageConfig);
    notifyListeners();
  }
}
