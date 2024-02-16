import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/cubits/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/view/widgets/exception_widget.dart';
import 'package:vocabulary_app/view/widgets/success_state_widget.dart';

class WordsWidget extends StatelessWidget {
  const WordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        if (state is ReadDataSuccess) {
          if (state.words.isEmpty) {
            return const ExceptionWidget(
              imagePath: 'assets/images/undraw_Add_notes_re_ln36.png',
              message: 'let\'s Start Adding Your Data',
            );
          } else {
            return SuccessStateWidget(
              words: state.words,
            );
          }
        } else if (state is ReadDataFailure) {
          return ExceptionWidget(
              imagePath: 'assets/images/undraw_access_denied_re_awnf.png',
              message: state.eMessage);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
