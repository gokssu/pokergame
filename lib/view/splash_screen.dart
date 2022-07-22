import 'package:flutter/material.dart';
import 'package:pokergame/view/constants/context_extension.dart';
import 'package:pokergame/view/widgets/background_widget.dart';
import 'package:pokergame/view/widgets/gradient_button.dart';
import 'package:pokergame/view/widgets/textfield_custom.dart';

import 'constants/color.dart';
import 'constants/size.dart';
import 'constants/string_values.dart';
import 'game_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController player1 = new TextEditingController();
  TextEditingController player2 = new TextEditingController();

  playGame(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => GameScreen()),
            (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundMain(
        bodyWidget: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(StringValuesConstants.instance.projectName,
                        style: Theme.of(context).textTheme.headline3),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child:Container(
                    width: context.dynamicMultiWidth(0.7),
                    height: context.dynamicMultiHeight(0.5),
                    padding: EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor.withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).hintColor.withOpacity(0.3),
                              offset: Offset(0, 10),
                              blurRadius: 20)
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                                style:
                                Theme.of(context).textTheme.headline1,
                                keyboardType: TextInputType.text,
                                controller: player1,
                                textInputAction: TextInputAction.next,
                              decoration: TextFieldAuth().decoration(
                                context,
                                StringValuesConstants.instance.player1,),),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              style: Theme.of(context).textTheme.headline1,
                              keyboardType: TextInputType.text,
                              controller: player2,
                              decoration: TextFieldAuth().decoration(
                                  context,
                                StringValuesConstants.instance.player2,),
                            ),
                          ),
                          Padding(
                            padding:
                            PaddingConstants.instance.onlyTop,
                            child:  GradientButton(
                              widthButton:
                              context.dynamicMultiWidth(0.3),
                              heightButton:
                              context.dynamicMultiHeight(0.07),
                              onPressFunc: playGame,
                              startColor: ColorConstants.instance.graStart,
                              endColor: ColorConstants.instance.graEnd,
                              title: StringValuesConstants.instance.startGame,
                            ),
                          ),
                        ],
                      ),
                    ))
              ),
              Expanded(
                  flex: 2,
                  child:SizedBox()
              )
            ],
          ),
        ),
      ),
    );
  }
}
