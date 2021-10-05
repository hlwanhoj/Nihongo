import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:collection/collection.dart';
import '../utility.dart';
import '../models/word.dart';
import '../word_card_list_page/word_card_data_repository.dart';

class FileStore implements WordCardDataProviderType {
  static final FileStore shared = FileStore();

  // WordCardDataProviderType

  Future<File> _getWordsFile() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/words.json');
  }

  @override
  Future<List<Word>> getWords() async {
    final File file = await _getWordsFile();
    final wordsJSON = await file.readAsString();

    var words = Utility.cast<List<Map<String, dynamic>>>(jsonDecode(wordsJSON));
    if (words != null) {
      var converted =
          words.map((e) => _JSON.createWordfromJson(e)).whereNotNull();
      return converted.toList();
    } else {
      return [];
    }
  }

  // Future<Map<String, Word>> _getWords() async {
  //   final File file = await _getWordsFile();
  //   final wordsJSON = await file.readAsString();

  //   var words = Utility.cast<List<Map<String, dynamic>>>(jsonDecode(wordsJSON));
  //   if (words != null) {
  //     var converted =
  //         words.map((e) => _JSON.createWordfromJson(e)).whereNotNull();
  //     var mapped = {for (var v in converted) v.id: v};
  //     return mapped;
  //   } else {
  //     return {};
  //   }
  // }
}

extension _JSON on Word {
  static Word? createWordfromJson(Map<String, dynamic> json) {
    final String? id = Utility.cast<String>(json['id']);
    if (id != null) {
      final _accentAtIndex =
          Utility.cast<Map<int, String>>(json['accentAtIndex']) ?? {};

      return Word(
        identifier: id,
        kanji: Utility.cast<String>(json['kanji']) ?? '',
        kana: Utility.cast<String>(json['kana']) ?? '',
        accentAtIndex:
            _accentAtIndex.map<int, CharacterAccent>((key, accentStr) {
          CharacterAccent accent = CharacterAccent.plain;
          if (accentStr == 'fall') {
            accent = CharacterAccent.fall;
          }
          return MapEntry<int, CharacterAccent>(key, accent);
        }),
        meaning: Utility.cast<String>(json['meaning']) ?? '',
      );
    }

    return null;
  }
}
