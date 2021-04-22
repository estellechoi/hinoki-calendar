import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/borders.dart' as borders;
import '../styles/shadows.dart' as shadows;
import '../styles/fonts.dart' as fonts;
import '../styles/paddings.dart' as paddings;
import 'bottom_sliding_modal.dart';

class GuideNotify extends StatefulWidget {
  final String title;
  final String description;
  final String buttonLabel;
  final bool showRecommendation;
  final String recommendTitle;
  final String recommendImagePath;
  final bool showSummary;
  final String summary;

  GuideNotify(
      {required this.title,
      required this.description,
      required this.buttonLabel,
      required this.showRecommendation,
      this.recommendTitle = '',
      this.recommendImagePath = '',
      required this.showSummary,
      this.summary = ''});

  @override
  _GuideNotifyState createState() => _GuideNotifyState();
}

class _GuideNotifyState extends State<GuideNotify> {
  @override
  Widget build(BuildContext context) {
    return BottomSlidingModal(
        title: widget.title,
        description: widget.description,
        buttonLabel: widget.buttonLabel,
        summaryWidget: widget.showRecommendation
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      // clipBehavior: Clip.hardEdge,
                      width: 90,
                      height: 90,
                      child: Image.network(widget.recommendImagePath)),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(left: 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(widget.recommendTitle,
                                style: TextStyle(
                                    color: colors.modalLabel,
                                    fontSize: fonts.sizeModalImageLabel,
                                    fontWeight: fonts.weightModalImageLabel,
                                    height: fonts.lineHeightModalImageLabel)),
                          ))),
                ],
              )
            : widget.showSummary
                ? Container(
                    child: Text(widget.summary,
                        style: TextStyle(
                            color: colors.modalLabel,
                            fontSize: fonts.sizeModalSummary,
                            fontWeight: fonts.weightModalSummary,
                            height: fonts.lineHeightModalSummary)))
                : Container());
  }
}
