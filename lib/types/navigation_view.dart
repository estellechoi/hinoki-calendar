import 'package:flutter/material.dart';

class NavigationView {
  final Icon icon;
  final String label;
  final BottomNavigationBarItem navItemWidget;

  NavigationView(
      {required this.icon, required this.label, required this.navItemWidget});
}
