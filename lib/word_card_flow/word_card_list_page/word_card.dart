import 'package:flutter/material.dart';
import '../../common_ui/word_card_accented_text.dart';
import '../../constants.dart';
import '../../models/word.dart';

/// The front face of a word card
class WordCardFrontView extends StatelessWidget {
  final String _kanji;

  const WordCardFrontView({required String kanji, Key? key})
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
            style: const TextStyle(
              fontFamily: Constants.defaultFontFamily,
              fontSize: 60,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

/// The back face of a word card
class WordCardBackView extends StatelessWidget {
  final Word _word;

  const WordCardBackView({required Word word, Key? key})
      : _word = word,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              WordCardAccentedText.word(word: _word),
              const SizedBox(height: 12),
              Text(
                _word.meaning,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: Constants.defaultFontFamily,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//

class WordCardView extends StatefulWidget {
  final Word word;

  const WordCardView({required this.word, Key? key}) : super(key: key);

  @override
  _WordCardViewState createState() => _WordCardViewState();
}

class _WordCardViewState extends State<WordCardView> {
  bool _isShowingFront = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: (_isShowingFront ? WordCardFrontView(kanji: widget.word.kanji) : WordCardBackView(word: widget.word)),
      onTap: () {
        setState(() {
          _isShowingFront = !_isShowingFront;
        });
      },
    );
  }
}
