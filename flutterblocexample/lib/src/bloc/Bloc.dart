import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class Bloc{
  Set<WordPair> saved = Set<WordPair>();
  //StreamController는 Dispose가 필연적이다 -> 11번 dispose() method -> 메모리릭때문에 진
  //여러개의 snapshot이 필요한 경우 broadcast 실행
  final _savedController = StreamController<Set<WordPair>>.broadcast();

  dispose(){
    _savedController.close();
  }

  //읽기전용
//  Stream<Set<WordPair>> getSavedListStream(){
//    return _savedController.stream;
//  }
  get savedListStream => _savedController.stream;
  get addCurrentSaved => _savedController.sink.add(saved);

  addOrRemoveSavedListItem(WordPair items){
    if(saved.contains(items)){
      saved.remove(items);
    }else{
      saved.add(items);
    }
    //Controllr에 변경된 데이터를 알려줌
    _savedController.sink.add(saved);
  }
}



var bloc = Bloc();