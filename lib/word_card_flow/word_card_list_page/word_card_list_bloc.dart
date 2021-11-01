part of 'word_card_list_page.dart';

class WordCardListBloc extends Bloc<WordCardListEvent, WordCardListState> {
  final WordCardDataRepository repository;
  late final StreamSubscription<List<Word>> _wordsSubscription;

  WordCardListBloc(this.repository)
      : super(const WordCardListState(words: [])) {
    on<WordCardListUpdated>((event, emit) {
      int _cardIndex = state.cardIndex;

      // Make sure the card index is valid
      if (event.words.isNotEmpty) {
        while (_cardIndex >= event.words.length) {
          _cardIndex -= event.words.length;
        }
      }

      emit(state.copyWith(words: event.words, cardIndex: _cardIndex));
    });
    on<WordCardListNextCardRequested>((event, emit) {
      // int _cardIndex = state.cardIndex + 1;

      // // Make sure the card index is valid
      // while (_cardIndex >= state.words.length) {
      //   _cardIndex -= state.words.length;
      // }
      int _cardIndex = Random().nextInt(state.words.length);
      emit(state.copyWith(cardIndex: _cardIndex));
    });

    _wordsSubscription = repository.words.listen((words) {
      add(WordCardListUpdated(words: words));
    });
  }

  @override
  Future<void> close() {
    _wordsSubscription.cancel();
    return super.close();
  }
}
