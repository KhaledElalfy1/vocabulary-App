import 'package:flutter/material.dart';
import 'package:vocabulary_app/cubits/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/view/styles/colors.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, required this.label, required this.formKey});
  final String label;
  final GlobalKey<FormState> formKey;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        key: widget.key,
        autofocus: true,
        onChanged: (value) => WriteDataCubit.get(context).updateString(value),
        validator: (value) {
          return _validator(value, WriteDataCubit.get(context).isArabic);
        },
        controller: textEditingController,
        maxLines: 2,
        minLines: 1,
        cursorColor: ColorManager.white,
        style: const TextStyle(color: ColorManager.white),
        decoration: InputDecoration(
          label: Text(
            widget.label,
            style: const TextStyle(color: ColorManager.white),
          ),
          enabledBorder: _borderStyle(),
          focusedBorder: _borderStyle(),
          errorBorder: _borderStyle(color: ColorManager.red),
          // focusedErrorBorder:
        ),
      ),
    );
  }

  String? _validator(String? value, bool isArabic) {
    if (value == null || value.trim().isEmpty) {
      return "filed can't be empty";
    }
    for (int i = 0; i < value.length; i++) {
      CharType charType = _getCharType(value.codeUnitAt(i));
      if (charType == CharType.notValid) {
        return 'char number ${i + 1} is not valid';
      } else if (charType == CharType.arabic && isArabic == false) {
        return 'char number ${i + 1} is not english';
      } else if (charType == CharType.english && isArabic == true) {
        return 'char number ${i + 1} is not arabic';
      }
    }
  }

  CharType _getCharType(int asciiCode) {
    if ((asciiCode >= 65 && asciiCode <= 90) ||
        (asciiCode >= 97 && asciiCode <= 122)) {
      return CharType.english;
    } else if ((asciiCode >= 1569 && asciiCode <= 1610)) {
      return CharType.arabic;
    } else if (asciiCode == 32) {
      return CharType.space;
    }
    return CharType.notValid;
  }

  OutlineInputBorder _borderStyle(
      {Color color = ColorManager.white,
      double radius = 8,
      double borderWidth = 2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: color,
        width: borderWidth,
      ),
    );
  }
}

enum CharType { arabic, english, space, notValid }
