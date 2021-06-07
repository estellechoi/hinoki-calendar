import 'package:flutter/material.dart';
import '../widgets/layouts/scaffold_layout.dart';

class FeedView extends StatefulWidget {
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
        title: 'Review', refreshable: false, body: Container());
  }
}
