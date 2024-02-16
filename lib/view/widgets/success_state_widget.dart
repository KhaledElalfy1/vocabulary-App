import 'package:flutter/material.dart';
import 'package:vocabulary_app/model/word_model.dart';
import 'package:vocabulary_app/view/widgets/word_container.dart';

class SuccessStateWidget extends StatelessWidget {
  const SuccessStateWidget({super.key, required this.words});
  final List<WordModel> words;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: words.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 2 / 1.5),
      itemBuilder: (context, index) {
        return WordContainer(word: words[index]);
      },
    );
  }
}
