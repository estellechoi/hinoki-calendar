import 'package:flutter/material.dart';

class FInput extends StatelessWidget {
  final onChanged;
  final String hintText;
  final String labelText;
  final flController = TextEditingController();
  // flController.addListener(_printInput);

  FInput(
      {Key? key,
      required this.onChanged,
      required this.hintText,
      this.labelText = ''})
      : super(key: key);

  // _printInput() {
  //   print('_printInput by Controller : ${flController.text}');
  // }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // Label
      Container(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(labelText,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.25,
                          color: Color(0xff252729))))
            ],
          )),
      // Input
      Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          decoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border.all(
                  width: 1.0,
                  style: BorderStyle.solid,
                  color: Color(0xfffe4e6e8)),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              boxShadow: [
                BoxShadow(
                    color: Color(0xff000000).withOpacity(0.04),
                    blurRadius: 25,
                    spreadRadius: 0,
                    offset: Offset(0, 5)),
                BoxShadow(
                    color: Color(0xff000000).withOpacity(0.08),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: Offset(0, 0))
              ]),
          child: Row(children: <Widget>[
            Expanded(
                child: TextFormField(
              controller: flController,
              style: TextStyle(
                  fontSize: 16.0, height: 1.625, color: Color(0xff252729)),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                isDense: true,
                border: InputBorder.none,
                hintText: hintText,
              ),
            ))
          ]))
    ]);
  }
}
