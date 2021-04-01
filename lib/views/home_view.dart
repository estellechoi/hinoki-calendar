import 'package:flutter/material.dart';
import '../widgets/calendars/table_calendar.dart';
import '../widgets/form_elements/f_input.dart';

// EXAMPLE WIDGET
class Home extends StatefulWidget {
  final String title;
  final onTabbed;

  Home({Key? key, required this.title, required this.onTabbed})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _todo;

  void _selectDate() {
    widget.onTabbed('2021-05-05');
  }

  void _printInput(text) {
    // print('_printInput : ${text}');
    setState(() {
      _todo = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [
        IconButton(icon: Icon(Icons.list), onPressed: _selectDate)
      ]),
      // body: _buildList(),
      body: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 470.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FInput(
                    onChanged: _printInput,
                    hintText: '숫자만 입력하세요',
                    labelText: '체중'),
                MyTableCalendar()
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
