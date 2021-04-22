import 'package:flutter/material.dart';
import 'router_delegate.dart';

class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  final AppRouterDelegate _appRouterDelegate;
  AppBackButtonDispatcher(this._appRouterDelegate) : super();

  Future<bool> didPopRoute() {
    // add codes for custom back button handling
    return _appRouterDelegate.popRoute();
  }
}
