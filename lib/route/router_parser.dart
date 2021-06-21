import 'package:flutter/material.dart';
import 'pages.dart';
import '../store/app_state.dart';

// AppRouteInformationParser
class AppRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  final AppState appState;

  AppRouteInformationParser(this.appState) {
    print('=============================================');
    print('[CONSTRUCTOR] AppRouteInformationParser');
    print('=============================================');
    print('');
  }

  // RouteInformationParser
  // parses the route information into a user-defined data type (PageConfiguration)
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    print('=============================================');
    print('[FUNC CALL] AppRouteInformationParser.parseRouteInformation');
    print('=============================================');
    print('');

    final uri = Uri.parse(routeInformation.location ?? '');
    print('=============================================');
    print('* URI : $uri');
    print('* appState.loggedIn : ${appState.loggedIn}');
    print('=============================================');
    print('');

    // if not logged in
    if (!appState.loggedIn) {
      return loginPageConfig;
    }

    // handle '/'
    if (uri.pathSegments.isEmpty) {
      return homePageConfig;
    }

    final String path = '/${uri.pathSegments[0]}';

    // handle path param
    if (uri.pathSegments.length >= 2) {
      final param = uri.pathSegments[1];

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
    print('=============================================');
    print('[FUNC CALL] AppRouteInformationParser.restoreRouteInformation');
    print('=============================================');
    print('');

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
