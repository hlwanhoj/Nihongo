import 'package:rxdart/rxdart.dart';
import '../models/word.dart';

abstract class WordCardDataProviderType {
  Future<List<Word>> getWords();
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
}
