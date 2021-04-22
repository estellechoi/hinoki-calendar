import 'package:flutter/material.dart';
import '../styles/borders.dart' as borders;
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;

class NavigationIcon extends StatefulWidget {
  final Widget icon;
  final int count;

  NavigationIcon({required this.icon, this.count = 0});

  @override
  _NavigationIconState createState() => _NavigationIconState();
}

class _NavigationIconState extends State<NavigationIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            width: 36,
            padding: EdgeInsets.only(top: 2),
            child: Align(child: widget.icon)),
        Positioned(
          top: 0,
          right: 0,
          child: widget.count > 0
              ? Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: colors.countBadge,
                      borderRadius: borders.radiusCircle),
                  constraints: BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: Text(
                    widget.count.toString(),
                    style: TextStyle(
                        color: colors.white,
                        fontSize: fonts.sizeCountBadge,
                        fontWeight: fonts.weightCountBadge),
                    textAlign: TextAlign.center,
                  ))
              : Container(),
        )
      ],
    );
  }
}
