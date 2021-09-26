import 'package:flutter/material.dart';

class FlashCardFront extends StatelessWidget {
  final String _kanji;

  const FlashCardFront({required String kanji, Key? key})
      : _kanji = kanji,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(
          _kanji,
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'Noto Sans JP', fontSize: 60),
        )),
      ),
    );
  }
}

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
          child: FlashCardFront(
            kanji: 'すべての人間は',
          ),
        ),
      )),
    );
  }
}
