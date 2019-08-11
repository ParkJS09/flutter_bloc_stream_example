import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutterblocexample/src/saved.dart';
import 'bloc/Bloc.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  //List
  final List<WordPair> _suggetions = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NamingApp'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder:(context)=>SavedList()));
            },
          )
        ],
      ),
      //App의 상황(상태) : context
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.savedListStream,
      builder: (context, snapshot) {
        return ListView.builder(itemBuilder: (context, index) {
          //0, 2, 4, 6, 8 ... Real Item
          //1, 3, 5, 7, 9 ... Line
          if (index.isOdd) {
            return Divider();
          }
          //~/ index를 2로 나눈 몫을 구
          var realIndex = index ~/ 2;
          //단어를 가져와 리스트에 삽
          if (realIndex >= _suggetions.length) {
            _suggetions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(snapshot.data, _suggetions[realIndex]);
        });
      }
    );
  }

  Widget _buildRow(Set<WordPair> saved, WordPair pair) {
    final bool alreadySaved = saved==null? false : saved.contains(pair);
    return ListTile(
      title: Text(
        pair.toString(),
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
        alreadySaved? Icons.favorite: Icons.favorite_border,
        color: Colors.pink,
      ),
      onTap: () {
        bloc.addOrRemoveSavedListItem(pair);
      },
    );
  }
}
