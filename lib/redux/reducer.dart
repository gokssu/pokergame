import 'dart:math';

import 'package:pokergame/store/card_model.dart';
import 'package:pokergame/store/player_model.dart';

import '../store/hand_model.dart';
import 'actions.dart';
import 'app_state.dart';

AppState PlayGame(AppState state, dynamic action) {
  //define name and distributeCards
  if (action is DistributeCardsAction) {
    List<CardModel> cardsForHand1 = [];
    List<CardModel> cardsForHand2 = [];
    while (cardsForHand1.length < 5) {
      int indexCard = Random().nextInt(action.deckModel.deckList.length);
      cardsForHand1.add(action.deckModel.deckList[indexCard]);
      action.deckModel.deckList.removeAt(indexCard);
    }
    while (cardsForHand2.length < 5) {
      int indexCard = Random().nextInt(action.deckModel.deckList.length);
      cardsForHand2.add(action.deckModel.deckList[indexCard]);
      action.deckModel.deckList.removeAt(indexCard);
    }
    int second=state.players.length - 1;
    String handName1=defineHandName(cardsForHand1);
    String handName2=defineHandName(cardsForHand2);
    return AppState(deckModel: state.deckModel, players: [
      PlayerModel(
          playerChoosenCard: state.players.first.playerChoosenCard,
          playerHand: HandModel(name: handName1, cardlist: cardsForHand1),
          playerName: state.players.first.playerName,
          isWinner: state.players.first.isWinner,
          handOpen: state.players.first.handOpen
      ),
      PlayerModel(
          playerChoosenCard: state.players[second].playerChoosenCard,
          playerHand: HandModel(name: handName2, cardlist: cardsForHand2),
          playerName: state.players[second].playerName,
          isWinner: state.players[second].isWinner,
          handOpen: state.players[second].handOpen)
    ]);
  }
  else if (action is DefinePlayerNameAction) {
    int second=state.players.length - 1;
    List<PlayerModel> playersList=[
      PlayerModel(
          playerChoosenCard: state.players.first.playerChoosenCard,
          playerHand: state.players.first.playerHand,
          playerName: action.playerName1,
          isWinner: state.players.first.isWinner,
          handOpen: state.players.first.handOpen
      ),
      PlayerModel(
          playerChoosenCard: state.players[second].playerChoosenCard,
          playerHand:  state.players[second].playerHand,
          playerName:  action.playerName2,
          isWinner: state.players[second].isWinner,
          handOpen: state.players[second].handOpen)
    ];
    return AppState(deckModel: state.deckModel, players: playersList);
  }
  return state;
}
AppState GameState(AppState state, dynamic action) {
  //show hands and changecards
  if (action is ChangeHandAction) {
    List<CardModel> cardsCange=  action.playerModel.playerChoosenCard;
    for(var item in cardsCange){
      action.playerModel.playerHand.cardlist.removeWhere((element) => element.index==item.index&&element.kind==item.kind);
    }
    while (action.playerModel.playerHand.cardlist.length < 5) {
      int indexCard = Random().nextInt(state.deckModel.deckList.length);
      action.playerModel.playerHand.cardlist.add(state.deckModel.deckList[indexCard]);
      state.deckModel.deckList.removeAt(indexCard);
    }
    state.deckModel.deckList.addAll(cardsCange);
    action.playerModel.playerChoosenCard.clear();
    int playerIndex=state.players.indexWhere((element) => element.playerName==action.playerModel.playerName);
    action.playerModel.playerHand.name=defineHandName(action.playerModel.playerHand.cardlist);
    state.players[playerIndex]=action.playerModel;
    return AppState(deckModel: state.deckModel, players:state.players);
  }
  else if (action is ShowHandAction) {
    for(var item in state.players){
      if(item.playerName==action.showPlayerName){
        //show hand
        for(var itemx in item.playerHand.cardlist){
          itemx.isOpen=true;
        }
        item.handOpen=true;
      }else{
        //hide hand
        for(var itemx in item.playerHand.cardlist){
          itemx.isOpen=false;
        }
        item.handOpen=false;
      }
    }
  return AppState(deckModel: state.deckModel, players:state.players);
  }
  return state;
}


