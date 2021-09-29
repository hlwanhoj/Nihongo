import 'package:flutter/material.dart';
import 'word_card.dart';
import '../models/word.dart';

//

class CardListPage extends StatefulWidget {
  const CardListPage({Key? key}) : super(key: key);

  @override
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Center(
          child: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: const AspectRatio(
          aspectRatio: 3 / 4,
          child: WordCardBack(
              word: Word(
                  kana: "すべての人間",
                  accentAtIndex: {
                    1: CharacterAccent.plain,
                    2: CharacterAccent.fall
                  },
                  meaning:
                      "The meaning The meaning The meaning The meaning The meaning The meaning ")),
        ),
      )),
    );
  }
}
