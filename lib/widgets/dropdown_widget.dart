import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

class DropDownFormField extends FormField<dynamic> {
  DropDownFormField(
      {Key? key, FormFieldSetter<dynamic>? onSaved,
        FormFieldValidator<dynamic>? validator,
        required list,
        required title,
        required hint,
        String? defaultValue,
        errorField,
        AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction})
      : super(key: key,
      onSaved: onSaved,
      validator: validator ??
              (data) {
            if (data == null) {
              return errorField ?? "Please select a value";
            }
            return null;
          },
      initialValue: defaultValue,
      autovalidateMode: autoValidateMode,
      builder: (FormFieldState<dynamic> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(title,
                  style: GoogleFonts.nunito(
                      fontSize: 15,
                      color: colors.primaryTextColor)),
            ),
            Card(
              color: colors.textBoxColor,
              elevation: 1,
              margin: const EdgeInsets.only(bottom: 4),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<dynamic>(
                    dropdownColor: colors.textBoxColor,
                    value: state.value,
                    isExpanded: true,
                    items: list.map<DropdownMenuItem>((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      state.didChange(newValue);
                    },
                    hint: Container(
                      color: colors.textBoxColor,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        hint,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                            fontSize: 17,
                            color: state.hasError
                                ? Colors.red
                                : Colors.grey),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    style: GoogleFonts.nunito(
                        fontSize: 17,
                        color: colors.primaryTextColor,
                        decorationColor: Colors.red),
                  ),
                ),
              ),
            ),
            state.hasError
                ? Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                state.errorText ?? "error",
                style: GoogleFonts.nunito(
                    color: Colors.red, fontSize: 10),
              ),
            )
                : Container()
          ],
        );
      });
}