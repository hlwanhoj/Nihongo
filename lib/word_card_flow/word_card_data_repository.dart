import 'package:rxdart/rxdart.dart';
import '../models/word.dart';

abstract class WordCardDataProviderType {
  Future<List<Word>> getWords();
  Future<void> setWords(List<Word> words);
}

class WordCardDataRepository {
  final WordCardDataProviderType local;
  final BehaviorSubject<Map<String, Word>> _wordMap =
      BehaviorSubject.seeded({});

  WordCardDataRepository({required this.local}) {
    // Load the words initially
    local.getWords().then((words) {
      final mapped = {for (var v in words) v.id: v};
      _wordMap.add(mapped);
    });
  }

  //

  Stream<List<Word>> get words =>
      _wordMap.map((wordMap) => wordMap.values.toList());

  void updateWord(Word word) {
    final Map<String, Word> newMap = _wordMap.value;
    newMap[word.id] = word;
    _wordMap.add(newMap);
  }
}
