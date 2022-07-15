import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

class TextBoxField extends StatelessWidget {
  const TextBoxField(
      {Key? key,
      this.validator,
      this.onSaved,
      this.controller,
      required this.title,
      required this.hint,
      required this.padding,
      required this.light,
      this.onChanged,
      this.initialValue})
      : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final String title;
  final String hint;
  final EdgeInsets padding;
  final bool light;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
          initialValue: initialValue ?? '',
          controller: controller,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          style: GoogleFonts.montserrat(color: light ? colors.scaffoldColor : colors.primaryTextColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
            label: Text(title,
                style: GoogleFonts.nunito(
                    color: light
                        ? colors.lightTextBoxTextColor
                        : colors.textBoxTextColor,
                    fontSize: 17)),
            filled: true,
            hintText: hint,
            hintStyle: GoogleFonts.nunito(
                color: light
                    ? colors.lightTextBoxTextColor
                    : colors.textBoxTextColor),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5)),
            fillColor: light ? colors.lightTextBoxColor : colors.textBoxColor,
            focusColor: light ? colors.lightTextBoxColor : colors.textBoxColor,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5)),
          )),
    );
  }
}
