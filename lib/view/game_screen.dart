import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:pokergame/view/constants/context_extension.dart';
import 'package:pokergame/view/widgets/background_widget.dart';
import 'package:pokergame/view/widgets/gradient_button.dart';
import 'package:pokergame/view/widgets/textfield_custom.dart';

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
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: context.dynamicMultiHeight(0.1),
                          width: context.dynamicMultiHeight(0.07),
                          child: Image.asset(
                            'assets/back_card.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(StringValuesConstants.instance.deck + "42", style: Theme.of(context).textTheme.headline3),

                        Padding(
                          padding: PaddingConstants.instance.onlyTop,
                          child: GradientButton(
                            widthButton: context.dynamicMultiWidth(0.4),
                            heightButton: context.dynamicMultiHeight(0.05),
                            onPressFunc: () {},
                            startColor: ColorConstants.instance.graStart2,
                            endColor: ColorConstants.instance.blueColor,
                            title: StringValuesConstants.instance.compHand,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Visibility(
                          visible: false,
                          child: showCards("Player A"),
                        ),
                        Visibility(
                          visible: true,
                          child:chooseCard() ,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      flex:3,
                      child:Stack(
                        children: <Widget>[
                          Container(
                            width:context.dynamicMultiWidth(0.3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorConstants.instance.backgroudColor,width: 3,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(right: 2,),
                            child: Image.asset(
                              'assets/back_card.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Positioned(
                            right: -50,
                            child:  Container(
                              width:context.dynamicMultiWidth(0.3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorConstants.instance.backgroudColor,width: 3,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.only(right: 2,),
                              child: Image.asset(
                                'assets/back_card.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Positioned(
                            right: -70,
                            child:  Container(
                              width:context.dynamicMultiWidth(0.3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorConstants.instance.backgroudColor,width: 3,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.only(right: 2,),
                              child: Image.asset(
                                'assets/back_card.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Positioned(
                            left: -100,
                            child:  Container(
                              width:context.dynamicMultiWidth(0.3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorConstants.instance.backgroudColor,width: 3,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.only(right: 2,),
                              child: Image.asset(
                                'assets/back_card.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Positioned(
                            right: -250,
                            child:  Container(
                              width:context.dynamicMultiWidth(0.3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorConstants.instance.backgroudColor,width: 3,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.only(right: 2,),
                              child: Image.asset(
                                'assets/back_card.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ),
                  SizedBox(height: Sizes.sizedBox,),
                  Visibility(
                    visible: true,
                    child: Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Player A "+StringValuesConstants.instance.winner, style: Theme.of(context).textTheme.headline3),
                        ],
                      ),
                    ),

                  ),
                  SizedBox(height: Sizes.sizedBox,),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Visibility(
                          visible: true,
                          child: showCards("Player B"),
                        ),
                        Visibility(
                          visible: false,
                          child: chooseCard(),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex:3,
                      child:list()
                  ),
                  Expanded(flex:1,child: SizedBox())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget chooseCard(){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text("Hand Name "+"\n"+ StringValuesConstants.instance.chooseCard, style: Theme.of(context).textTheme.headline2),
        Padding(
          padding: PaddingConstants.instance.onlyTop,
          child: GradientButton(
            widthButton: context.dynamicMultiWidth(0.4),
            heightButton: context.dynamicMultiHeight(0.05),
            onPressFunc: () {},
            startColor: ColorConstants.instance.button,
            endColor: ColorConstants.instance. button,
            title: StringValuesConstants.instance.changeCards,
          ),
        ),
      ],
    );
  }

  Widget showCards(String name){
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

  Widget list(){
   return ListView.builder(
        itemExtent: context.dynamicMultiWidth(0.2),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child:   Container(
              height:context.dynamicMultiWidth(0.2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: index%2==0?ColorConstants.instance.backgroudColor:ColorConstants.instance.backgroudColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.only(right: 2,),
              child: Image.asset(
                'assets/back_card.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        });
  }

  Widget cardWidget(){
    return FlipCard(
      fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL, // default
      front:  Container(
        height:context.dynamicMultiWidth(0.2),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorConstants.instance.accentColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.only(right: 2,),
        child: Image.asset(
          'assets/Clubs2.jpg',
          fit: BoxFit.fitWidth,
        ),
      ),
      back:Container(
        width:context.dynamicMultiWidth(0.3),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorConstants.instance.backgroudColor,width: 3,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.only(right: 2,),
        child: Image.asset(
          'assets/back_card.png',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
