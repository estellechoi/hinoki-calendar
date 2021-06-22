import 'package:flutter/material.dart';
import 'package:flutter_app/route/pages.dart';
import '../route/pages.dart';
import '../api/config.dart' as config;

class RouteState {
  PageAction _currentPageAction = PageAction(page: homePageConfig);
  PageAction get currentPageAction => _currentPageAction;
  set currentPageAction(PageAction action) {
    _currentPageAction = action;
  }

  String? _routeParam;
  String? get routeParam => _routeParam;
  set routeParam(String? param) {
    _routeParam = param;
  }

  RouteState();
}
