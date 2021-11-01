import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nihongo/common_ui/word_card_accented_text.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/word.dart';

part 'word_card_edit_state.dart';
part 'word_card_edit_event.dart';
part 'word_card_edit_bloc.dart';

/// Word editing page.
/// It is simple enough for not using BLOC pattern.
class WordCardEditPage extends StatelessWidget {
  final Word? word;
  final ValueChanged<Word>? onSubmit;
  final ValueChanged<Word>? onDelete;

  const WordCardEditPage({
    this.word,
    this.onSubmit,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WordCardEditBloc(),
      child: WordCardEditView(
        word: word,
        onSubmit: onSubmit,
        onDelete: onDelete,
      ),
    );
  }
}

class WordCardEditView extends StatefulWidget {
  final Word? word;
  final ValueChanged<Word>? onSubmit;
  final ValueChanged<Word>? onDelete;

  const WordCardEditView({
    this.word,
    this.onSubmit,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  State<WordCardEditView> createState() => _WordCardEditViewState();
}

class _WordCardEditViewState extends State<WordCardEditView> {
  final _formKey = GlobalKey<FormState>();
  String _kanji = '';
  String _kana = '';
  Map<int, CharacterAccent> _accentAtIndex = {};
  String _meaning = '';
  String _tagsString = '';

  //

  static CharacterAccent? _getNextAccent(CharacterAccent? accent) {
    if (accent != null) {
      switch (accent) {
        case CharacterAccent.plain:
          return CharacterAccent.fall;
        case CharacterAccent.fall:
          return null;
      }
    } else {
      return CharacterAccent.plain;
    }
  }

  String getNavigationTitle(BuildContext context) {
    if (widget.word == null) {
      return AppLocalizations.of(context)?.wordCardAddTitle ?? '';
    } else {
      return AppLocalizations.of(context)?.wordCardEditTitle ?? '';
    }
  }

  //

  @override
  void initState() {
    super.initState();

    final word = widget.word;
    if (word != null) {
      _kanji = word.kanji;
      _kana = word.kana;
      _accentAtIndex = word.accentAtIndex;
      _meaning = word.meaning;
      _tagsString = word.tags.join(', ');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = widget.word;
    return Scaffold(
      appBar: AppBar(
        title: Text(getNavigationTitle(context)),
        actions: [
          if (word != null)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context)?.wordCardEditDialogDeleteTitle ?? ''),
                    actions: [
                      TextButton(
                        onPressed: () {},
                        child: Text(AppLocalizations.of(context)?.commonDialogButtonNo ?? ''),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.onDelete?.call(word);
                        },
                        child: Text(AppLocalizations.of(context)?.commonDialogButtonYes ?? ''),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          IconButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final List<String> tags = _tagsString.split(',').map((e) => e.trim()).toList();
                  final word = Word(
                    id: widget.word?.id ?? const Uuid().v4(),
                    kanji: _kanji,
                    kana: _kana,
                    accentAtIndex: _accentAtIndex,
                    meaning: _meaning,
                    tags: tags,
                  );
                  widget.onSubmit?.call(word);
                }
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(36),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.wordCardEditFieldKanjiTitle,
                ),
                textInputAction: TextInputAction.next,
                initialValue: _kanji,
                onChanged: (val) => _kanji = val,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return AppLocalizations.of(context)?.wordCardEditFieldKanjiErrorNull;
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.wordCardEditFieldKanaTitle,
                ),
                textInputAction: TextInputAction.next,
                initialValue: _kana,
                onChanged: (val) {
                  setState(() {
                    _kana = val;
                  });
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return AppLocalizations.of(context)?.wordCardEditFieldKanaErrorNull;
                  }
                  return null;
                },
              ),

              // Accents
              if (_kana.isNotEmpty)
                // Force the column as wide as the parent
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 8),
                        child: Text(
                          AppLocalizations.of(context)?.wordCardEditFieldAccentsTitle ?? '',
                        ),
                      ),
                      WordCardAccentedText(
                        text: _kana,
                        accentAtIndex: _accentAtIndex,
                        fontSize: 48,
                        onTapCharacterAtIndex: (idx) {
                          final accent = _accentAtIndex[idx];
                          final newAccent = _getNextAccent(accent);
                          setState(() {
                            if (newAccent != null) {
                              _accentAtIndex[idx] = newAccent;
                            } else {
                              _accentAtIndex.remove(idx);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),

              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.wordCardEditFieldMeaningTitle,
                ),
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                initialValue: _meaning,
                onChanged: (val) => _meaning = val,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.wordCardEditFieldTagsTitle,
                  hintText: AppLocalizations.of(context)?.wordCardEditFieldTagsPlaceholder,
                ),
                initialValue: _tagsString,
                onChanged: (val) => _tagsString = val,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
