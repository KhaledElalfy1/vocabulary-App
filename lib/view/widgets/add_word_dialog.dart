import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:vocabulary_app/cubits/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/cubits/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/view/widgets/arabic_or_english_widget.dart';
import 'package:vocabulary_app/view/widgets/color_widgets.dart';
import 'package:vocabulary_app/view/widgets/custom_form.dart';
import 'package:vocabulary_app/view/widgets/done_button.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
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
          return AnimatedContainer(
            padding: const EdgeInsets.all(15),
            duration: const Duration(seconds: 1),
            color: Color(WriteDataCubit.get(context).colorCode),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ArabicOrEnglishWidget(
                    colorCode: WriteDataCubit.get(context).colorCode,
                    isArabic: WriteDataCubit.get(context).isArabic,
                  ),
                  const Gap(15),
                  ColorsWidget(
                      activeColor: WriteDataCubit.get(context).colorCode),
                  const Gap(10),
                  CustomForm(label: "Add Word", formKey: formKey),
                  const Gap(10),
                  DoneButton(
                    colorCode: WriteDataCubit.get(context).colorCode,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        WriteDataCubit.get(context).addWord();
                        ReadDataCubit.get(context).getWords();
                        print('Button is pressed');
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
