import 'package:flutter/material.dart';
import '../styles/borders.dart' as borders;
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;
import '../styles/paddings.dart' as paddings;

class SectionCard extends StatefulWidget {
  final String title;
  final String summary;
  final String imagePath;
  final bool isLock;
  final bool isRead;
  final bool showLabel;

  SectionCard(
      {required this.title,
      required this.summary,
      required this.imagePath,
      required this.isLock,
      required this.isRead,
      this.showLabel = true});

  @override
  _SectionCardState createState() => _SectionCardState();
}

class _SectionCardState extends State<SectionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: borders.radiusLight),
          constraints: BoxConstraints(
              minWidth: double.infinity, minHeight: double.infinity),
          child: Image.network(widget.imagePath, fit: BoxFit.cover)),
      widget.showLabel
          ? Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: colors.blackAlpha, borderRadius: borders.radiusLight),
              constraints: BoxConstraints(
                  minWidth: double.infinity, minHeight: double.infinity),
            )
          : Container(),
      widget.showLabel
          ? Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                  padding: EdgeInsets.only(
                    left: paddings.cardSlider,
                    bottom: paddings.cardSlider,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: TextStyle(
                            color: colors.white,
                            fontSize: fonts.sizeCardSliderTitle,
                            fontWeight: fonts.weightBase,
                            height: fonts.lineHeightBase),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.summary,
                        style: TextStyle(
                            color: colors.white,
                            fontSize: fonts.sizeCardSliderSummary),
                      ),
                    ],
                  )))
          : Container(),
      widget.isRead
          ? Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                  padding: EdgeInsets.only(
                    right: paddings.cardCheckIconPosition,
                    bottom: paddings.cardCheckIconPosition,
                  ),
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            color: colors.cardTitle,
                            borderRadius: borders.radiusCircle),
                        child: Icon(Icons.check, color: colors.white, size: 16))
                  ])))
          : Container(),
      widget.isLock
          ? Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: colors.blackAlphaDeep,
                  borderRadius: borders.radiusLight),
              constraints: BoxConstraints(
                  minWidth: double.infinity, minHeight: double.infinity),
              child: Icon(Icons.lock, color: colors.whiteAlphaDeep, size: 52))
          : Container()
    ]));
  }
}

class CardItem {
  final String title;
  final String summary;
  final String imagePath;

  CardItem({
    required this.title,
    required this.summary,
    required this.imagePath,
  });
}
