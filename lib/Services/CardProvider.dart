class CardProvider {
  // How do ensure this can only be instantiated once!?
  // TODO: should _probably_ just have a Card class, that keeps whether or not it's
  // available rather than (string, bool) pairs..

  Map<String, bool> availableSpades = {
    'AS.jpg': true, '2S.jpg': true, '3S.jpg': true, '4S.jpg': true, '5S.jpg': true,
    '6S.jpg': true, '7S.jpg': true, '8S.jpg': true, '9S.jpg': true,'10S.jpg': true,
    'JS.jpg': true,'QS.jpg': true,'KS.jpg': true
  };

  Map<String, bool> availableClubs = {
    'AC.jpg': true, '2C.jpg': true, '3C.jpg': true, '4C.jpg': true, '5C.jpg': true,
    '6C.jpg': true, '7C.jpg': true, '8C.jpg': true, '9C.jpg': true,'10C.jpg': true,
    'JC.jpg': true,'QC.jpg': true,'KC.jpg': true
  };

  Map<String, bool> availableDiamonds = {
    'AD.jpg': true, '2D.jpg': true, '3D.jpg': true, '4D.jpg': true, '5D.jpg': true,
    '6D.jpg': true, '7D.jpg': true, '8D.jpg': true, '9D.jpg': true,'10D.jpg': true,
    'JD.jpg': true,'QD.jpg': true,'KD.jpg': true
  };

  Map<String, bool> availableHearts = {
    'AH.jpg': true, '2H.jpg': true, '3H.jpg': true, '4H.jpg': true, '5H.jpg': true,
    '6H.jpg': true, '7H.jpg': true, '8H.jpg': true, '9H.jpg': true,'10H.jpg': true,
    'JH.jpg': true,'QH.jpg': true,'KH.jpg': true
  };


  List<String> getAvailableCards() {
    // This is gross but whatever
    List<String> result = [];
    for (var card in availableSpades.entries) {
      if (card.value == true) {
        result.add(card.key);
      }
    }

    for (var card in availableClubs.entries) {
      if (card.value == true) {
        result.add(card.key);
      }
    }

    for (var card in availableDiamonds.entries) {
      if (card.value == true) {
        result.add(card.key);
      }
    }

    for (var card in availableHearts.entries) {
      if (card.value == true) {
        result.add(card.key);
      }
    }
    return result;
  }

  String getBackCard() {
    return 'Red_back.jpg';
  }

  void setCardAvailable(String card) {
    // TODO: better handling of poor data
    _getSuitMapFromCard(card)[card] = true;
  }

  void setCardUnavailable(String card) {
    // TODO: better handling of poor data
    _getSuitMapFromCard(card)[card] = false;
  }

  // Is underscore _camelCase appropriate naming for private methods or something..?
  Map<String, bool> _getSuitMapFromCard(String card) {
    // These 2 should be one line lol
    var cardId = card.substring(0, card.indexOf('.'));
    var suit = cardId.substring(cardId.length - 1);
    
    return getSuitMapForSuit(suit);
  }
  
  Map<String, bool> getSuitMapForSuit(String suit) {
    // TODO: add validation for suit being valid..
    // Maybe enums would be appropriate if that's a thing in flutter..?

    if (suit == 'S') {
      return availableSpades;
    } else if (suit == 'C') {
      return availableClubs;
    } else if (suit == 'D') {
      return availableDiamonds;
    } else if (suit == 'H') {
      return availableHearts;
    } else {
      // Not that I have bothered with any error handling lol
      throw("Could not resolve suit $suit");
    }
  }
}