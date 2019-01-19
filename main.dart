import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primaryColor: Colors.greenAccent,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords>{
  final _sug =<WordPair>[];
  final _bigFont=const TextStyle(fontSize: 23.0);
  final Set<WordPair> _saved = new Set<WordPair>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('TOT Study Jam'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSug(),
      drawer:Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Google'),

              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Gmail'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Drive'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ) ,
    );
  }

  Widget _buildSug(){
    return ListView.builder(padding: const EdgeInsets.all(15.0),itemBuilder: (context,i){
      if(i.isOdd){
        return Divider();

      }
      final index=i~/2;
      if(index>=_sug.length){
        _sug.addAll(generateWordPairs().take(10));
      }
        return _buildRow(_sug[index]);
    });
  }
  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase, style: _bigFont,
      ),
      leading:CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Text(pair.asPascalCase.substring(0,1).toString()),

      ),
      subtitle: const Text('Test subtitle'),
      trailing: new Icon(
        alreadySaved ? Icons.star :Icons.star_border,
        color: alreadySaved ? Colors.blue : null,
      ),
     onTap:() {
        setState((){
          if(alreadySaved){
            _saved.remove(pair);
    }
    else {
        _saved.add(pair);
      }
    });
     },
    );
  }
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _bigFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => new RandomWordsState();
}