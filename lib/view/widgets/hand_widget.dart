import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokergame/view/constants/context_extension.dart';

import '../constants/color.dart';
import 'card_widget.dart';

class HandWidget extends StatefulWidget {
  const HandWidget();

  @override
  State<HandWidget> createState() => _HandWidgetState();
}

class _HandWidgetState extends State<HandWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: -1,
          child: CardWidget(),
        ),
        Positioned(
          left: context.dynamicMultiWidth(0.15),
          bottom: 4,
          child:  CardWidget(),
        ),
        Positioned(
          left: context.dynamicMultiWidth(0.3),
          bottom: 6,
          child:  CardWidget(),
        ),
        Positioned(
          left: context.dynamicMultiWidth(0.45),
          bottom: 4,
          child:  CardWidget(),
        ),
        Positioned(
          left: context.dynamicMultiWidth(0.6),
          bottom: -1,
          child:  CardWidget(),
        ),
      ],
    );
  }
}
