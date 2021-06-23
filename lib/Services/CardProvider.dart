class CardProvider {
  // How do ensure this can only be instantiated once!?

  Map<String, bool> availableCards = {'6D.jpg': true, '6S.jpg': true, '5H.jpg': true,
    '9H.jpg': true, '7C.jpg': true, 'AS.jpg': true, 'AD.jpg': true, '6C.jpg': true,
    '8H.jpg': true, '7D.jpg': true, '4H.jpg': true, '7S.jpg': true, 'AC.jpg': true,
    'QH.jpg': true, 'JC.jpg': true, '10D.jpg': true, '10S.jpg': true, 'KS.jpg': true,
    'KD.jpg': true, '3H.jpg': true, '2H.jpg': true, 'JS.jpg': true, 'JD.jpg': true,
    'KC.jpg': true, '10C.jpg': true, '3C.jpg': true, '2S.jpg': true, '2D.jpg': true,
    'JH.jpg': true, 'QC.jpg': true, '10H.jpg': true, 'KH.jpg': true, '3S.jpg': true,
    '3D.jpg': true, 'QS.jpg': true, 'QD.jpg': true, '2C.jpg': true, '7H.jpg': true,
    '4S.jpg': true, '4D.jpg': true, '9C.jpg': true, '5C.jpg': true, '8S.jpg': true,
    '8D.jpg': true, '9S.jpg': true, '9D.jpg': true, '4C.jpg': true, 'AH.jpg': true,
    '8C.jpg': true, '5S.jpg': true, '6H.jpg': true, '5D.jpg': true };


  Map<String, bool> getAllCards() {
    return availableCards;
  }

  List<String> getAvailableCards() {
    List<String> result = [];
    for (var card in availableCards.entries) {
      if (card.value == true) {
        result.add(card.key);
      }
    }
    return result;
  }
}