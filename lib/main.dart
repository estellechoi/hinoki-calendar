import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World',
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //   primarySwatch: Colors.blue,
      // ),
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: MyHomePage(title: 'Hinoki Calendar'),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text('Dr. Meallo')
      //   ),
      //   body: Center(
      //     child: Text('Hello World')
      //   )
      // )
    );
  }
}

// TEST WIDGET
class MyTableCalendar extends StatefulWidget {
  @override
  _MyTableCalendarState createState() => _MyTableCalendarState();
}

class _MyTableCalendarState extends State<MyTableCalendar> {

  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
    );
  }
}



// EXAMPLE WIDGET
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  final _biggerFont = TextStyle(fontSize: 18.0);
  final _rowItems = [];
  final _savedSet = <String>{};

  Widget _buildList() {
    _rowItems.addAll(['Yujin', 'Yongki', 'Yubin', 'Donghyun'].cast<String>());

    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        return i < _rowItems.length ? _buildRow(_rowItems[i]) : null;
      }
    );
  }

  Widget _buildRow(String text) {
    final alreadySaved = _savedSet.contains(text);

    return ListTile(
      title: Text(text, style: _biggerFont),
      trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) _savedSet.remove(text);
          else _savedSet.add(text);
        });
      }
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context) {
              final tiles = _savedSet.map((String text) {
                return ListTile(
                    title: Text(text)
                );
              });

              final divided = ListTile.divideTiles(
                context: context,
                tiles: tiles
              ).toList();

              return Scaffold(
                appBar: AppBar(
                  title: Text('Favorites')
                ),
                body: ListView(
                  children: divided,
                )
              );
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ]
      ),
      body: _buildList(),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   // child: Column(
      //   //   // Column is also a layout widget. It takes a list of children and
      //   //   // arranges them vertically. By default, it sizes itself to fit its
      //   //   // children horizontally, and tries to be as tall as its parent.
      //   //   //
      //   //   // Invoke "debug painting" (press "p" in the console, choose the
      //   //   // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //   //   // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //   //   // to see the wireframe for each widget.
      //   //   //
      //   //   // Column has various properties to control how it sizes itself and
      //   //   // how it positions its children. Here we use mainAxisAlignment to
      //   //   // center the children vertically; the main axis here is the vertical
      //   //   // axis because Columns are vertical (the cross axis would be
      //   //   // horizontal).
      //   //   mainAxisAlignment: MainAxisAlignment.center,
      //   //   children: <Widget>[
      //   //     Text(
      //   //       'You have pushed the button this many times!',
      //   //     ),
      //   //     Text(
      //   //       '$_counter',
      //   //       style: Theme.of(context).textTheme.headline4,
      //   //     ),
      //   //   ],
      //   // ),
      //   child: MyTableCalendar()
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
