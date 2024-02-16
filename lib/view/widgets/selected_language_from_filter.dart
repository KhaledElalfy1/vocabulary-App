import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/cubits/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/view/styles/colors.dart';

class LanguageFromFilter extends StatelessWidget {
  const LanguageFromFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        return Text(
          _mapLanguageFilterToString(ReadDataCubit.get(context).languageFilter),
          style:const TextStyle(
              fontSize: 24,
              color: ColorManager.white,
              fontWeight: FontWeight.bold),
        );
      },
    );
  }
}

String _mapLanguageFilterToString(LanguageFilter languageFilter) {
  if (languageFilter == LanguageFilter.allWords) {
    return 'All Words';
  } else if (languageFilter == LanguageFilter.englishOnly) {
    return 'English only';
  } else {
    return 'Arabic Only';
  }
}
