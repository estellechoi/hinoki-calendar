import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/sizes.dart' as sizes;

class AppBarLayout extends StatefulWidget {
  final String title;
  final Widget body;
  final bool extendBodyBehindAppBar;
  final String appBarColor;
  final GlobalKey globalKey;
  final ScrollController scrollController;

  AppBarLayout(
      {Key? key,
      required this.title,
      required this.body,
      this.extendBodyBehindAppBar = false,
      this.appBarColor = 'white',
      required this.scrollController,
      required this.globalKey})
      : super(key: key);

  @override
  _AppBarLayoutState createState() => _AppBarLayoutState();
}

class _AppBarLayoutState extends State<AppBarLayout> {
  @override
  Widget build(BuildContext context) {
    Color appBarBackgroundColor = colors.white;
    Color iconColor = colors.black;

    switch (widget.appBarColor) {
      case 'white':
        appBarBackgroundColor = colors.white;
        iconColor = colors.black;
        break;
      case 'transparent':
        appBarBackgroundColor = colors.transparent;
        iconColor = colors.white;
        break;
    }

    return GestureDetector(
        onTap: () {
          WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: widget.globalKey,
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
          appBar: PreferredSize(
              preferredSize: Size(double.infinity, sizes.appBar),
              child: AppBar(
                  title: Text(widget.title),
                  backgroundColor: appBarBackgroundColor,
                  iconTheme: IconThemeData(
                    color: iconColor, //change your color here
                  ),
                  elevation: 0,
                  actions: [])),
          body: SingleChildScrollView(
              child: widget.body, controller: widget.scrollController),
        ));
  }
}
