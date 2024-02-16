import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:vocabulary_app/cubits/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/view/styles/colors.dart';
import 'package:vocabulary_app/view/widgets/filter_buttons.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: ColorManager.black,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _getLabelText('Language'),
                const Gap(10),
                _getLanguageFilter(context),
                const Gap(15),
                _getLabelText('Sorted By'),
                const Gap(10),
                _getSortedByFilter(context),
                const Gap(15),
                _getLabelText('Sorting Type'),
                const Gap(10),
                _getSortedTypeFilter(context),
              ],
            ),
          ),
        );
      },
    );
  }

  FilterButtons _getSortedTypeFilter(BuildContext context) {
    return FilterButtons(
      labels: const ['Ascending', 'Descending'],
      onTaps: [
        () {
          ReadDataCubit.get(context).updateSortType(SortType.ascending);
        },
        () {
          ReadDataCubit.get(context).updateSortType(SortType.descending);
        },
      ],
      isSelected: [
        ReadDataCubit.get(context).sortType == SortType.ascending,
        ReadDataCubit.get(context).sortType == SortType.descending,
      ],
    );
  }

  FilterButtons _getSortedByFilter(BuildContext context) {
    return FilterButtons(
      labels: const ['Time', 'Word Length'],
      onTaps: [
        () {
          ReadDataCubit.get(context).updateSortedBy(SortedBy.time);
        },
        () {
          ReadDataCubit.get(context).updateSortedBy(SortedBy.wordLength);
        },
      ],
      isSelected: [
        ReadDataCubit.get(context).sortedBy == SortedBy.time,
        ReadDataCubit.get(context).sortedBy == SortedBy.wordLength,
      ],
    );
  }

  FilterButtons _getLanguageFilter(BuildContext context) {
    return FilterButtons(
      labels: const ['Arabic', 'English', 'All Words'],
      onTaps: [
        () {
          ReadDataCubit.get(context)
              .updateLanguageFilter(LanguageFilter.arabicOnly);
        },
        () {
          ReadDataCubit.get(context)
              .updateLanguageFilter(LanguageFilter.englishOnly);
        },
        () {
          ReadDataCubit.get(context)
              .updateLanguageFilter(LanguageFilter.allWords);
        },
      ],
      isSelected: [
        ReadDataCubit.get(context).languageFilter == LanguageFilter.arabicOnly,
        ReadDataCubit.get(context).languageFilter == LanguageFilter.englishOnly,
        ReadDataCubit.get(context).languageFilter == LanguageFilter.allWords,
      ],
    );
  }

  Widget _getLabelText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: ColorManager.white,
        fontWeight: FontWeight.bold,
        fontSize: 21,
      ),
    );
  }
}
