import 'package:flutter/material.dart';
import 'pages.dart';
import '../app_state.dart';

// AppRouteInformationParser
class AppRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  // RouteInformationParser
  // parses the route information into a user-defined data type (PageConfiguration)
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');

    print('---------------------------- URI');
    print(uri);
    print('---------------------------- IS LOGGEDIN ?');
    print(appState.loggedIn);

    // handle '/'
    if (uri.pathSegments.isEmpty) {
      return appState.loggedIn ? homePageConfig : loginPageConfig;
    }

    final String path = '/${uri.pathSegments[0]}';

    // if not logged in, redirect to login page
    if (appState.loggedIn == false && path != loginPath) {
      appState.redirectLoginPage();
    }

    // path with param
    if (uri.pathSegments.length >= 2) {
      var param = uri.pathSegments[1];

      switch (path) {
        case recordPath:
          return PageConfiguration.param(
              'RecordBody', recordBodyPath, Pages.RecordBody, param, null);
      }
    }

    // basic path
    switch (path) {
      case loginPath:
        return appState.loggedIn ? homePageConfig : loginPageConfig;
      case homePath:
        return homePageConfig;
      case feedPath:
        return feedPageConfig;
      case guidesPath:
        return guidesPageConfig;
      case recordPath:
        return recordPageConfig;
      case menuPath:
        return menuPageConfig;
      case recordPath:
        return recordBodyPageConfig;
      default:
        return PageConfiguration.unknown();
    }
  }

  // store the browsing history in the browser
  @override
  RouteInformation restoreRouteInformation(PageConfiguration pageConfig) {
    switch (pageConfig.page) {
      case Pages.Login:
        return const RouteInformation(location: loginPath);
      case Pages.Home:
        return const RouteInformation(location: homePath);
      case Pages.Feed:
        return const RouteInformation(location: feedPath);
      case Pages.Guides:
        return const RouteInformation(location: guidesPath);
      case Pages.Record:
        return const RouteInformation(location: recordPath);
      case Pages.Menu:
        return const RouteInformation(location: menuPath);
      case Pages.RecordBody:
        String param = pageConfig.param == null ? '' : '/${pageConfig.param}';
        return RouteInformation(location: recordBodyPath + param);
      default:
        return const RouteInformation(location: unknownPath);
    }
  }
}
