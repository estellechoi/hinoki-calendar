import 'package:flutter/material.dart';
import 'f_card.dart';
import '../buttons/f_button.dart';
import '../styles/borders.dart' as borders;
import '../styles/paddings.dart' as paddings;
import '../styles/icons.dart' as icons;
import '../styles/textstyles.dart' as textstyles;

class IntroCard extends StatefulWidget {
  final String type;
  final String title;
  final String summary;

  IntroCard(
      {Key? key, this.type = 'default', this.title = '', this.summary = ''})
      : super(key: key);

  @override
  _IntroCardState createState() => _IntroCardState();
}

class _IntroCardState extends State<IntroCard> {
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
    return FCard(
      type: widget.type,
      body: Row(
        children: <Widget>[
          Expanded(
              child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(widget.title, style: textstyles.introCardTitle)),
              Container(
                  padding: EdgeInsets.only(top: paddings.cardTitle),
                  alignment: Alignment.topLeft,
                  child:
                      Text(widget.summary, style: textstyles.introCardSummary)),
              Container(
                  padding: EdgeInsets.only(top: paddings.cardTitle),
                  alignment: Alignment.topLeft,
                  child: FButton(onPressed: () {}, text: '기록하기'))
            ],
          )),
          Container(
              padding: EdgeInsets.only(left: paddings.cardTitle),
              alignment: Alignment.topRight,
              child: icons.home)
        ],
      ),
    );
  }
}

// widget.summary
