import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nihongo/constants.dart';
import 'word_card.dart';
import '../models/word.dart';

part 'word_card_list_state.dart';
part 'word_card_list_event.dart';
part 'word_card_list_bloc.dart';

class WordCardListPage extends StatelessWidget {
  const WordCardListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => WordCardListBloc(),
        child: const WordCardListView(),
      ),
    );
  }
}

//

class WordCardListView extends StatefulWidget {
  const WordCardListView({Key? key}) : super(key: key);

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
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.only(left: 12)),
              ),
              child: Row(
                children: const [
                  Text(
                    "Next Card",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: Constants.defaultFontFamily,
                    ),
                  ),
                  Icon(Icons.arrow_right, size: 48),
                ],
              ),
              onPressed: () {
                context
                    .read<WordCardListBloc>()
                    .add(WordCardListNextCardRequested());
              },
            ),
          ));
        }

        if (stackChildren.isNotEmpty) {
          return SizedBox.expand(
            child: Stack(
              alignment: AlignmentDirectional.center,
              fit: StackFit.loose,
              children: stackChildren,
            ),
          );
        } else {
          return const Center(
            child: Text(
              'No words found.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontFamily: Constants.defaultFontFamily,
              ),
            ),
          );
        }
      },
    );
  }
}
