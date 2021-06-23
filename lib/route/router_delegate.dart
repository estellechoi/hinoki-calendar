import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'pages.dart';
import '../store/app_state.dart';

// Configutaion for each route
// * PopNavigatorRouterDelegateMixin : lets remove pages, requires navigator key
class AppRouterDelegate extends RouterDelegate<PageAction>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageAction> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  // private, so it can't be modified directly
  // will be handled outside of here later
  final List<Page> _pages = [];
  final AppState appState;

  // takes in the appState, and creates a global navigator key
  AppRouterDelegate(this.appState) : navigatorKey = GlobalKey() {
    print('=============================================');
    print('[CONSTRUCTOR] AppRouterDelegate');
    print('=============================================');
    print('');

    appState.addListener(() {
      print('=============================================');
      print('[NOTIFY LISTENER] AppState Notify Listened !');
      print('=============================================');
      print('');

      print('=============================================');
      print('notifyListeners');
      print('=============================================');
      print('');

      notifyListeners();
    });
  }

  // called when route information change is detected
  // current means the topmost page (_pages.last)
  // @override
  // PageAction get currentConfiguration => _pages.last.arguments as PageAction;

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

  MaterialPage _createPage(PageConfiguration pageConfig) {
    return MaterialPage(
        child: pageConfig.widget,
        // key: Key(pageConfig.name),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  void _addPageData(PageConfiguration pageConfig) {
    print('=============================================');
    print('[FUNC CALL] AppRouterDelegate._addPageData');
    print('=============================================');
    print('');

    _pages.add(_createPage(pageConfig));
  }

  void addPage(PageAction pageAction) {
    print('=============================================');
    print('[FUNC CALL] AppRouterDelegate.addPage');
    print('=============================================');
    print('');

    print('=============================================');
    print('* Page Name : ${pageAction.pageConfig.name}');
    print('* Page Action Param : ${pageAction.param}');
    print('=============================================');
    print('');

    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).page !=
            pageAction.pageConfig.page;

    print('=============================================');
    print('* Should Add Page : $shouldAddPage');
    print('=============================================');
    print('');

    if (shouldAddPage) {
      if (Pages.values.contains(pageAction.pageConfig.page)) {
        appState.routeState.routeParam = pageAction.param;
        _addPageData(pageAction.pageConfig);
      } else {
        _addPageData(PageConfiguration.unknown());
      }
    }
  }

  // modifying pages
  void replaceAll(PageAction pageAction) {
    print('=============================================');
    print('[FUNC CALL] AppRouterDelegate.replaceAll');
    print('=============================================');
    print('');

    setNewRoutePath(pageAction);
  }

  void replace(PageAction pageAction) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(pageAction);
  }

  void push(PageAction pageAction) {
    addPage(pageAction);
  }

  List<Page> buildPages() {
    print('=============================================');
    print('[FUNC CALL] AppRouterDelegate.buildPages');
    print('=============================================');
    print('');

    final PageAction pageAction = appState.routeState.currentPageAction;

    print('=============================================');
    print('* Page State : ${pageAction.pageState}');
    print('* Page : ${pageAction.pageConfig.page}');
    print('* Page Name : ${pageAction.pageConfig.name}');
    print('* Page is Unknown : ${pageAction.pageConfig.isUnknown}');
    print('=============================================');
    print('');

    switch (pageAction.pageState) {
      case PageState.none:
        break;
      case PageState.addPage:
        addPage(pageAction);
        break;
      case PageState.pop:
        pop(pageAction);
        break;
      case PageState.replace:
        // 6
        replace(pageAction);
        break;
      case PageState.replaceAll:
        // 7
        replaceAll(pageAction);
        break;
    }

    return List.of(_pages);
  }

  // returns the Navigator
  @override
  Widget build(BuildContext context) {
    print('=============================================');
    print('[FUNC CALL] AppRouterDelegate.build');
    print('=============================================');
    print('');

    return Navigator(
        key: navigatorKey, onPopPage: _onPopPage, pages: buildPages());
  }

  // handles the routing when user enters URL in the browser
  @override
  Future<void> setNewRoutePath(PageAction pageAction) {
    print('=============================================');
    print('[FUNC CALL] AppRouterDelegate.setNewRoutePath');
    print('* Page Name : ${pageAction.pageConfig.name}');
    print('=============================================');
    print('');

    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).page !=
            pageAction.pageConfig.page;

    print('=============================================');
    print('* should Add Page : $shouldAddPage');
    print('=============================================');
    print('');

    if (shouldAddPage) {
      _pages.clear();
      addPage(pageAction);
    }

    return SynchronousFuture(null);
  }
}
