import 'package:flutter/material.dart';
import 'package:nihongo/models/word.dart';

import '../constants.dart';

class WordCardAccentedText extends StatelessWidget {
  final String text;
  final Map<int, CharacterAccent> accentAtIndex;
  final double _fontSize;
  final ValueChanged<int>? onTapCharacterAtIndex;

  const WordCardAccentedText({
    required this.text,
    required this.accentAtIndex,
    double? fontSize,
    this.onTapCharacterAtIndex,
    Key? key,
  })  : _fontSize = fontSize ?? 36,
        super(key: key);

  factory WordCardAccentedText.word({
    required Word word,
    double? fontSize,
    Key? key,
  }) =>
      WordCardAccentedText(
        text: word.kana,
        accentAtIndex: word.accentAtIndex,
        fontSize: fontSize,
      );

  @override
  Widget build(BuildContext context) {
    final List<Widget> kanaWidgets = [];

    text.runes.toList().asMap().forEach((idx, rune) {
      final character = String.fromCharCode(rune);
      final accent = accentAtIndex[idx];
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
            painter: _AccentPainter(accent: accent, color: textColor),
          ),
        ));
      }

      textWidgets.add(
        Text(
          character,
          textAlign: TextAlign.center,
          style: Constants.contentTextStyle.copyWith(
            fontSize: _fontSize,
            color: textColor,
          ),
        ),
      );

      kanaWidgets.add(GestureDetector(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: textWidgets,
        ),
        onTap: () {
          onTapCharacterAtIndex?.call(idx);
        },
      ));
    });

    return Wrap(children: kanaWidgets);
  }

  //

  static Color _colorFromAccent(CharacterAccent accent) {
    switch (accent) {
      case CharacterAccent.plain:
        return Colors.black;
      case CharacterAccent.fall:
        return Colors.red;
    }
  }
}

//

class _AccentPainter extends CustomPainter {
  final CharacterAccent accent;
  final Color color;

  _AccentPainter({required this.accent, required this.color});

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
  bool shouldRepaint(_AccentPainter oldDelegate) {
    return accent != oldDelegate.accent || color != oldDelegate.color;
  }
}
