part of 'word_card_list_page.dart';

abstract class WordCardListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class WordCardListUpdated extends WordCardListEvent {
  final List<Word> words;

  WordCardListUpdated({required this.words});

  @override
  List<Object?> get props => [words];
}

class WordCardListNextCardRequested extends WordCardListEvent {}
