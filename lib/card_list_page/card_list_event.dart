part of 'card_list_page.dart';

abstract class CardListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CardListUpdated extends CardListEvent {
  final List<Word> words;

  CardListUpdated({required this.words});

  @override
  List<Object?> get props => [words];
}

class CardListNextCardRequested extends CardListEvent {}
