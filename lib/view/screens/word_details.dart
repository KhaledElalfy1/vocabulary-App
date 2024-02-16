import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:vocabulary_app/cubits/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/cubits/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/model/word_model.dart';
import 'package:vocabulary_app/view/widgets/exception_widget.dart';
import 'package:vocabulary_app/view/widgets/show_examples.dart';
import 'package:vocabulary_app/view/widgets/update_word_button.dart';
import 'package:vocabulary_app/view/widgets/update_word_dialog.dart';
import 'package:vocabulary_app/view/widgets/show_similar_words.dart';
import 'package:vocabulary_app/view/widgets/word_info_widget.dart';

class WordDetails extends StatefulWidget {
  const WordDetails({super.key, required this.wordModel});
  final WordModel wordModel;

  @override
  State<WordDetails> createState() => _WordDetailsState();
}

class _WordDetailsState extends State<WordDetails> {
  late WordModel _wordModel;
  @override
  void initState() {
    _wordModel = widget.wordModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(widget.wordModel.colorCode),
        title: Text(
          'Word Details',
          style: TextStyle(
            color: Color(widget.wordModel.colorCode),
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              WriteDataCubit.get(context)
                  .deleteWord(widget.wordModel.indexInDataBase);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
              size: 30,
            ),
          )
        ],
      ),
      body: BlocBuilder<ReadDataCubit, ReadDataState>(
        builder: (context, state) {
          if (state is ReadDataSuccess) {
            int index = state.words.indexWhere((element) =>
                element.indexInDataBase == _wordModel.indexInDataBase);
            _wordModel = state.words[index];
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                _getLabelText('Word'),
                const Gap(10),
                WordInfoWidget(
                  text: _wordModel.text,
                  colorCode: _wordModel.colorCode,
                  isArabic: _wordModel.isArabic,
                ),
                const Gap(25),
                Row(
                  children: [
                    _getLabelText('Similar Word'),
                    const Spacer(),
                    UpdateWordButton(
                      colorCode: _wordModel.colorCode,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => UpdateWordDialog(
                            isExample: false,
                            colorCode: _wordModel.colorCode,
                            indexAtDatabase: _wordModel.indexInDataBase,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Gap(20),
                ShowSimilarWords(
                  similarWords: _wordModel.arabicSimilarWord,
                  isArabic: true,
                  colorCode: _wordModel.colorCode,
                  indexAtDatabase: _wordModel.indexInDataBase,
                ),
                const Gap(20),
                ShowSimilarWords(
                  similarWords: _wordModel.englishSimilarWord,
                  isArabic: false,
                  colorCode: _wordModel.colorCode,
                  indexAtDatabase: _wordModel.indexInDataBase,
                ),
                const Gap(25),
                Row(
                  children: [
                    _getLabelText('Examples'),
                    const Spacer(),
                    UpdateWordButton(
                      colorCode: _wordModel.colorCode,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => UpdateWordDialog(
                            isExample: true,
                            colorCode: _wordModel.colorCode,
                            indexAtDatabase: _wordModel.indexInDataBase,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Gap(20),
                ShowExamples(
                  isArabic: true,
                  examples: _wordModel.arabicExample,
                  colorCode: _wordModel.colorCode,
                  indexAtDatabase: _wordModel.indexInDataBase,
                ),
                const Gap(20),
                ShowExamples(
                  isArabic: false,
                  examples: _wordModel.englishExample,
                  colorCode: _wordModel.colorCode,
                  indexAtDatabase: _wordModel.indexInDataBase,
                ),
              ],
            );
          } else if (state is ReadDataFailure) {
            return const ExceptionWidget(
                imagePath: 'assets/images/undraw_access_denied_re_awnf.png',
                message: 'Unknown Error');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Text _getLabelText(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Color(_wordModel.colorCode),
      ),
    );
  }
}
