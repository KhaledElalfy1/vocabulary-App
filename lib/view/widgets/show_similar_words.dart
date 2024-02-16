import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vocabulary_app/cubits/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/cubits/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/view/widgets/word_info_widget.dart';

class ShowSimilarWords extends StatelessWidget {
  const ShowSimilarWords(
      {super.key,
      required this.similarWords,
      required this.isArabic,
      required this.colorCode,
      required this.indexAtDatabase});
  final List similarWords;
  final bool isArabic;
  final int colorCode, indexAtDatabase;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: similarWords.length,
      itemBuilder: (context, index) {
        return WordInfoWidget(
          text: similarWords[index],
          colorCode: colorCode,
          isArabic: isArabic,
          onPressed: () {
            WriteDataCubit.get(context)
                .deleteSimilarWord(indexAtDatabase, index, isArabic);
            ReadDataCubit.get(context).getWords();
          },
        );
      },
      separatorBuilder: (context, index) => const Gap(10),
    );
  }
}
