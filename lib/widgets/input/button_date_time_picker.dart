import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';
import '../../util.dart';
import 'custom_button.dart';

class ButtonDateTimePicker extends StatelessWidget {
  final String buttText;
  final DateCallBack onChange;
  final DateTime currentTime;
  final dateFormat = DateFormat('yyyy MM dd HH:mm');

  ButtonDateTimePicker({
    @required this.buttText,
    @required this.onChange,
    @required this.currentTime,
  })  : assert(buttText != null),
        assert(onChange != null),
        assert(currentTime != null);
        
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttText,
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: false,
          onChanged: this.onChange,
          currentTime: this.currentTime,
          locale: LocaleType.en,
          theme: DatePickerTheme(
              backgroundColor: modalPickerColor,
              itemStyle: TextStyle(
                  color: textColor,
                  fontWeight: fwSpinner,
                  fontSize: textSizeModalSpinner),
              doneStyle: TextStyle(
                  color: textColor,
                  fontWeight: fwSpinner,
                  fontSize: textSizeModalSpinner)),
        );
      },
    );
  }
}
