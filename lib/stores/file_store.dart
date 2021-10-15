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
    final wordsJSONString = await file.readAsString();
    final json = jsonDecode(wordsJSONString);
    final wordMaps = Utility.cast<List<dynamic>>(jsonDecode(wordsJSONString));
    if (wordMaps != null) {
      final words = wordMaps.map((e) {
        final word = Utility.cast<Map<String, dynamic>>(e);
        if (word != null) {
          return Word.fromJson(word);
        }
        return null;
      }).whereNotNull();
      return words.toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> setWords(List<Word> words) async {
    final File file = await _getWordsFile();
    await file.writeAsString(jsonEncode(words));
  }
}
