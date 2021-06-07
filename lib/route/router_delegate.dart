import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'pages.dart';
import '../store/app_state.dart';
import '../views/unknown_view.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';
import '../views/feed_view.dart';
import '../views/guides_view.dart';
import '../views/record_view.dart';
import '../views/menu_view.dart';
import '../views/record/record_body.dart';
import '../views/guides/guide_category.dart';
import '../views/guides/guide_article.dart';

// Configutaion for each route
// * PopNavigatorRouterDelegateMixin : lets remove pages, requires navigator key
class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  // private, so it can't be modified directly
  // will be handled outside of here later
  final List<Page> _pages = [];
  final AppState appState;

  // takes in the appState, and creates a global navigator key
  AppRouterDelegate(this.appState) : navigatorKey = GlobalKey() {
    appState.addListener(() {
      print('appState Listened Change!');
      notifyListeners();
    });
  }

  // called when route information change is detected
  // current means the topmost page (_pages.last)
  @override
  PageConfiguration get currentConfiguration =>
      _pages.last.arguments as PageConfiguration;

  // public getter
  List<MaterialPage> get pages => List.unmodifiable(_pages);
  int numPages() => _pages.length;

  // _onPopPage
  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);
    if (!didPop) return false;
    return pop(null);
  }

  void _removePage(MaterialPage page) {
    _pages.remove(page);
  }

  bool pop(dynamic result) {
    if (canPop()) {
      _removePage(pages.last);
      return true;
    } else {
      return false;
    }
  }

  bool canPop() {
    return _pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(pages.last);
      return Future.value(true);
    }
    return Future.value(false);
  }

  // Material Page
  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
        child: child,
        // key: Key(pageConfig.name),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    _pages.add(_createPage(child, pageConfig));
  }

  void addPage(PageConfiguration pageConfig) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).page != pageConfig.page;

    if (shouldAddPage) {
      // if has some param
      appState.setRouteParam(pageConfig.param);

      switch (pageConfig.page) {
        case Pages.Login:
          _addPageData(LoginView(), loginPageConfig);
          break;
        case Pages.Home:
          _addPageData(HomeView(), homePageConfig);
          break;
        case Pages.Feed:
          _addPageData(FeedView(), feedPageConfig);
          break;
        case Pages.Guides:
          _addPageData(GuidesView(), guidesPageConfig);
          break;
        case Pages.Record:
          _addPageData(RecordView(), recordPageConfig);
          break;
        case Pages.Menu:
          _addPageData(MenuView(), menuPageConfig);
          break;
        case Pages.RecordBody:
          _addPageData(RecordBody(), pageConfig);
          break;
        case Pages.GuideCategoryDetails:
          _addPageData(GuideCategoryDetails(), pageConfig);
          break;
        case Pages.GuideArticle:
          _addPageData(GuideArticle(), pageConfig);
          break;
        default:
          _addPageData(UnknownView(), PageConfiguration.unknown());
          break;
      }
    }
  }

  // modifying pages
  void replaceAll(PageConfiguration pageConfig) {
    setNewRoutePath(pageConfig);
  }

  void replace(PageConfiguration pageConfig) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(pageConfig);
  }

  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
  }

  void push(PageConfiguration pageConfig) {
    addPage(pageConfig);
  }

  void pushWidget(Widget? child, PageConfiguration pageConfig) {
    if (child != null) _addPageData(child, pageConfig);
  }

  void addAll(List<PageConfiguration>? routes) {
    if (routes != null) {
      _pages.clear();
      routes.forEach((route) {
        addPage(route);
      });
    }
  }

  // _setPageAction
  void _setPageAction(PageAction action) {
    switch (action.page.page) {
      case Pages.Login:
        loginPageConfig.currentPageAction = action;
        break;
      case Pages.Home:
        homePageConfig.currentPageAction = action;
        break;
      case Pages.Feed:
        feedPageConfig.currentPageAction = action;
        break;
      case Pages.Guides:
        guidesPageConfig.currentPageAction = action;
        break;
      case Pages.Record:
        recordPageConfig.currentPageAction = action;
        break;
      case Pages.Menu:
        menuPageConfig.currentPageAction = action;
        break;
      case Pages.RecordBody:
        action.page.currentPageAction = action;
        break;
      case Pages.GuideArticle:
        action.page.currentPageAction = action;
        break;
      default:
        break;
    }
  }

  List<Page> buildPages() {
    switch (appState.routeState.currentAction.state) {
      case PageState.none:
        break;
      case PageState.addPage:
        _setPageAction(appState.routeState.currentAction);
        addPage(appState.routeState.currentAction.page);
        break;
      case PageState.pop:
        pop(appState.routeState.currentAction.result);
        break;
      case PageState.replace:
        // 6
        _setPageAction(appState.routeState.currentAction);
        replace(appState.routeState.currentAction.page);
        break;
      case PageState.replaceAll:
        // 7
        _setPageAction(appState.routeState.currentAction);
        replaceAll(appState.routeState.currentAction.page);
        break;
      case PageState.addWidget:
        // 8
        _setPageAction(appState.routeState.currentAction);
        pushWidget(appState.routeState.currentAction.widget,
            appState.routeState.currentAction.page);
        break;
      case PageState.addAll:
        // 9
        addAll(appState.routeState.currentAction.pages);
        break;
    }

    // appState.resetrouteState.currentAction();
    // _pages should be List<MaterialPage> with key and child
    return List.of(_pages);
  }

  // returns the Navigator
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey, onPopPage: _onPopPage, pages: buildPages());
  }

  // handles the routing when user enters URL in the browser
  @override
  Future<void> setNewRoutePath(PageConfiguration pageConfig) {
    print('New route path is to be set');

    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).page != pageConfig.page;

    if (shouldAddPage) {
      _pages.clear();
      addPage(pageConfig);
    }

    return SynchronousFuture(null);
  }
}
