import 'package:json_annotation/json_annotation.dart';
part 'word.g.dart';

enum CharacterAccent { plain, fall }

@JsonSerializable()
class Word {
  final String id;
  final String kanji;
  final String kana;
  final Map<int, CharacterAccent> accentAtIndex;
  final String meaning;
  final List<String> tags;

  Word({
    required this.id,
    required this.kanji,
    required this.kana,
    required this.accentAtIndex,
    required this.meaning,
    this.tags = const [],
  });

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);
}
