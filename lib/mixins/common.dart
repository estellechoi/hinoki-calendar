import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/buttons/text_label_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import './../widgets/styles/borders.dart' as borders;
import './../widgets/styles/colors.dart' as colors;
import './../widgets/styles/fonts.dart' as fonts;

Future openDialog(
    {required BuildContext context, required Widget child}) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return child;
      });
}

Future openBottomModal(
    {required BuildContext context, required Widget child}) async {
  return showMaterialModalBottomSheet(
      context: context,
      shape: ShapeBorder.lerp(borders.modalShape, borders.modalSubShape, 0),
      builder: (context) => child);
}

Future openTitledBottomModal({
  required BuildContext context,
  required String title,
  required String backButtonLabel,
  String rightButtonLabel = '',
  bool intrinsicHeight = true,
  double explicitHeight = 0,
  required Widget child,
  required VoidCallback onCanceled,
  required VoidCallback onRightButtonClicked,
}) async {
  const double buttonWidth = 100;
  final double height = explicitHeight > 0
      ? explicitHeight
      : MediaQuery.of(context).size.height * 0.94;

  Widget contents() {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: buttonWidth,
                  alignment: Alignment.centerLeft,
                  child: TextLabelButton(
                      label: backButtonLabel,
                      onPressed: () {
                        onCanceled();
                        Navigator.pop(context);
                      }),
                ),
                Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colors.black,
                        fontSize: 18,
                        height: fonts.lineHeightBase)),
                Container(
                    width: buttonWidth,
                    alignment: Alignment.centerRight,
                    child: TextLabelButton(
                        label: rightButtonLabel,
                        onPressed: () {
                          if (rightButtonLabel.length > 0)
                            onRightButtonClicked();
                        }))
              ],
            )),
        Expanded(
            child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 26),
          decoration: BoxDecoration(border: borders.dividerTop),
          child: child,
        ))
      ],
    );
  }

  return openBottomModal(
      context: context,
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: colors.white, borderRadius: borders.radiusBottomModal),
          child: intrinsicHeight
              ? IntrinsicHeight(child: contents())
              : Container(height: height, child: contents())));
}
