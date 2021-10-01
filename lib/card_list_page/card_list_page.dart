import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nihongo/constants.dart';
import 'word_card.dart';
import '../models/word.dart';

part 'card_list_state.dart';
part 'card_list_event.dart';
part 'card_list_bloc.dart';

class CardListPage extends StatelessWidget {
  const CardListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardListBloc(),
      child: ColoredBox(
        color: Colors.white,
        child: BlocBuilder<CardListBloc, CardListState>(
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

              // Add next button if there are more cards
              if (state.words.length > 1) {
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
                          .read<CardListBloc>()
                          .add(CardListNextCardRequested());
                    },
                  ),
                ));
              }
            }

            if (stackChildren.isNotEmpty) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: stackChildren,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
