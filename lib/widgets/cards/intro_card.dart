import 'package:flutter/material.dart';
import 'f_card.dart';
import '../buttons/f_button.dart';
import '../styles/borders.dart' as borders;
import '../styles/paddings.dart' as paddings;
import '../styles/sizes.dart' as sizes;
import '../styles/colors.dart' as colors;
import '../styles/textstyles.dart' as textstyles;

class IntroCard extends StatefulWidget {
  final String type;
  final String title;
  final String summary;
  final String buttonType;
  final String emojiText;

  IntroCard(
      {Key? key,
      this.type = 'default',
      this.title = '',
      this.summary = '',
      this.buttonType = 'primary',
      this.emojiText = '✏️'})
      : super(key: key);

  @override
  _IntroCardState createState() => _IntroCardState();
}

class _IntroCardState extends State<IntroCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Border _border = borders.none;
    Color _color = colors.primaryHigh;

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

    switch (widget.buttonType) {
      case 'primary':
        _color = colors.primaryHigh;
        break;
      case 'blue':
        _color = colors.blueLight;
        break;
      case 'fountainBlue':
        _color = colors.fountainBlueHigh;
        break;
      default:
        _color = colors.primaryHigh;
    }

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
                  child: FButton(
                      onPressed: () {}, text: '기록하기', type: widget.buttonType))
            ],
          )),
          Container(
              padding: EdgeInsets.only(left: paddings.cardTitle),
              alignment: Alignment.topRight,
              child: Container(
                  width: sizes.emojiBox,
                  height: sizes.emojiBox,
                  decoration: BoxDecoration(
                      color: _color, borderRadius: borders.radiusCircle),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(widget.emojiText,
                          style: TextStyle(fontSize: 25.0)))))
        ],
      ),
    );
  }
}

// widget.summary
