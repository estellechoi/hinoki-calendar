import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../types/navigation_view.dart';
import '../styles/colors.dart' as colors;
import '../styles/textstyles.dart' as textstyles;
import '../styles/sizes.dart' as sizes;
import '../styles/paddings.dart' as paddings;

import '../../store/route_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../constants.dart' as constants;
import '../../store/app_state.dart';

class ScaffoldLayout extends StatefulWidget {
  final bool hideAppBar;
  final String title;
  final Widget body;
  final bool refreshable;
  final AsyncCallback? onRefresh;

  // final onMenuPressed;

  final int currentNavIndex;

  ScaffoldLayout({
    Key? key,
    this.hideAppBar = false,
    required this.title,
    required this.body,
    this.refreshable = false,
    this.onRefresh,
    this.currentNavIndex = 0,
  }) : super(key: key);

  @override
  _ScaffoldLayoutState createState() => _ScaffoldLayoutState();
}

class _ScaffoldLayoutState extends State<ScaffoldLayout> {
  final List<NavigationView> views = constants.views;

  void _handleNavTap(AppState appState, int val) {
    print('Nav Bar Item Tap Detected');
    print(val);
    print(appState.currentNavIndex);

    if (appState.currentNavIndex != val) {
      appState.changeNavPage(val);
    }

    // url update handling should be here...
  }

  Future<void> _handleRefresh() async {
    // ..
  }

  @override
  Widget build(BuildContext context) {
    // final User? firebaseUser = context.watch<User>();

    // if (firebaseUser == null) {
    //   routeState.redirectLoginPage();
    // }
    final double appBarHeight = widget.hideAppBar ? 0 : sizes.appBar;

    return GestureDetector(
        onTap: () {
          WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
          // FocusScopeNode focusScopeNode = FocusScope.of(context);
          // if (focusScopeNode.hasPrimaryFocus &&
          //     focusScopeNode.focusedChild != null) {
          //   focusScopeNode.focusedChild?.unfocus();
          // }
        },
        child: Consumer<AppState>(
            builder: (context, appState, child) => Scaffold(
                resizeToAvoidBottomInset: false,
                extendBodyBehindAppBar: widget.hideAppBar,
                appBar: PreferredSize(
                  preferredSize: Size(double.infinity, sizes.appBar),
                  child: AppBar(
                      elevation: 0,
                      backgroundColor:
                          widget.hideAppBar ? colors.transparent : colors.white,
                      toolbarOpacity: widget.hideAppBar ? 0 : 1,
                      title: Text(appBarLabel(appState.currentNavIndex)),
                      actions: [
                        // IconButton(icon: Icon(Icons.list), onPressed: widget.onMenuPressed)
                      ]),
                ),
                body: SingleChildScrollView(
                  child: widget.refreshable
                      ? RefreshIndicator(
                          color: colors.helperLabel,
                          backgroundColor: colors.white,
                          strokeWidth: 1.0,
                          onRefresh: widget.onRefresh ?? _handleRefresh,
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  appBarHeight -
                                  sizes.bottomNavigationBar -
                                  paddings.verticalBase,
                              child: ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: <Widget>[
                                  widget.body,
                                ],
                              )),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height -
                              appBarHeight -
                              sizes.bottomNavigationBar,
                          child: widget.body),
                ),
                bottomNavigationBar: SizedBox(
                  height: sizes.bottomNavigationBar,
                  child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: colors.white,
                      unselectedItemColor: colors.inactive,
                      selectedItemColor: colors.primary,
                      selectedLabelStyle: textstyles.navItem,
                      unselectedLabelStyle: textstyles.navItem,
                      showUnselectedLabels: true,
                      currentIndex: widget.currentNavIndex,
                      onTap: (int index) {
                        _handleNavTap(appState, index);
                      },
                      items: views.map((view) => view.navItemWidget).toList()),
                ))));
  }

  String appBarLabel(int index) {
    return widget.title.length > 0 ? widget.title : views[index].label;
  }
}
