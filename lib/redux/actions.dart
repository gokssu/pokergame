import 'package:pokergame/store/deck_model.dart';
import 'package:pokergame/store/hand_model.dart';

import '../store/player_model.dart';

class DistributeCardsAction {
  final DeckModel deckModel;
  DistributeCardsAction(this.deckModel);
}

class ChangeHandAction {
  final PlayerModel playerModel;
  ChangeHandAction(this.playerModel);
}

class ShowHandAction {
  final String showPlayerName;
  ShowHandAction(this.showPlayerName);
}

class ComparePlayerAction {
  final List<PlayerModel> players;
  ComparePlayerAction(this.players);
}


class DefinePlayerNameAction {
  String playerName1,playerName2;
  DefinePlayerNameAction(this.playerName1,this.playerName2);
}


