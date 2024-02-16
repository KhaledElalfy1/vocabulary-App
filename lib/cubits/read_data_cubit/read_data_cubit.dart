import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vocabulary_app/constants.dart';
import 'package:vocabulary_app/model/word_model.dart';

part 'read_data_state.dart';

class ReadDataCubit extends Cubit<ReadDataState> {
  ReadDataCubit() : super(ReadDataInitial());
  static ReadDataCubit get(context) => BlocProvider.of(context);
  final Box _box = Hive.box(Constants.wordBox);

  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortedBy sortedBy = SortedBy.time;
  SortType sortType = SortType.descending;

  void updateLanguageFilter(LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
    getWords();
  }

  void updateSortedBy(SortedBy sortedBy) {
    this.sortedBy = sortedBy;
    getWords();
  }

  void updateSortType(SortType sortType) {
    this.sortType = sortType;
    getWords();
  }

  void getWords() {
    try {
      List<WordModel> wordsToReturn = List.from(
        _box.get(
          Constants.wordsList,
          defaultValue: [],
        ),
      ).cast<WordModel>();

      _removeUnwantedWords(wordsToReturn);
      _applySorting(wordsToReturn);

      emit(ReadDataSuccess(words: wordsToReturn));
    } catch (e) {
      emit(
        ReadDataFailure(
          eMessage: e.toString(),
        ),
      );
    }
  }

  void _removeUnwantedWords(List<WordModel> wordsToReturn) {
    if (languageFilter == LanguageFilter.allWords) {
      return;
    }
    for (var i = 0; i < wordsToReturn.length; i++) {
      if ((languageFilter == LanguageFilter.arabicOnly &&
              wordsToReturn[i].isArabic == false) ||
          (languageFilter == LanguageFilter.englishOnly &&
              wordsToReturn[i].isArabic == true)) {
        wordsToReturn.removeAt(i);
        i--;
      }
    }
  }

  void _applySorting(List<WordModel> wordsToReturn) {
    if (sortedBy == SortedBy.time) {
      if (sortType == SortType.ascending) {
        return;
      } else {
        _reverse(wordsToReturn);
      }
    } else {
      wordsToReturn.sort(
          (WordModel a, WordModel b) => a.text.length.compareTo(b.text.length));

      if (sortType == SortType.ascending) {
        return;
      } else {
        _reverse(wordsToReturn);
      }
    }
  }

  void _reverse(List<WordModel> wordsToReturn) {
    for (var i = 0; i < wordsToReturn.length / 2; i++) {
      WordModel temp = wordsToReturn[i];
      wordsToReturn[i] = wordsToReturn[wordsToReturn.length - i - 1];
      wordsToReturn[wordsToReturn.length - i - 1] = temp;
    }
  }
}

enum LanguageFilter {
  arabicOnly,
  englishOnly,
  allWords,
}

enum SortedBy {
  time,
  wordLength,
}

enum SortType {
  ascending,
  descending,
}
