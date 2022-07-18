import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TimePickerWidget extends FormField<TimeOfDay> {
  TimePickerWidget(
      {Key? key,
      FormFieldSetter<TimeOfDay>? onSaved,
      FormFieldValidator<TimeOfDay>? validator,
      TimeOfDay? initialValue,
      required context,
      hint = 'Please choose event time',
      title,
      AutovalidateMode autoValidateMode = AutovalidateMode.disabled})
      : super(
            key: key,
            onSaved: onSaved,
            validator: validator ??
                (data) {
                  if (data == null) return "Please choose event time";
                  return null;
                },
            initialValue: initialValue ?? TimeOfDay.now(),
            autovalidateMode: autoValidateMode,
            builder: (FormFieldState<TimeOfDay> state) {
              String formatTimeOfDay(TimeOfDay tod) {
                final now = DateTime.now();
                final dt = DateTime(
                    now.year, now.month, now.day, tod.hour, tod.minute);
                final format = DateFormat.jm(); //"6:00 AM"
                return format.format(dt);
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(title ?? 'Choose time',
                        style: GoogleFonts.montserrat(
                            fontSize: 15, color: colors.primaryTextColor)),
                  ),
                  Card(
                    color: colors.textBoxColor,
                    margin: const EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: state.value ?? TimeOfDay.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                // This uses the _timePickerTheme defined above
                                timePickerTheme: TimePickerThemeData(
                                  backgroundColor: colors.cardColor,
                                  hourMinuteColor: colors.textBoxColor,
                                  hourMinuteTextColor: colors.primaryTextColor,
                                  dayPeriodTextColor: colors.primaryTextColor,
                                  dialTextColor: colors.primaryTextColor,
                                  dialHandColor: colors.scaffoldColor,
                                  entryModeIconColor: colors.primaryTextColor,
                                  helpTextStyle: GoogleFonts.raleway(
                                      color: colors.primaryTextColor,
                                      fontWeight: FontWeight.w600),
                                  inputDecorationTheme: InputDecorationTheme(
                                      helperStyle: GoogleFonts.raleway(
                                          color: colors.primaryTextColor),
                                      floatingLabelStyle: GoogleFonts.raleway(
                                          color: colors.primaryTextColor)),
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => colors.accentColor),
                                    foregroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.white),
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => colors.accentColor),
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        state.didChange(pickedTime ?? state.value);
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
                                Icons.access_time_outlined,
                                color: colors.primaryTextColor,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                  state.value == null
                                      ? hint
                                      : formatTimeOfDay(state.value!),
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
                            style: GoogleFonts.raleway(
                                color: Colors.red, fontSize: 10),
                          ),
                        )
                      : Container()
                ],
              );
            });
}
