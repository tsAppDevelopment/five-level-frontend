import 'customButton.dart';
import '../../backend/cont.dart';
import '../../widgets/display/text.dart';
import '../../utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonModalSpinner extends StatefulWidget {
  final List<String> stringList;
  final IntCallBackIntPara onSpin;
  final int initIdx;

  ButtonModalSpinner({
    this.initIdx,
    @required this.onSpin,
    @required this.stringList,
  }) : super(key: UniqueKey());

  @override
  _ButtonModalSpinnerState createState() => _ButtonModalSpinnerState();
}

class _ButtonModalSpinnerState extends State<ButtonModalSpinner> {
  List<Widget> spinnerWidgets;
  int spinIdx;
  String selected;

  List<Widget> getSpinnerWidgets(List<String> strings) {
    return List.generate(strings.length, (i) {
      return Center(
          child: Tex(
        strings[i],
        size: Const.textSizeModalSpinner,
        fontWeight: Const.fwSpinner,
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    spinIdx = this.widget.initIdx ?? 0;
    selected = this.widget.stringList[spinIdx];
    spinnerWidgets = getSpinnerWidgets(this.widget.stringList);
  }

  void _spin(int newIdx) {
    this.widget.onSpin(newIdx);
    if (this.mounted) {
      setState(() {
        spinIdx = newIdx;
        selected = this.widget.stringList[newIdx];
      });
    }
  }

  press() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: Const.modalSpinHeight,
          color: Const.modalPickerColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    height: 210,
                    child: Column(children: [
                      Flexible(child: Container()),
                      Flexible(
                          flex: 9,
                          child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem: spinIdx),
                              onSelectedItemChanged: _spin,
                              itemExtent: 35,
                              children: spinnerWidgets)),
                      Flexible(child: Container()),
                    ])),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      selected,
      onPressed: press,
    );
  }
}
