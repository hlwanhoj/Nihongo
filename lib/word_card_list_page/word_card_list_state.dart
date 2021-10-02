part of 'word_card_list_page.dart';

class WordCardListState extends Equatable {
  final List<Word> words;
  final int cardIndex;

  const WordCardListState({this.words = const [], this.cardIndex = 0});

  Word? get currentWord {
    if (words.length > cardIndex) {
      return words[cardIndex];
    }
    return null;
  }

  //

  WordCardListState copyWith({List<Word>? words, int? cardIndex}) {
    return WordCardListState(
      words: words ?? this.words,
      cardIndex: cardIndex ?? this.cardIndex,
    );
  }

  @override
  List<Object?> get props => [words, cardIndex];
}
