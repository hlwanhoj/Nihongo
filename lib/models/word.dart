import 'package:uuid/uuid.dart';

enum CharacterAccent { plain, fall }

class Word {
  final String id;
  final String kanji;
  final String kana;
  final Map<int, CharacterAccent> accentAtIndex;
  final String meaning;
  final List<String> tags;

  Word({
    String? identifier,
    required this.kanji,
    required this.kana,
    required this.accentAtIndex,
    required this.meaning,
    this.tags = const [],
  }) : id = identifier ?? const Uuid().v4();
}