AppState EndGame(AppState state, dynamic action) {
  //compare hands and find winner
  if (action is ComparePlayerAction) {
    int maxNumHand1=maxHandIndex(action.players.first.playerHand.cardlist);
    int maxNumHand2=maxHandIndex(action.players[1].playerHand.cardlist);
    int winnerIndex= 0;
    action.players.first.playerHand.name=defineHandName(action.players.first.playerHand.cardlist);
    action.players[1].playerHand.name=defineHandName(action.players[1].playerHand.cardlist);
    if(action.players.first.playerHand.name!=action.players[1].playerHand.name){
               String resultPlayer1 = action.players.first.playerHand.name;
               switch (action.players[1].playerHand.name) {
                 case "Poker":
                     winnerIndex= 1;
                   break;
                 case "Four of aKind":
                   if (resultPlayer1 == "Poker"||resultPlayer1 == "Full House") {
                     winnerIndex= 0;
                   } else {
                     winnerIndex= 1;
                   }
                   break;
                 case "Full House":
                   if (resultPlayer1 == "Poker") {
                     winnerIndex= 0;
                   } else {
                     winnerIndex= 1;
                   }
                   break;
                 case "Three of aKind":
                   if (resultPlayer1 == "Poker"||
                       resultPlayer1 == "Four of aKind"||
                       resultPlayer1 == "Full House") {
                     winnerIndex= 0;
                   } else {
                     winnerIndex= 1;
                   }
                   break;
                 case "Two Pair":
                   if (resultPlayer1 == "Poker"||
                       resultPlayer1 == "Four of aKind"||
                       resultPlayer1 == "Full House"||
                       resultPlayer1 == "Three of aKind") {
                     winnerIndex= 0;
                  } else {
                     winnerIndex= 1;
                  }
                  break;
                case "Pair":
                   if (resultPlayer1 == "Poker"||
                      resultPlayer1 == "Four of aKind"||
                      resultPlayer1 == "Full House"||
                      resultPlayer1 == "Three of aKind"||
                      resultPlayer1 == "Two Pair") {
                     winnerIndex= 0;
                  } else {
                     winnerIndex= 1;
                  }
                  break;
                case "None":
                  winnerIndex = 0;
                   break;
               }
    }
    else{
      switch (action.players.first.playerHand.name) {
        case "Poker":
          winnerIndex= -1;
          break;
        case "Four of aKind":
          if (maxNumHand1>maxNumHand2) {
            winnerIndex= 0;
          } else {
            winnerIndex= 1;
          }
          break;
        case "Full House":
          //define index list for hands
           List<int> hand1= getListInt(action.players.first.playerHand.cardlist);
           List<int> hand2= getListInt(action.players[1].playerHand.cardlist);
           int hand1Num =0;
           int hand2Num =0;
           //find which index repeat three times on hand
           for (var i in hand1) {
             if(hand1.where((element) => element==i).toList().length==3){
               hand1Num=i;
             }
           }
           for (var i in hand2) {
             if(hand2.where((element) => element==i).toList().length==3){
               hand2Num=i;
             }
           }
           //compare three times indexes
         if(hand1Num>hand2Num){
           winnerIndex= 0;
         }else{
           winnerIndex= 1;
         }

          break;
        case "Three of aKind":
          if (maxNumHand1>maxNumHand2) {
            winnerIndex= 0;
          } else {
            winnerIndex= 1;
          }
          break;
        case "Two Pair":
        //define index list for hands
          List<int> hand1= getListInt(action.players.first.playerHand.cardlist);
          List<int> hand2= getListInt(action.players[1].playerHand.cardlist);
          int hand1Num =0;
          int hand2Num =0;
          //find which index repeat two times on hand
          for (var i in hand1) {
            if(hand1.where((element) => element==i).toList().length==2){
              //sum of indexes
              hand1Num=hand1Num+i;
            }
          }
          for (var i in hand2) {
            if(hand2.where((element) => element==i).toList().length==3){
              //sum of indexes
              hand2Num=hand2Num+i;
            }
          }
          //compare three times indexes
          if(hand1Num>hand2Num){
            winnerIndex= 0;
          }else{
            winnerIndex= 1;
          }
          break;
        case "Pair":
          if (maxNumHand1>maxNumHand2) {
            winnerIndex= 0;
          } else {
            winnerIndex= 1;
          }
          break;
        case "None":
          if (maxNumHand1>maxNumHand2) {
            winnerIndex= 0;
          } else {
            winnerIndex= 1;
          }
          break;
      }
    }
    List<PlayerModel> playersList=[
      PlayerModel(
          playerChoosenCard: state.players.first.playerChoosenCard,
          playerHand: state.players.first.playerHand,
          playerName: state.players.first.playerName,
          isWinner: state.players.first.isWinner,
          handOpen: true
      ),
      PlayerModel(
          playerChoosenCard: state.players[1].playerChoosenCard,
          playerHand:  state.players[1].playerHand,
          playerName:  state.players[1].playerName,
          isWinner: state.players[1].isWinner,
          handOpen: true)
    ];
    if(winnerIndex==0){
      playersList.first.isWinner=true;
      playersList[1].isWinner=false;
    }else if(winnerIndex==1){
      playersList.first.isWinner=false;
      playersList[1].isWinner=true;
    }else{
      playersList.first.isWinner=true;
      playersList[1].isWinner=true;
    }
    return AppState(deckModel: state.deckModel, players:playersList);
  }
  return state;
}


