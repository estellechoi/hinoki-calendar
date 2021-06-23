import 'package:flutter/material.dart';
import 'package:flutter_app/views/unknown_view.dart';
import '../views/unknown_view.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';
import '../views/feed_view.dart';
import '../views/guides_view.dart';
import '../views/record_view.dart';
import '../views/menu_view.dart';

// Path
const String unknownPath = '/unknown';
const String loginPath = '/login';
const String feedPath = '/feed';
const String homePath = '/home';
const String guidesPath = '/guides';
const String recordPath = '/record';
const String menuPath = '/menu';

enum Pages {
  Unknown,
  Login,
  Feed,
  Home,
  Guides,
  Record,
  Menu,
}

enum PageState { none, addPage, pop, replace, replaceAll }

class PageConfiguration {
  final String name;
  final String path;
  final Pages page;
  final Widget widget;
  final bool isUnknown;

  PageConfiguration({
    required this.name,
    required this.path,
    required this.page,
    required this.widget,
    this.isUnknown = false,
  });

  PageConfiguration.unknown()
      : name = 'Unknown',
        path = unknownPath,
        page = Pages.Unknown,
        widget = UnknownView(),
        isUnknown = true;
}

class PageAction {
  final PageState pageState;
  final PageConfiguration pageConfig;
  final String? param;

  PageAction({
    this.pageState = PageState.none,
    required this.pageConfig,
    this.param,
  });
}

// Initial Pages
final PageConfiguration loginPageConfig = PageConfiguration(
    name: 'Login', path: loginPath, page: Pages.Login, widget: LoginView());

// Bottom Navigation Pages
final PageConfiguration feedPageConfig = PageConfiguration(
    name: 'Feed', path: feedPath, page: Pages.Feed, widget: FeedView());

final PageConfiguration homePageConfig = PageConfiguration(
    name: 'Home', path: homePath, page: Pages.Home, widget: HomeView());

final PageConfiguration guidesPageConfig = PageConfiguration(
    name: 'Guides', path: guidesPath, page: Pages.Guides, widget: GuidesView());

final PageConfiguration recordPageConfig = PageConfiguration(
    name: 'Record', path: recordPath, page: Pages.Record, widget: RecordView());

final PageConfiguration menuPageConfig = PageConfiguration(
    name: 'Menu', path: menuPath, page: Pages.Menu, widget: MenuView());
