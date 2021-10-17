/// Representing the hierarchy of the word card pages
abstract class WordCardRoutePath {}

class WordCardListRoutePath implements WordCardRoutePath {}

/// Representing `List -> Detail(Edit Mode)`
class WordCardEditRoutePath implements WordCardRoutePath {
  final String cardId;

  WordCardEditRoutePath({required this.cardId});
}

/// Representing `List -> New Card`
class WordCardAddRoutePath implements WordCardRoutePath {}
