import '../models/word.dart';

/// Representing the hierarchy of the word card pages
abstract class WordCardRoutePath {}

class WordCardListRoutePath implements WordCardRoutePath {}

/// Representing `List -> Detail(Edit Mode)`
class WordCardEditRoutePath implements WordCardRoutePath {
  final Word word;

  WordCardEditRoutePath({required this.word});
}

/// Representing `List -> New Card`
class WordCardAddRoutePath implements WordCardRoutePath {}
