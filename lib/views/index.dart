import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/spinners/hinoki_spinner.dart';
import '../widgets/layouts/scaffold_layout.dart';
import '../widgets/styles/icons.dart' as icons;
import '../widgets/styles/colors.dart' as colors;
import '../widgets/styles/sizes.dart' as sizes;
import '../widgets/styles/paddings.dart' as paddings;

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

  final bool hideAppBar;
  final String appBarLabel;
  final Widget bodyWidget;
  final bool refreshable;
  final onRefresh;

  NavBarFrame(
      {this.hideAppBar = false,
      this.appBarLabel = '',
      required this.bodyWidget,
      this.refreshable = false,
      this.onRefresh});

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
  Widget build(
    BuildContext context,
  ) {
    double appBarHeight = widget.hideAppBar ? 0 : sizes.appBar;

    return Stack(
      children: <Widget>[
        ScaffoldLayout(
            // appBar
            hideAppBar: widget.hideAppBar,
            title: widget.appBarLabel.length > 0
                ? widget.appBarLabel
                : widget.views[appState.currentNavIndex].label,
            // body
            body: widget.refreshable
                ? RefreshIndicator(
                    color: colors.helperLabel,
                    backgroundColor: colors.white,
                    strokeWidth: 1.0,
                    onRefresh: widget.onRefresh,
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height -
                            appBarHeight -
                            sizes.bottomNavigationBar -
                            paddings.verticalBase,
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: <Widget>[
                            widget.bodyWidget,
                          ],
                        )),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height -
                        appBarHeight -
                        sizes.bottomNavigationBar,
                    child: widget.bodyWidget),
            // bottomNavigationBar
            currentNavIndex: appState.currentNavIndex,
            navItems: widget.views.map((view) => view.navItemWidget).toList(),
            onNavItemTap: handleNavTap),
        appState.isLoading ? HinokiSpinner(color: colors.primary) : Container()
      ],
    );
  }
}
