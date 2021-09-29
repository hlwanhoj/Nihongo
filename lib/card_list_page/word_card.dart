import 'package:flutter/material.dart';
import '../models/word.dart';

/// The front face of a word card
class WordCardFront extends StatelessWidget {
  final String _kanji;

  const WordCardFront({required String kanji, Key? key})
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

/// The back face of a word card
class WordCardBack extends StatelessWidget {
  final Word _word;

  const WordCardBack({required Word word, Key? key})
      : _word = word,
        super(key: key);

  //

  static Color _colorFromAccent(CharacterAccent accent) {
    switch (accent) {
      case CharacterAccent.plain:
        return Colors.black;
      case CharacterAccent.fall:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> kanaWidgets = [];

    _word.kana.runes.toList().asMap().forEach((idx, rune) {
      final character = String.fromCharCode(rune);
      final accent = _word.accentAtIndex[idx];
      Color textColor = Colors.black;
      final List<Widget> textWidgets = [];

      if (accent != null) {
        textColor = _colorFromAccent(accent);
        textWidgets.add(Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: 20,
            child: CustomPaint(
              painter: AccentPainter(accent: accent, color: textColor),
            )));
      }

      textWidgets.add(
        Text(
          character,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Noto Sans JP', fontSize: 24, color: textColor),
        ),
      );

      kanaWidgets.add(SizedBox(
          height: 40,
          child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: textWidgets)));
    });

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
              Wrap(children: kanaWidgets),
              const SizedBox(height: 12),
              Text(
                _word.meaning,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontFamily: 'Noto Sans JP', fontSize: 24),
              ),
            ],
          )),
        ));
  }
}

//

class AccentPainter extends CustomPainter {
  final CharacterAccent accent;
  final Color color;

  AccentPainter({required this.accent, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    switch (accent) {
      case CharacterAccent.plain:
        canvas.drawRect(Rect.fromLTWH(0, 0, size.width, 2), paint1);
        break;
      case CharacterAccent.fall:
        canvas.drawRect(Rect.fromLTWH(0, 0, size.width, 2), paint1);
        canvas.drawRect(Rect.fromLTWH(size.width - 2, 0, 2, 10), paint1);
        break;
    }
  }

  @override
  bool shouldRepaint(AccentPainter oldDelegate) {
    return accent != oldDelegate.accent || color != oldDelegate.color;
  }
}
