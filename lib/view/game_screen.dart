import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pokergame/store/deck_model.dart';
import 'package:pokergame/store/player_model.dart';
import 'package:pokergame/view/constants/context_extension.dart';
import 'package:pokergame/view/widgets/background_widget.dart';
import 'package:pokergame/view/widgets/gradient_button.dart';
import 'package:pokergame/view/widgets/hand_widget.dart';

import '../redux/app_state.dart';
import 'constants/color.dart';
import 'constants/size.dart';
import 'constants/string_values.dart';

class GameScreen extends StatefulWidget {
  const GameScreen();

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundMain(
      bodyWidget: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SingleChildScrollView(
            child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, stateModel) => Column(
                children: <Widget>[
                  SizedBox(
                    width: context.dynamicMultiWidth(0.95),
                    height: context.dynamicMultiHeight(0.015),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: PaddingConstants.instance.onlyRightMin,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.replay,
                                size: Sizes.iconSizeMax,
                                color: ColorConstants.instance.white,
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: context.dynamicMultiWidth(0.95),
                    height: context.dynamicMultiHeight(0.15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: context.dynamicMultiHeight(0.14),
                          width: context.dynamicMultiHeight(0.1),
                          child: Image.asset(
                            'assets/deck.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(StringValuesConstants.instance.deck + stateModel.deckModel.deckList.length.toString(), style: Theme.of(context).textTheme.headline3),
                        Padding(
                          padding: PaddingConstants.instance.onlyTop,
                          child: GradientButton(
                            widthButton: context.dynamicMultiWidth(0.4),
                            heightButton: context.dynamicMultiHeight(0.06),
                            onPressFunc: () {},
                            startColor: ColorConstants.instance.graStart2,
                            endColor: ColorConstants.instance.blueColor,
                            title: StringValuesConstants.instance.compHand,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: context.dynamicMultiWidth(0.95),
                    height: context.dynamicMultiHeight(0.1),
                    child: Column(
                      children: [
                        Visibility(
                          visible: true,
                          child: showCards(stateModel.players.first.playerName),
                        ),
                        Visibility(
                          visible: false,
                          child: chooseCard(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: context.dynamicMultiWidth(0.95),
                    height: context.dynamicMultiHeight(0.25),
                    child: Padding(
                      padding: PaddingConstants.instance.onlyBottom,
                      child: HandWidget(),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: SizedBox(
                      width: context.dynamicMultiWidth(0.95),
                      height: context.dynamicMultiHeight(0.07),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Player A " + StringValuesConstants.instance.winner, style: Theme.of(context).textTheme.headline3),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.dynamicMultiWidth(0.95),
                    height: context.dynamicMultiHeight(0.1),
                    child: Padding(
                      padding: PaddingConstants.instance.onlyTopMin,
                      child: Column(
                        children: [
                          Visibility(
                            visible: true,
                            child: showCards(stateModel.players[1].playerName),
                          ),
                          Visibility(
                            visible: false,
                            child: chooseCard(),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.dynamicMultiWidth(0.95),
                    height: context.dynamicMultiHeight(0.25),
                    child: HandWidget(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget chooseCard() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text("Hand Name " + "\n" + StringValuesConstants.instance.chooseCard, style: Theme.of(context).textTheme.headline2),
        Padding(
          padding: PaddingConstants.instance.onlyTop,
          child: GradientButton(
            widthButton: context.dynamicMultiWidth(0.4),
            heightButton: context.dynamicMultiHeight(0.05),
            onPressFunc: () {},
            startColor: ColorConstants.instance.button,
            endColor: ColorConstants.instance.button,
            title: StringValuesConstants.instance.changeCards,
          ),
        ),
      ],
    );
  }

  Widget showCards(String name) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(name, style: Theme.of(context).textTheme.headline3),
        Padding(
          padding: PaddingConstants.instance.onlyTop,
          child: GradientButton(
            widthButton: context.dynamicMultiWidth(0.4),
            heightButton: context.dynamicMultiHeight(0.05),
            onPressFunc: () {},
            startColor: ColorConstants.instance.graStart2,
            endColor: ColorConstants.instance.graEnd2,
            title: StringValuesConstants.instance.showhand,
          ),
        ),
      ],
    );
  }

  Widget cardWidget() {
    return FlipCard(
      fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL, // default
      front: Container(
        height: context.dynamicMultiWidth(0.2),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorConstants.instance.accentColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.only(
          right: 2,
        ),
        child: Image.asset(
          'assets/Clubs2.jpg',
          fit: BoxFit.fitWidth,
        ),
      ),
      back: Container(
        width: context.dynamicMultiWidth(0.3),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorConstants.instance.backgroudColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.only(
          right: 2,
        ),
        child: Image.asset(
          'assets/back_card.png',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
