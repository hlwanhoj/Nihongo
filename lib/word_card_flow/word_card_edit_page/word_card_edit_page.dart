import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/word.dart';

part 'word_card_edit_state.dart';
part 'word_card_edit_event.dart';
part 'word_card_edit_bloc.dart';

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
  late TextEditingController _kanjiController;
  late TextEditingController _kanaController;
  late TextEditingController _meaningController;
  late TextEditingController _tagsStringController;

  @override
  void initState() {
    super.initState();
    _kanjiController = TextEditingController(text: widget.word?.kanji);
    _kanaController = TextEditingController(text: widget.word?.kana);
    _meaningController = TextEditingController(text: widget.word?.meaning);
    _tagsStringController = TextEditingController(text: widget.word?.tags.join(', '));
  }

  @override
  Widget build(BuildContext context) {
    final word = widget.word;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.wordCardEditTitle ?? ''),
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
                  final List<String> tags = _tagsStringController.text.split(',').map((e) => e.trim()).toList();
                  final word = Word(
                    id: widget.word?.id ?? const Uuid().v4(),
                    kanji: _kanjiController.text,
                    kana: _kanaController.text,
                    accentAtIndex: {},
                    meaning: _meaningController.text,
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
                controller: _kanjiController,
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
                controller: _kanaController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return AppLocalizations.of(context)?.wordCardEditFieldKanaErrorNull;
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.wordCardEditFieldMeaningTitle,
                ),
                textInputAction: TextInputAction.newline,
                maxLines: null,
                controller: _meaningController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.wordCardEditFieldTagsTitle,
                  hintText: AppLocalizations.of(context)?.wordCardEditFieldTagsPlaceholder,
                ),
                controller: _tagsStringController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
