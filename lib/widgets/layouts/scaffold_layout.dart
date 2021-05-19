import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/textstyles.dart' as textstyles;
import '../styles/sizes.dart' as sizes;
import './../../app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class ScaffoldLayout extends StatefulWidget {
  final bool hideAppBar;
  final String title;
  final Widget body;
  // final onMenuPressed;

  final int currentNavIndex;
  final navItems;
  final onNavItemTap;

  ScaffoldLayout({
    Key? key,
    this.hideAppBar = false,
    required this.title,
    required this.body,
    this.currentNavIndex = 0,
    required this.navItems,
    required this.onNavItemTap,
    // required this.onMenuPressed,
  }) : super(key: key);

  @override
  _ScaffoldLayoutState createState() => _ScaffoldLayoutState();
}

class _ScaffoldLayoutState extends State<ScaffoldLayout> {
  // int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final User? firebaseUser = context.watch<User>();

    if (firebaseUser == null) {
      appState.redirectLoginPage();
    }

    return GestureDetector(
        onTap: () {
          WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
          // FocusScopeNode focusScopeNode = FocusScope.of(context);
          // if (focusScopeNode.hasPrimaryFocus &&
          //     focusScopeNode.focusedChild != null) {
          //   focusScopeNode.focusedChild?.unfocus();
          // }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: widget.hideAppBar,
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, sizes.appBar),
            child: AppBar(
                elevation: 0,
                backgroundColor:
                    widget.hideAppBar ? colors.transparent : colors.white,
                toolbarOpacity: widget.hideAppBar ? 0 : 1,
                title: Text(widget.title),
                actions: [
                  // IconButton(icon: Icon(Icons.list), onPressed: widget.onMenuPressed)
                ]),
          ),
          body: SingleChildScrollView(
            child: widget.body,
          ),
          bottomNavigationBar: SizedBox(
            height: sizes.bottomNavigationBar,
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: colors.inactive,
                selectedItemColor: colors.active,
                selectedLabelStyle: textstyles.navItem,
                unselectedLabelStyle: textstyles.navItem,
                showUnselectedLabels: true,
                currentIndex: widget.currentNavIndex,
                onTap: widget.onNavItemTap,
                items: widget.navItems),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   tooltip: 'Increment',
          //   child: Icon(Icons.add),
          // ) // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
