import 'package:flutter/material.dart';
import 'package:vocabulary_app/cubits/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/model/word_model.dart';
import 'package:vocabulary_app/view/screens/word_details.dart';
import 'package:vocabulary_app/view/styles/colors.dart';

class WordContainer extends StatelessWidget {
  const WordContainer({super.key, required this.word});
  final WordModel word;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordDetails(wordModel: word),
          ),
        ).then(
          (value) {
            Future.delayed(const Duration(seconds: 1))
                .then((value) => ReadDataCubit.get(context).getWords());
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(word.colorCode),
            borderRadius: BorderRadius.circular(16)),
        child: Text(
          word.text,
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: ColorManager.white),
        ),
      ),
    );
  }
}
