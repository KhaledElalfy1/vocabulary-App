import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:vocabulary_app/cubits/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/cubits/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/view/widgets/arabic_or_english_widget.dart';
import 'package:vocabulary_app/view/widgets/custom_form.dart';
import 'package:vocabulary_app/view/widgets/done_button.dart';

class UpdateWordDialog extends StatefulWidget {
  const UpdateWordDialog(
      {super.key,
      required this.isExample,
      required this.colorCode,
      required this.indexAtDatabase});
  final bool isExample;
  final int colorCode, indexAtDatabase;

  @override
  State<UpdateWordDialog> createState() => _UpdateWordDialogState();
}

class _UpdateWordDialogState extends State<UpdateWordDialog> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(widget.colorCode),
      child: BlocConsumer<WriteDataCubit, WriteDataState>(
        listener: (context, state) {
          if (state is WriteDataSuccess) {
            Navigator.pop(context);
          } else if (state is WriteDataFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.eMessage),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArabicOrEnglishWidget(
                  colorCode: widget.colorCode,
                  isArabic: WriteDataCubit.get(context).isArabic,
                ),
                const Gap(20),
                CustomForm(
                  label: widget.isExample ? 'Example' : 'Similar Word',
                  formKey: _globalKey,
                ),
                const Gap(15),
                DoneButton(
                  colorCode: widget.colorCode,
                  onTap: () {
                    if (_globalKey.currentState!.validate()) {
                      if (widget.isExample) {
                        WriteDataCubit.get(context)
                            .addExample(widget.indexAtDatabase);
                      } else {
                        WriteDataCubit.get(context)
                            .addSimilarWord(widget.indexAtDatabase);
                      }
                      ReadDataCubit.get(context).getWords();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
