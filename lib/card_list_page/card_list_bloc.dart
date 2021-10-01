part of 'card_list_page.dart';

class CardListBloc extends Bloc<CardListEvent, CardListState> {
  CardListBloc()
      : super(const CardListState(words: [
          Word(
              kanji: "すべての人間",
              kana: "すべての人間",
              accentAtIndex: {
                1: CharacterAccent.plain,
                2: CharacterAccent.fall
              },
              meaning:
                  "The meaning The meaning The meaning The meaning The meaning The meaning "),
          Word(
              kanji: "国連総会",
              kana: "国連総会",
              accentAtIndex: {
                0: CharacterAccent.plain,
                1: CharacterAccent.plain,
                2: CharacterAccent.plain,
                3: CharacterAccent.fall
              },
              meaning:
                  "The meaning The meaning The meaning The meaning The meaning The meaning "),
          Word(
              kanji: "加盟国",
              kana: "加盟国",
              accentAtIndex: {1: CharacterAccent.fall},
              meaning:
                  "The meaning The meaning The meaning The meaning The meaning The meaning "),
        ])) {
    on<CardListUpdated>((event, emit) {
      int _cardIndex = state.cardIndex;

      // Make sure the card index is valid
      while (_cardIndex >= state.words.length) {
        _cardIndex -= state.words.length;
      }

      emit(state.copyWith(words: event.words, cardIndex: _cardIndex));
    });
    on<CardListNextCardRequested>((event, emit) {
      // int _cardIndex = state.cardIndex + 1;

      // // Make sure the card index is valid
      // while (_cardIndex >= state.words.length) {
      //   _cardIndex -= state.words.length;
      // }
      int _cardIndex = Random().nextInt(state.words.length);
      emit(state.copyWith(cardIndex: _cardIndex));
    });
  }
}
