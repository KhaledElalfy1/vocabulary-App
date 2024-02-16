class WordModel {
  final int indexInDataBase;
  final String text;
  final bool isArabic;
  final int colorCode;
  final List<String> arabicSimilarWord;
  final List<String> englishSimilarWord;
  final List<String> arabicExample;
  final List<String> englishExample;

  const WordModel(
      {required this.indexInDataBase,
      required this.text,
      required this.isArabic,
      required this.colorCode,
      this.arabicSimilarWord = const [],
      this.englishSimilarWord = const [],
      this.arabicExample = const [],
      this.englishExample = const []});

  WordModel deleteSimilarWord(
      int indexAtSimilarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords = _initSimilarWordsList(isArabicSimilarWord);

    newSimilarWords.removeAt(indexAtSimilarWord);
    return _getWordAfterCheckSimilarWords(newSimilarWords, isArabicSimilarWord);
  }

  WordModel addSimilarWord(String similarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords = _initSimilarWordsList(isArabicSimilarWord);
    newSimilarWords.add(similarWord);
    return _getWordAfterCheckSimilarWords(newSimilarWords, isArabicSimilarWord);
  }

  WordModel addExample(String example, bool isArabicExample) {
    List<String> newExample = _initExampleList(isArabicExample);
    newExample.add(example);
    return _getWordAfterCheckExample(isArabicExample, newExample);
  }

  WordModel deleteExample(int index, bool isArabicExample) {
    List<String> newExample = _initExampleList(isArabicExample);
    newExample.removeAt(index);
    return _getWordAfterCheckExample(isArabicExample, newExample);
  }

  WordModel decrementIndexAtDataBase() {
    return WordModel(
      indexInDataBase: indexInDataBase - 1,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicSimilarWord: arabicSimilarWord,
      englishSimilarWord: englishSimilarWord,
      arabicExample: arabicExample,
      englishExample: englishExample,
    );
  }

  List<String> _initSimilarWordsList(bool isArabicSimilarWord) {
    if (isArabicSimilarWord) {
      return List.from(arabicSimilarWord);
    } else {
      return List.from(englishSimilarWord);
    }
  }

  WordModel _getWordAfterCheckSimilarWords(
    List<String> newSimilarWords,
    bool isArabicSimilarWord,
  ) {
    return WordModel(
      indexInDataBase: indexInDataBase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicSimilarWord:
          isArabicSimilarWord ? newSimilarWords : arabicSimilarWord,
      englishSimilarWord:
          !isArabicSimilarWord ? newSimilarWords : englishSimilarWord,
      arabicExample: arabicExample,
      englishExample: englishExample,
    );
  }

  List<String> _initExampleList(bool isArabicExample) {
    if (isArabicExample) {
      return List.from(arabicExample);
    }
    return List.from(englishExample);
  }

  WordModel _getWordAfterCheckExample(
      bool isArabicExample, List<String> newExample) {
    return WordModel(
      indexInDataBase: indexInDataBase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicSimilarWord: arabicSimilarWord,
      englishSimilarWord: englishSimilarWord,
      arabicExample: isArabicExample ? newExample : arabicExample,
      englishExample: !isArabicExample ? newExample : arabicExample,
    );
  }
}
