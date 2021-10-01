part of 'card_list_page.dart';

class CardListState extends Equatable {
  final List<Word> words;
  final int cardIndex;

  const CardListState({this.words = const [], this.cardIndex = 0});

  Word? get currentWord {
    if (words.length > cardIndex) {
      return words[cardIndex];
    }
    return null;
  }

  //

  CardListState copyWith({List<Word>? words, int? cardIndex}) {
    return CardListState(
      words: words ?? this.words,
      cardIndex: cardIndex ?? this.cardIndex,
    );
  }

  @override
  List<Object?> get props => [words, cardIndex];
}
