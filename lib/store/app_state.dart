import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'route_state.dart';
import '../route/pages.dart';
import '../api/guides.dart' as api;
import '../types/guide_unread_cnt.dart';
import '../api/config.dart' as config;

class AppState extends ChangeNotifier {
  final RouteState _routeState;
  RouteState get routeState => _routeState;

  final FlutterSecureStorage storage = new FlutterSecureStorage();

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

  // constructor
  AppState(this._routeState) {
    getLoggedInState();
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
  void login() {
    _loggedIn = true;
    saveLoginState(loggedIn);
    goHomeView();
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    saveLoginState(loggedIn);

    // api config update
    config.headers['Authorization'] = '';

    notifyListeners();
  }

  Future<void> saveLoginState(bool loggedIn) async {
    await storage.write(key: 'loggedIn', value: 'true');
  }

  Future<void> getLoggedInState() async {
    String? loggedIn = await storage.read(key: 'loggedIn');
    _loggedIn = loggedIn == 'true';
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
