import 'package:flutter/material.dart';
import '../widgets/layouts/scaffold_layout.dart';
import '../widgets/styles/icons.dart' as icons;
import '../constants.dart' as constants;
import '../app_state.dart';
import '../widgets/layouts/navigation_icon.dart';

class View {
  final Icon icon;
  final String label;
  final BottomNavigationBarItem navItemWidget;

  View({required this.icon, required this.label, required this.navItemWidget});
}

class NavBarFrame extends StatefulWidget {
  final List<View> views = <View>[
    View(
        icon: icons.home,
        label: constants.home,
        // page: Pages.Home,
        navItemWidget: BottomNavigationBarItem(
            icon: NavigationIcon(
              icon: icons.home,
            ),
            label: constants.home)),
    View(
        icon: icons.feed,
        label: constants.feed,
        // page: Pages.Feed,
        navItemWidget: BottomNavigationBarItem(
            icon: NavigationIcon(icon: icons.feed), label: constants.feed)),
    View(
        icon: icons.record,
        label: constants.record,
        // page: Pages.Record,
        navItemWidget: BottomNavigationBarItem(
            icon: NavigationIcon(icon: icons.record), label: constants.record)),
    View(
        icon: icons.guides,
        label: constants.guides,
        // page: Pages.Guides,
        navItemWidget: BottomNavigationBarItem(
            icon: NavigationIcon(icon: icons.guides, count: appState.unreadCnt),
            label: constants.guides)),
    View(
        icon: icons.menu,
        label: constants.menu,
        // page: Pages.Menu,
        navItemWidget: BottomNavigationBarItem(
            icon: NavigationIcon(icon: icons.menu), label: constants.menu)),
  ];

  final Widget bodyWidget;

  NavBarFrame({required this.bodyWidget});

  @override
  _NavBarFrameState createState() => _NavBarFrameState();
}

class _NavBarFrameState extends State<NavBarFrame> {
  void handleNavTap(int val) {
    if (appState.currentNavIndex == val) return;
    // url update handling should be here...
    // appState.currentNavIndex = val;
    appState.changeNavPage(val);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
        // appBar
        title: widget.views[appState.currentNavIndex].label,
        // body
        body: widget.bodyWidget,
        // bottomNavigationBar
        currentNavIndex: appState.currentNavIndex,
        navItems: widget.views.map((view) => view.navItemWidget).toList(),
        onNavItemTap: handleNavTap);
  }
}
