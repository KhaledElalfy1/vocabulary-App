import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vocabulary_app/cubits/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/cubits/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/view/widgets/word_info_widget.dart';

class ShowExamples extends StatelessWidget {
  const ShowExamples(
      {super.key,
      required this.isArabic,
      required this.examples,
      required this.colorCode, required this.indexAtDatabase});
  final bool isArabic;
  final List examples;
  final int colorCode, indexAtDatabase;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: examples.length,
      itemBuilder: (context, index) {
        return WordInfoWidget(
          text: examples[index],
          colorCode: colorCode,
          isArabic: isArabic,
          onPressed: () {
            WriteDataCubit.get(context)
                .deleteExample(indexAtDatabase, index, isArabic);
                ReadDataCubit.get(context).getWords();
          },
        );
      },
      separatorBuilder: (context, index) => const Gap(10),
    );
  }
}
