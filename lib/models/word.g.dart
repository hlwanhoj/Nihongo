// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      id: json['id'] as String,
      kanji: json['kanji'] as String,
      kana: json['kana'] as String,
      accentAtIndex: (json['accentAtIndex'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(int.parse(k), _$enumDecode(_$CharacterAccentEnumMap, e)),
      ),
      meaning: json['meaning'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'id': instance.id,
      'kanji': instance.kanji,
      'kana': instance.kana,
      'accentAtIndex': instance.accentAtIndex
          .map((k, e) => MapEntry(k.toString(), _$CharacterAccentEnumMap[e])),
      'meaning': instance.meaning,
      'tags': instance.tags,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$CharacterAccentEnumMap = {
  CharacterAccent.plain: 'plain',
  CharacterAccent.fall: 'fall',
};
