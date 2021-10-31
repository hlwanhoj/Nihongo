import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../models/word.dart';
import '../word_card_data_repository.dart';

part 'word_card_edit_state.dart';
part 'word_card_edit_event.dart';
part 'word_card_edit_bloc.dart';

class WordCardEditPage extends StatelessWidget {
  final Word? word;
  final ValueChanged<Word>? onSubmit;

  const WordCardEditPage({
    this.word,
    this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WordCardEditBloc(),
      child: WordCardEditView(word: word, onSubmit: onSubmit),
    );
  }
}

class WordCardEditView extends StatefulWidget {
  final Word? word;
  final ValueChanged<Word>? onSubmit;

  const WordCardEditView({
    this.word,
    this.onSubmit,
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
    _tagsStringController =
        TextEditingController(text: widget.word?.tags.join(', '));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Vocabulary'),
        actions: [
          IconButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final List<String> tags = _tagsStringController.text
                      .split(',')
                      .map((e) => e.trim())
                      .toList();
                  final word = Word(
                      id: widget.word?.id ?? const Uuid().v4(),
                      kanji: _kanjiController.text,
                      kana: _kanaController.text,
                      accentAtIndex: {},
                      meaning: _meaningController.text,
                      tags: tags);
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
                decoration: const InputDecoration(
                  labelText: 'Kanji',
                ),
                textInputAction: TextInputAction.next,
                controller: _kanjiController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Cannot be empty";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Kana',
                ),
                textInputAction: TextInputAction.next,
                controller: _kanaController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Cannot be empty";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Meaning',
                ),
                textInputAction: TextInputAction.next,
                controller: _meaningController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tags',
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