String defineHandName(List<CardModel> hand){
  String name="None";
//Poker-FullHouse-Four of aKind-Three of aKind-Two pairs-pairs

  // number of repeats
    int numberRepeats = 0;
  // check pokerhand
    int sequenceAs = 0;
    bool isPokerHand = false;
    bool includeAs = false;

    for (int m = 0; m < 5; m++) {
      for (int n = m + 1; n < 5; n++) {
        if (hand[m].index == hand[n].index) {
          numberRepeats = numberRepeats + 1;
        }
      }
    }



    for (var item in hand) {
      if (item.index == 14) {
        includeAs = true;
      }
    }

    if (includeAs == true) {
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 5; j++) {
          if (hand[j].index == (13 - i)) {
            sequenceAs = sequenceAs + 1;
            j = 5;
          }
        }
      }
    }
    if (sequenceAs == 4) {
      isPokerHand = true;
    }

    switch (numberRepeats) {
      case 0:
        if (isPokerHand == true) {
          name = "Poker";
        } else {
          name = "None";
        }
        break;
      case 1:
        name = "Pair";
        break;
      case 2:
        name = "Two Pair";
        break;
      case 3:
        name = "Three of aKind";
        break;
      case 4:
        name = "Full House";
        break;
      case 6:
        name = "Four of aKind";
        break;
    }
  return name;
}

int maxHandIndex(List<CardModel> hand){
  int maxNumHand=0;
  for (int i = 0; i < 5; i++) {
    for (int j = i + 1; j < 5; j++) {
      if (hand[i].index >= hand[j].index) {
        maxNumHand = hand[i].index;
        if (j == 4) {
          i = 5;
        }
      } else {
        maxNumHand = hand[j].index;
        i = j;
        j = j++;
      }
    }
  }
  return maxNumHand;
}

List<int> getListInt(List<CardModel> hand){
  List<int> handIndexList=[];
  for(var item in hand){
    handIndexList.add(item.index);
  }
  return handIndexList;
}