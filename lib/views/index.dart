import 'package:flutter/material.dart';
import '../widgets/layouts/scaffold_layout.dart';
import 'home_view.dart';
import 'feed_view.dart';
import 'record_view.dart';
import 'guides_view.dart';
import 'menu_view.dart';
import '../widgets/styles/icons.dart' as icons;
import '../constants.dart' as constants;

class View {
  final Icon icon;
  final String label;
  final Widget widget;
  final BottomNavigationBarItem navItemWidget;

  View(
      {Key? key,
      required this.icon,
      required this.label,
      required this.widget,
      required this.navItemWidget});
}

class Views extends StatefulWidget {
  final List<View> views = <View>[
    View(
        icon: icons.home,
        label: constants.home,
        widget: HomeView(),
        navItemWidget:
            BottomNavigationBarItem(icon: icons.home, label: constants.home)),
    View(
        icon: icons.feed,
        label: constants.feed,
        widget: FeedView(),
        navItemWidget:
            BottomNavigationBarItem(icon: icons.feed, label: constants.feed)),
    View(
        icon: icons.record,
        label: constants.record,
        widget: RecordView(),
        navItemWidget: BottomNavigationBarItem(
            icon: icons.record, label: constants.record)),
    View(
        icon: icons.guides,
        label: constants.guides,
        widget: GuidesView(),
        navItemWidget: BottomNavigationBarItem(
            icon: icons.guides, label: constants.guides)),
    View(
        icon: icons.menu,
        label: constants.menu,
        widget: MenuView(),
        navItemWidget:
            BottomNavigationBarItem(icon: icons.menu, label: constants.menu)),
  ];

  @override
  _ViewsState createState() => _ViewsState();
}

class _ViewsState extends State<Views> {
  int _currentNavIndex = 0;
  void handleNavTap(int val) {
    setState(() {
      _currentNavIndex = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
        // appBar
        title: widget.views[_currentNavIndex].label,
        // body
        body: widget.views[_currentNavIndex].widget,
        // bottomNavigationBar
        currentNavIndex: _currentNavIndex,
        navItems: widget.views.map((view) => view.navItemWidget).toList(),
        onNavItemTap: handleNavTap);
  }
}
