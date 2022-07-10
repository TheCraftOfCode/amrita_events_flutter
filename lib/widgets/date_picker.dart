import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

class DatePickerWidget extends FormField<DateTime> {
  DatePickerWidget(
      {Key? key,
      FormFieldSetter<DateTime>? onSaved,
      FormFieldValidator<DateTime>? validator,
      DateTime? defaultDate,
      required context,
      hint = 'Please choose a date',
      title,
      AutovalidateMode autoValidateMode = AutovalidateMode.disabled})
      : super(
            key: key,
            onSaved: onSaved,
            validator: validator ??
                (data) {
                  if (data == null) return "Please choose date";
                  return null;
                },
            initialValue: defaultDate ?? null,
            autovalidateMode: autoValidateMode,
            builder: (FormFieldState<DateTime> state) {
              Future pickDate(BuildContext context) async {
                await CupertinoRoundedDatePicker.show(context,
                    background: colors.lightTextBoxColor,
                    textColor: colors.primaryTextColor,
                    initialDate: state.value ?? DateTime.now(),
                    minimumYear: DateTime.now().year,
                    minimumDate: DateTime.now(),
                    maximumYear: DateTime.now().year + 5,
                    initialDatePickerMode: CupertinoDatePickerMode.date,
                    borderRadius: 16, onDateTimeChanged: (date) {
                  state.didChange(date);
                });
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(title ?? 'Choose date',
                        style: GoogleFonts.montserrat(
                            fontSize: 15, color: colors.primaryTextColor)),
                  ),
                  Card(
                    color: colors.lightTextBoxColor,
                    margin: const EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        pickDate(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 15, bottom: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 10),
                              child: Icon(
                                Icons.calendar_today,
                                color: colors.primaryTextColor,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                  state.value == null
                                      ? hint
                                      : '${state.value!.day} / ${state.value!.month} / ${state.value!.year}',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: state.hasError
                                          ? Colors.red
                                          : Colors.grey)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  state.hasError
                      ? Container(
                          padding: const EdgeInsets.all(7),
                          child: Text(
                            state.errorText ?? "error",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 10),
                          ),
                        )
                      : Container()
                ],
              );
            });
}
