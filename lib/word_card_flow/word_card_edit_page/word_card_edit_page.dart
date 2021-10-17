import 'package:flutter/material.dart';
import 'package:nihongo/models/word.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class WordCardEditPage extends StatelessWidget {
  final Word? word;

  WordCardEditPage({
    this.word,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      // body: BlocProvider(
      //   create: (context) =>
      //       WordCardEditBloc(context.read<WordCardDataRepository>()),
      //   child: const WordCardEditView(),
      // ),
      body: WordCardEditView(),
    );
  }
}

//

class WordCardEditView extends StatelessWidget {
  const WordCardEditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Center(
        child: Text('Edit page'),
      ),
    );
  }
}
