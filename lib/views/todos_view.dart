import 'package:flutter/material.dart';

// Type
class Todo {
  final String title;
  final String isDone;

  Todo(this.title, this.isDone);
}

// Stateful
class Todos extends StatefulWidget {
  final String? title;
  final List<Todo> todos = [
    Todo('Meet up', 'false'),
    Todo('Interview', 'false'),
    Todo('Vacay', 'false')
  ];

  Todos({Key? key, required this.title }) : super(key: key);

  @override
  _TodosState createState() => _TodosState();
}

// State
class _TodosState extends State<Todos> {

  final _biggerFont = TextStyle(fontSize: 18.0);
  final _rowItems = <Todo>[];
  final _savedSet = <String>{};

  Widget _buildList() {
    _rowItems.addAll(widget.todos);

    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return i < _rowItems.length ? _buildRow(_rowItems[i]) : _buildRow(Todo('', ''));
        }
    );
  }

  Widget _buildRow(Todo todo) {
    final alreadySaved = _savedSet.contains(todo.title);

    return ListTile(
        title: Text(todo.title, style: _biggerFont),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) _savedSet.remove(todo.title);
            else _savedSet.add(todo.title);
          });
        }
    );
  }

  void _pushSaved() {
    Navigator.pushNamed(
      context,
      '/home'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title!),
          actions: [
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
          ]
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
