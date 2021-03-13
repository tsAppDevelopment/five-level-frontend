import 'package:flutter/material.dart';
import '../../util.dart';
import '../../widgets/input/black_button_admin.dart';
import '../../widgets/input/edit_text_admin.dart';
import 'serializable.dart';

class GlossaryShallow implements APISerialiable {
  int aircraftid;
  int glossaryid;
  String name;
  void setName(String s) => name = s;
  String body;
  void setBody(String s) => body = s;
  String ep = 'glossary';
  void Function(Map<String, dynamic> obj) onSave;

  GlossaryShallow.fromJson(Map<String, dynamic> json, this.onSave)
      : aircraftid = json["aircraftid"],
        glossaryid = json["glossaryid"] ?? 0,
        name = json["name"] ?? '',
        body = json["body"] ?? '';

  Map<String, dynamic> toJson() => {
        "aircraftid": aircraftid,
        "glossaryid": glossaryid,
        "name": name,
        "body": body,
      };

  Widget getForm() {
    final key = GlobalKey<FormState>();
    return Form(
        key: key,
        child: SingleChildScrollView(
            child: Column(children: [
          EditTextAdmin(
              initialValue: name,
              hintText: 'Name / Title',
              validate: (s) => validateStringNotEmpty(s, setName)),
          EditTextAdmin(
              initialValue: body,
              hintText: 'Body',
              validate: (s) => validateStringNotEmpty(s, setBody)),
          BlackButtonAdmin(() {
            if (key.currentState.validate()) {
              this.onSave(this.toJson());
            }
          })
        ])));
  }
}
