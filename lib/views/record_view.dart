import 'package:flutter/material.dart';
import 'record/write_my_body.dart';

class RecordView extends StatefulWidget {
  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  @override
  Widget build(BuildContext context) {
    return WriteMyBody();
  }
}
