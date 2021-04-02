import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/textstyles.dart' as textstyles;

class ScaffoldLayout extends StatefulWidget {
  final String title;
  final Widget body;
  // final onMenuPressed;

  final int currentNavIndex;
  final navItems;
  final onNavItemTap;

  ScaffoldLayout({
    Key? key,
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
          appBar: AppBar(title: Text(widget.title), actions: [
            // IconButton(icon: Icon(Icons.list), onPressed: widget.onMenuPressed)
          ]),
          body: SingleChildScrollView(
            child: widget.body,
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: colors.inactive,
              selectedItemColor: colors.active,
              selectedLabelStyle: textstyles.navItem,
              unselectedLabelStyle: textstyles.navItem,
              showUnselectedLabels: true,
              currentIndex: widget.currentNavIndex,
              onTap: widget.onNavItemTap,
              items: widget.navItems),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   tooltip: 'Increment',
          //   child: Icon(Icons.add),
          // ) // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
