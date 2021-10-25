class SmartMix {
  String progress;
  int totalCards;
  int openCards;
  int cardsDue;

  SmartMix({this.progress, this.totalCards, this.openCards, this.cardsDue});

  SmartMix.fromJson(Map<String, dynamic> json) {
    progress = json['progress'];
    totalCards = json['total_cards'];
    openCards = json['open_cards'];
    cardsDue = json['cards_due'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['progress'] = this.progress;
    data['total_cards'] = this.totalCards;
    data['open_cards'] = this.openCards;
    data['cards_due'] = this.cardsDue;
    return data;
  }
}
