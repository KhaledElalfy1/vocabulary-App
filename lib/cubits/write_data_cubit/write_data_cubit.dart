import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vocabulary_app/constants.dart';
import 'package:vocabulary_app/model/word_model.dart';
part 'write_data_state.dart';

class WriteDataCubit extends Cubit<WriteDataState> {
  WriteDataCubit() : super(WriteDataInitial());
  static WriteDataCubit get(context) => BlocProvider.of(context);

  final Box box = Hive.box(Constants.wordBox);
  String text = '';
  bool isArabic = true;
  int colorCode = 0xff8ECAE6;
  void updateString(String text) {
    this.text = text;
  }

  void updateIsArabic(bool isArabic) {
    this.isArabic = isArabic;
    emit(WriteDataInitial());
  }

  void updateColorCode(int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDataInitial());
  }

  void addWord() {
    _tryAndCatchBloc(
      () {
        List<WordModel> words = _getWordsFromDataBase();

        words.add(
          WordModel(
              indexInDataBase: words.length,
              text: text,
              isArabic: isArabic,
              colorCode: colorCode),
        );
        box.put(Constants.wordsList, words);
      },
    );
  }

  void deleteWord(int indexAtDataBase) {
    _tryAndCatchBloc(
      () {
        List<WordModel> words = _getWordsFromDataBase();
        words.removeAt(indexAtDataBase);
        for (var i = indexAtDataBase; i < words.length; i++) {
          words[i] = words[i].decrementIndexAtDataBase();
        }
        box.put(Constants.wordsList, words);
      },
    );
  }

  void addSimilarWord(int indexAtDatabase) {
    _tryAndCatchBloc(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDatabase] =
          words[indexAtDatabase].addSimilarWord(text, isArabic);
      box.put(Constants.wordsList, words);
    });
  }

  void addExample(int indexAtDatabase) {
    _tryAndCatchBloc(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDatabase] =
          words[indexAtDatabase].addExample(text, isArabic);
      box.put(Constants.wordsList, words);
    });
  }

  void deleteSimilarWord(
      int indexAtDatabase, int indexAtSimilarWord, bool isArabicSimilarWord) {
    _tryAndCatchBloc(
      () {
        List<WordModel> words = _getWordsFromDataBase();
        words[indexAtDatabase] = words[indexAtDatabase]
            .deleteSimilarWord(indexAtSimilarWord, isArabicSimilarWord);
        box.put(Constants.wordsList, words);
      },
    );
  }

  void deleteExample(
      int indexAtDatabase, int indexAtExamples, bool isArabicExample) {
    List<WordModel> words = _getWordsFromDataBase();
    words[indexAtDatabase] =
        words[indexAtDatabase].deleteExample(indexAtExamples, isArabicExample);
    box.put(Constants.wordsList, words);
  }

  List<WordModel> _getWordsFromDataBase() {
    return List.from(box.get(Constants.wordsList, defaultValue: []))
        .cast<WordModel>();
  }

  void _tryAndCatchBloc(VoidCallback functionToExecute) {
    emit(WriteDataLoading());
    try {
      functionToExecute.call();
      emit(WriteDataSuccess());
    } catch (e) {
      emit(WriteDataFailure(eMessage: e.toString()));
    }
  }
}
