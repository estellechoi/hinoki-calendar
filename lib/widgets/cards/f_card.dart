import 'package:flutter/material.dart';
import '../styles/paddings.dart' as paddings;
import '../styles/colors.dart' as colors;
import '../styles/borders.dart' as borders;
import '../styles/shadows.dart' as shadows;
import '../styles/textstyles.dart' as textstyles;

class FCard extends StatefulWidget {
  final String type;
  final String title;
  final Widget body;

  FCard({Key? key, this.type = 'default', this.title = '', required this.body})
      : super(key: key);

  @override
  _FCardState createState() => _FCardState();
}

class _FCardState extends State<FCard> {
  Border _border = borders.none;

  @override
  void initState() {
    super.initState();

    switch (widget.type) {
      case 'default':
        _border = borders.none;
        break;
      case 'border':
        _border = borders.primaryDeco;
        break;
      default:
        _border = borders.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: paddings.verticalCard,
            horizontal: paddings.horizontalCard),
        decoration: BoxDecoration(
            color: colors.white,
            border: _border,
            borderRadius: borders.radiusBase,
            boxShadow: shadows.card),
        child: Column(
          children: _children,
        ));
  }

  List<Widget> get _children {
    if (widget.title.length > 0) {
      return <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: paddings.cardTitle),
          alignment: Alignment.centerLeft,
          child: Text(widget.title, style: textstyles.cardTitle),
        ),
        widget.body
      ];
    }

    return <Widget>[widget.body];
  }
}
