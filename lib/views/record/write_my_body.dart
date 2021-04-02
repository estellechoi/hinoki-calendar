import 'package:flutter/material.dart';
import '../../widgets/form_elements/f_input.dart';
import '../../widgets/texts/input_label.dart';
import '../../widgets/form_elements/f_switch_advanced.dart';
import '../../widgets/form_elements/f_range_advanced.dart';
import '../../widgets/buttons/f_button.dart';
import '../../widgets/texts/helper_label.dart';
import '../../widgets/styles/paddings.dart' as paddings;

// EXAMPLE WIDGET
class WriteMyBody extends StatefulWidget {
  WriteMyBody({Key? key}) : super(key: key);

  @override
  _WriteMyBodyState createState() => _WriteMyBodyState();
}

class _WriteMyBodyState extends State<WriteMyBody> {
  bool _isBreath = true;
  double _appetite = 0.0;

  void _printInput(String text) {
    debugPrint(text);
  }

  void _changeRecordMethod(bool isActive) {
    setState(() {
      _isBreath = isActive;
    });
  }

  void _changedAppetite(double value) {
    setState(() {
      _appetite = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: paddings.verticalBase, horizontal: paddings.horizontalBase),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: paddings.formField),
          child: FInput(
              onChanged: _printInput, hintText: '숫자만 입력하세요', labelText: '체중'),
        ),
        Container(
          padding: EdgeInsets.only(bottom: paddings.formFieldSub),
          child: FInput(
              onChanged: _printInput, hintText: '숫자만 입력하세요', labelText: '케톤수치'),
        ),
        Container(
          padding: EdgeInsets.only(bottom: paddings.formFieldSub),
          child: FSwitchAdvanced(
              label: '케톤측정 방식은?',
              inactiveText: '혈중',
              activeText: '호흡',
              isActive: _isBreath,
              onToggle: _changeRecordMethod),
        ),
        Container(
          padding: EdgeInsets.only(bottom: paddings.formField),
          child: HelperLabel(
              text:
                  '* 소변케톤은 트랙킹 목적으로 부정확하여 지원하지 않습니다. 케톤은 아침공복은 피하고식사 전에 재시는것이 정확합니다.'),
        ),
        Container(
          padding: EdgeInsets.only(bottom: paddings.formField),
          child: FInput(
              onChanged: _printInput, hintText: '숫자만 입력하세요', labelText: '혈당수치'),
        ),
        Container(
            padding: EdgeInsets.only(bottom: paddings.formFieldLabel),
            child: Align(
                alignment: Alignment.centerLeft,
                child: InputLabel(text: '식욕'))),
        Container(
          padding: EdgeInsets.only(bottom: paddings.formField),
          child: FRangeAdvanced(
              onChanged: _changedAppetite,
              rating: _appetite,
              max: 10.0,
              divisions: 10,
              showLabel: true),
        ),
        Container(
            padding: EdgeInsets.only(bottom: paddings.formFieldLabel),
            child: Align(
                alignment: Alignment.centerLeft,
                child: InputLabel(text: '컨디션'))),
        Container(
          padding: EdgeInsets.only(bottom: paddings.formField),
          child: FRangeAdvanced(
              onChanged: _changedAppetite,
              rating: _appetite,
              max: 10.0,
              divisions: 10,
              showLabel: true),
        ),
        Container(
          padding: EdgeInsets.only(bottom: paddings.formField),
          child: FInput(
              type: 'textarea',
              onChanged: _printInput,
              hintText: '',
              labelText: '따로 섭취한 것'),
        ),
        Container(
          padding: EdgeInsets.only(bottom: paddings.formField),
          child: FInput(
              type: 'textarea',
              onChanged: _printInput,
              hintText: '',
              labelText: '메모 (변화, 특이사항 기록)'),
        ),
        Container(
            // padding: EdgeInsets.only(bottom: paddings.formField),
            child: FButton(
          // disabled: true,
          fullWidth: true,
          onPressed: () {
            debugPrint('Button Pressed !');
          },
          text: '저장',
        )),
        // MyTableCalendar()
      ]),
    );
  }
}
