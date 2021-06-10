import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../store/app_state.dart';
import '../../widgets/layouts/scaffold_layout.dart';
import '../../widgets/spinners/hinoki_spinner.dart';
import '../../widgets/form_elements/linked_input.dart';
import '../../widgets/buttons/icon_label_button.dart';
import '../../widgets/styles/colors.dart' as colors;
import '../../widgets/styles/borders.dart' as borders;
import '../../widgets/styles/fonts.dart' as fonts;
import '../../widgets/styles/sizes.dart' as sizes;

class SearchView extends StatefulWidget {
  final String defaultText;
  final String labelText;
  final List<String> suggestions;
  final int maxSuggestions;

  const SearchView({
    Key? key,
    required this.defaultText,
    this.labelText = '',
    this.suggestions = const [],
    this.maxSuggestions = 5,
  }) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final LayerLink _layerLink = LayerLink();
  final StreamController<List<String>?> _sourceStream =
      StreamController<List<String>?>.broadcast();
  final double _itemHeight = 50;
  bool _disposed = false;
  bool _autofocus = true;
  bool _focused = true;
  bool _showCancelButton = false;
  late OverlayEntry _overlayEntry;
  bool _triggered = false;
  late String _text;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _disposed = true;
    _sourceStream.close();
    super.dispose();
  }

  void _initialize() {
    // final int count = widget.suggestions.length > widget.maxSuggestions
    //     ? widget.maxSuggestions
    //     : widget.suggestions.length;
    // _height = _itemHeight * count;
    _text = widget.defaultText;

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final List<String>? sourceList =
          widget.defaultText.isEmpty ? null : [widget.defaultText];
      _sourceStream.sink.add(sourceList);
    });
  }

  PreferredSizeWidget? _buildAppBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, sizes.appBar),
      child: AppBar(
          elevation: 1,
          backgroundColor: colors.white,
          titleSpacing: 0,
          title: Container(
            alignment: Alignment.centerLeft,
            child: LinkedInput(
                position: 'single',
                labelText: widget.labelText,
                defaultText: widget.defaultText,
                text: _text,
                focused: _focused,
                onFocused: _handleFocus,
                onChanged: _handleSourceStream),
          ),
          actions: [
            if (_showCancelButton)
              IconLabelButton(
                  iconData: Icons.cancel,
                  color: colors.lightgrey,
                  label: 'Search',
                  onPressed: _handleCancelButtonPress)
          ]),
    );
  }

  Widget _buildSuggestions() {
    return StreamBuilder<List<String>?>(
        stream: _sourceStream.stream,
        builder: (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
          if (snapshot.data == null || snapshot.data!.isEmpty || !_focused) {
            return Container(
              decoration: BoxDecoration(color: colors.white),
            );
          } else {
            return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                // height: _height,
                padding: EdgeInsets.all(0),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(color: colors.white),
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: snapshot.data!.length,
                  physics: snapshot.data!.length == 1
                      ? NeverScrollableScrollPhysics()
                      : ScrollPhysics(),
                  itemBuilder: (_focus, index) => GestureDetector(
                      onTap: () {},
                      child: Container(
                          width: double.infinity,
                          height: _itemHeight,
                          padding: EdgeInsets.symmetric(horizontal: 12) +
                              EdgeInsets.only(left: 12),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(color: colors.white),
                          child: Text(snapshot.data![index],
                              style: TextStyle(
                                  fontSize: fonts.sizeBase,
                                  color: colors.black,
                                  fontFamily: fonts.primary,
                                  fontFamilyFallback:
                                      fonts.primaryFallbacks)))),
                ));
          }
        });
  }

  OverlayEntry _createOverlay() {
    // final renderBox = context.findRenderObject() as RenderBox;
    // final size = renderBox.size;
    // final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) => StreamBuilder<List<String>?>(
            stream: _sourceStream.stream,
            builder:
                (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
              // final int count = snapshot.data != null
              //     ? snapshot.data!.length
              //     : widget.maxSuggestions;

              return CompositedTransformFollower(
                  // offset: _getYOffset(offset, count),
                  link: _layerLink,
                  child: Material(child: _buildSuggestions()));
            }));
  }

  void _handleFocus(bool hasFocus) {
    if (_disposed) return;

    setState(() {
      _focused = hasFocus;
    });

    // if (_focused) {
    //   _overlayEntry = _createOverlay();
    //   Overlay.of(context)!.insert(_overlayEntry);
    // } else {
    //   _overlayEntry.remove();
    // }
  }

  void _handleCancelButtonPress() {
    _handleFocus(false);
    _handleSourceStream('');

    setState(() {
      _text = '';
    });
  }

  void _handleSourceStream(String value) {
    if (_disposed) return;

    final matchingList = <String>[];

    if (value.isEmpty) {
      // _sourceStream.sink.add(widget.suggestions);
      _toggleShowCancelButton(false);
      if (_triggered) {
        _triggered = false;
        _overlayEntry.remove();
      }
      return;
    }

    if (value.length == 1 && !_triggered) {
      _triggered = true;
      _overlayEntry = _createOverlay();
      Overlay.of(context)!.insert(_overlayEntry);
    }

    for (final suggestion in widget.suggestions) {
      if (suggestion.toLowerCase().contains(value.toLowerCase())) {
        matchingList.add(suggestion);
      }
    }

    _sourceStream.sink.add(matchingList);
    _text = value;
    _toggleShowCancelButton(true);
  }

  void _toggleShowCancelButton(bool value) {
    setState(() {
      _showCancelButton = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
        builder: (context, appState, child) => Stack(
              children: <Widget>[
                ScaffoldLayout(
                    appBar: _buildAppBar(),
                    hideBottomNavBar: true,
                    body: CompositedTransformTarget(
                        link: _layerLink,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(color: colors.lightgrey),
                        ))),
                if (appState.isLoading) HinokiSpinner(color: colors.primary)
              ],
            ));
  }
}
