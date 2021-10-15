import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import '../models/word.dart';

abstract class WordCardDataProviderType {
  Future<List<Word>> getWords();
  Future<void> setWords(List<Word> words);
}

class WordCardDataRepository {
  final WordCardDataProviderType local;
  final BehaviorSubject<Map<String, Word>> _wordMap =
      BehaviorSubject.seeded({});

  Stream<List<Word>> get words =>
      _wordMap.map((wordMap) => wordMap.values.toList());

  WordCardDataRepository({required this.local}) {    
    // Load the words initially
    local.getWords().then((words) {
      final mapped = {for (var v in words) v.id: v};
      _wordMap.add(mapped);
    });
  }

  void _test() {
    final List<Word> words = [
      Word(
        id: const Uuid().v4(),
        kanji: "すべての人間",
        kana: "すべての人間",
        accentAtIndex: {1: CharacterAccent.plain, 2: CharacterAccent.fall},
        meaning:
            "The meaning The meaning The meaning The meaning The meaning The meaning ",
      ),
      Word(
        id: const Uuid().v4(),
        kanji: "国連総会",
        kana: "国連総会",
        accentAtIndex: {
          0: CharacterAccent.plain,
          1: CharacterAccent.plain,
          2: CharacterAccent.plain,
          3: CharacterAccent.fall
        },
        meaning:
            "The meaning The meaning The meaning The meaning The meaning The meaning ",
      ),
      Word(
        id: const Uuid().v4(),
        kanji: "加盟国",
        kana: "加盟国",
        accentAtIndex: {1: CharacterAccent.fall},
        meaning:
            "The meaning The meaning The meaning The meaning The meaning The meaning ",
      ),
    ];
    local.setWords(words).then((_) {
      return local.getWords();
    }).then((value) {
      print('get set words flow completed');
    }).catchError((e, trace) {
      print(e);
      print(trace);
    });
  }
}
