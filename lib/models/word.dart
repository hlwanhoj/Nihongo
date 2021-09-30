enum CharacterAccent { plain, fall }

class Word {
  final String kanji;
  final String kana;
  final Map<int, CharacterAccent> accentAtIndex;
  final String meaning;
  final List<String> tags;

  const Word(
      {required this.kanji,
      required this.kana,
      required this.accentAtIndex,
      required this.meaning,
      this.tags = const []});
}
