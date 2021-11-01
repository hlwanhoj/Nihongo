import 'dart:async';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constants.dart';
import '../../models/word.dart';
import 'word_card.dart';
import '../word_card_data_repository.dart';

part 'word_card_list_state.dart';
part 'word_card_list_event.dart';
part 'word_card_list_bloc.dart';

class WordCardListPage extends StatelessWidget {
  final VoidCallback? onAddCard;
  final ValueChanged<Word>? onEditCard;

  const WordCardListPage({
    this.onAddCard,
    this.onEditCard,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            WordCardListBloc(context.read<WordCardDataRepository>()),
        child: WordCardListView(
          onAddCard: onAddCard,
          onEditCard: onEditCard,
        ),
      ),
    );
  }
}

//

class WordCardListView extends StatefulWidget {
  final VoidCallback? onAddCard;
  final ValueChanged<Word>? onEditCard;

  const WordCardListView({
    this.onAddCard,
    this.onEditCard,
    Key? key,
  }) : super(key: key);

  @override
  _WordCardListViewState createState() => _WordCardListViewState();
}

class _WordCardListViewState extends State<WordCardListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordCardListBloc, WordCardListState>(
      builder: (context, state) {
        final List<Widget> stackChildren = [];
        final Word? currentWord = state.currentWord;

        // Add card view if there are cards to show
        if (currentWord != null) {
          stackChildren.add(SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: WordCardView(
                  word: currentWord, key: ValueKey<Word>(currentWord)),
            ),
          ));

          // Add next button
          stackChildren.add(Positioned(
            bottom: 48,
            child: ElevatedButton(
              style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.onBackground,
                padding: const EdgeInsets.only(left: 12),
              ),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)?.wordCardListButtonNextCard?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: Constants.defaultFontFamily,
                    ),
                  ),
                  const Icon(Icons.arrow_right, size: 48),
                ],
              ),
              onPressed: () {
                context
                    .read<WordCardListBloc>()
                    .add(WordCardListNextCardRequested());
              },
            ),
          ));
        } else {
          stackChildren.add(const Center(
            child: Text(
              'No words found.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontFamily: Constants.defaultFontFamily,
              ),
            ),
          ));
        }

        // Add new card button
        stackChildren.add(Positioned(
          bottom: 12,
          right: 12,
          child: IconButton(
            icon: const Icon(Icons.add),
            iconSize: 48,
            padding: const EdgeInsets.all(0),
            splashRadius: 30,
            onPressed: widget.onAddCard,
          ),
        ));

        // Edit current card button
        stackChildren.add(Positioned(
          bottom: 12,
          left: 12,
          child: IconButton(
            icon: const Icon(Icons.edit),
            iconSize: 30,
            padding: const EdgeInsets.all(9),
            splashRadius: 30,
            onPressed: () {
              final word = state.currentWord;
              if (word != null) {
                widget.onEditCard?.call(word);
              }
            },
          ),
        ));

        return SizedBox.expand(
          child: Stack(
            alignment: AlignmentDirectional.center,
            fit: StackFit.loose,
            children: stackChildren,
          ),
        );
      },
    );
  }
}
