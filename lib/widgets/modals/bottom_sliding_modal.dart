import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/borders.dart' as borders;
import '../styles/shadows.dart' as shadows;
import '../styles/fonts.dart' as fonts;
import '../styles/paddings.dart' as paddings;
import '../buttons/f_button.dart';

class BottomSlidingModal extends StatefulWidget {
  final String title;
  final String description;
  final String buttonLabel;
  final Widget? summaryWidget;

  BottomSlidingModal({
    required this.title,
    required this.description,
    required this.buttonLabel,
    this.summaryWidget,
  });

  @override
  _BottomSlidingModalState createState() => _BottomSlidingModalState();
}

class _BottomSlidingModalState extends State<BottomSlidingModal> {
  void pressButton() {}

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 40,
            ),
            decoration: BoxDecoration(
                // color: colors.white,
                // border: borders.primaryDeco,
                borderRadius: borders.radiusBottomModal,
                boxShadow: shadows.bottomModal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(bottom: paddings.modalLabel),
                    child: Text(widget.title,
                        style: TextStyle(
                            color: colors.modalLabel,
                            fontSize: fonts.sizeModalTitle,
                            fontWeight: fonts.weightModalTitle,
                            height: fonts.lineHeightModalTitle))),
                widget.summaryWidget != null
                    ? Container(
                        padding: EdgeInsets.only(bottom: paddings.modalLabel),
                        child: widget.summaryWidget)
                    : Container(),
                Container(
                  padding: EdgeInsets.only(bottom: paddings.modalLabel),
                  child: Text(widget.description,
                      style: TextStyle(
                          color: colors.modalDescription,
                          fontSize: fonts.sizeModalDescription,
                          fontWeight: fonts.weightModalDescription,
                          height: fonts.lineHeightModalDescription)),
                ),
                Container(
                    padding: EdgeInsets.only(top: paddings.modalLabel),
                    decoration: BoxDecoration(border: borders.dividerTop),
                    child: FButton(
                        type: 'blue',
                        text: widget.buttonLabel,
                        fullWidth: true,
                        onPressed: pressButton))
              ],
            )));
  }
}
