import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constant.dart';
import '../../models/nested/aircraft.dart';
import '../../models/nested/cargo.dart';
import '../../widgets/display/text.dart';
import '../../widgets/input/get_mac_button.dart';
import 'cargo_card.dart';
import 'chartc_card.dart';
import 'show_work.dart';
import 'tanks_card.dart';

class PerMacScreen extends StatefulWidget {
  final Aircraft air;

  PerMacScreen(this.air): super(key: PageStorageKey(UniqueKey()));

  @override
  PerMacScreenState createState() => PerMacScreenState();
}

class PerMacScreenState extends State<PerMacScreen>
    with AutomaticKeepAliveClientMixin<PerMacScreen> {
  @override
  bool get wantKeepAlive => true;

  TanksCard tanksCard;
  ChartCCard chartcCard;
  CargoCard cargoCard;
  bool valid;
  final childValid = LinkedHashMap<int, bool>();
  final sc = ScrollController();
  /// call back for tanks spiner key = tanks.id, value = nwfs
  final tanksMap = LinkedHashMap<int, Cargo>();
 

  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tanksCard = TanksCard(
      air: this.widget.air,
      callBack: (tankId,fuelNWFS){tanksMap[tankId] = fuelNWFS;}
    );
    chartcCard = ChartCCard(this.widget.air, validateChild);
    cargoCard = CargoCard(this.widget.air, validateChild);
  }

  ///passed as a callback to chartc and cargo
  ///tanks are allways valid
  void validateChild(int id, bool isChildvalid) {
    childValid[id] = isChildvalid;

    var ret = true;
    ////print(childValid.toString());
    childValid.forEach((_, childValid) {
      if (!childValid) {
        ret = false;
      }
    });
    valid = ret;
  }

  getPerMac() {
    if (valid) {
      List<Cargo> nwfs = [];
      nwfs.add(chartcCard.nwfs);
      nwfs.addAll(tanksMap.values);
      //check for no cargo
      if (cargoCard.getNWfs().length > 0) {
        nwfs.addAll(cargoCard.getNWfs());
      }
      showWork(nwfs);
    } else {
      showError();
    }
  }

  void showError(){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: modalPickerColor,
          content: Container(
            key: Key('per mac error'),
              height: pickerHeight * 2,
              child: Center(
                  child: Tex(
                'Invalid Chart C / Cargo',
                fontWeight: FontWeight.bold,
                color: nonfocusedErrorBoderColor,
              )))));
  }

  void showWork(List<Cargo> nwfs){
    Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowWork(
                    mommultipler: this.widget.air.momMultiplier,
                    lemac: this.widget.air.lemac,
                    mac: this.widget.air.mac,
                    nwfs: nwfs,
                  )));
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return 
    CupertinoScrollbar(
        isAlwaysShown: true,
        controller: sc,
        child:
         SingleChildScrollView(
          controller: sc, //wrapper to  prevent jitter on scroll
          child:Column(children: [
              tanksCard,
              chartcCard,
              cargoCard,
              GetMacButton(text: 'Show MAC%', onPressed: getPerMac),
            ])));
  }
}
