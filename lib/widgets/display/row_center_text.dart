import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant.dart';
import '../layout/align_padding.dart';

class RowCenterText extends StatelessWidget {
  final String w;
  RowCenterText(this.w) : assert(w != null);

  @override
  Widget build(BuildContext context) {
    return AlignPadding(
        rowInset,
        Alignment.center,
        SelectableLinkify(
            cursorColor: Colors.white,
            showCursor: true,
            style: TextStyle(
                color: textColor,
                fontSize: textSize,
                fontWeight: FontWeight.normal),
            text: w,
            options: LinkifyOptions(humanize: false),
            onOpen: (link) async {
              if (await canLaunch(link.url)) {
                await launch(link.url);
              } else {
                throw 'Could not launch $link';
              }
            }));
  }
}
