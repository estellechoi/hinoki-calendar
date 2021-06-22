import 'package:flutter/material.dart';

// Path
const String unknownPath = '/unknown';
const String loginPath = '/login';
const String feedPath = '/feed';
const String homePath = '/home';
const String guidesPath = '/guides';
const String recordPath = '/record';
const String menuPath = '/menu';

const String recordBodyPath = '/record-body';
const String guideCategoryDetailsPath = '/guide-category';
const String guideArticlePath = '/guide-article';

enum Pages {
  Unknown,
  Login,
  Feed,
  Home,
  Guides,
  Record,
  Menu,
  RecordBody,
  GuideCategoryDetails,
  GuideArticle,
  SignupForm
}
enum PageState { none, addPage, addAll, addWidget, pop, replace, replaceAll }

class PageConfiguration {
  final String name;
  final String path;
  final Pages page;

  final bool isUnknown;
  final String? param;
  PageAction? currentPageAction;

  PageConfiguration(
      {required this.name,
      required this.path,
      required this.page,
      this.isUnknown = false,
      this.currentPageAction})
      : param = null;

  // named constructors
  PageConfiguration.param(
      this.name, this.path, this.page, this.param, this.currentPageAction)
      : isUnknown = false;

  PageConfiguration.unknown()
      : name = 'Unknown',
        path = unknownPath,
        page = Pages.Unknown,
        param = null,
        currentPageAction = null,
        isUnknown = true;
}

class PageAction {
  final PageState state;
  final PageConfiguration page;
  List<PageConfiguration>? pages;
  Widget? widget;
  dynamic result;

  PageAction(
      {this.state = PageState.none,
      required this.page,
      this.pages,
      this.widget,
      this.result});
}

// Initial Pages
final PageConfiguration loginPageConfig = PageConfiguration(
    name: 'Login', path: loginPath, page: Pages.Login, currentPageAction: null);

// Bottom Navigation Pages
final PageConfiguration feedPageConfig = PageConfiguration(
    name: 'Feed', path: feedPath, page: Pages.Feed, currentPageAction: null);

final PageConfiguration homePageConfig = PageConfiguration(
    name: 'Home', path: homePath, page: Pages.Home, currentPageAction: null);

final PageConfiguration guidesPageConfig = PageConfiguration(
    name: 'Guides',
    path: guidesPath,
    page: Pages.Guides,
    currentPageAction: null);

final PageConfiguration recordPageConfig = PageConfiguration(
    name: 'Record',
    path: recordPath,
    page: Pages.Record,
    currentPageAction: null);

final PageConfiguration menuPageConfig = PageConfiguration(
    name: 'Menu', path: menuPath, page: Pages.Menu, currentPageAction: null);

// Sub Pages
final PageConfiguration recordBodyPageConfig = PageConfiguration(
    name: 'RecordBody',
    path: recordBodyPath,
    page: Pages.RecordBody,
    currentPageAction: null);

// PageConfiguration fetchRecordBodyPageConfig(String param) {
//   return PageConfiguration.param(
//       'RecordBody', recordBodyPath, Pages.RecordBody, param, null);
// }

// PageConfiguration fetchGuideCategoryPageConfig(String param) {
//   return PageConfiguration.param('GuideCategoryDetails',
//       guideCategoryDetailsPath, Pages.GuideCategoryDetails, param, null);
// }

// PageConfiguration fetchGuideArticlePageConfig(String param) {
//   return PageConfiguration.param(
//       'GuideArticle', guideArticlePath, Pages.GuideArticle, param, null);
// }
