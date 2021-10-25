class Category {
  int id;
  String categoryName;
  int totalCards;
  int openCards;
  int cardsDue;
  String progress;

  Category(
      {this.id,
      this.categoryName,
      this.totalCards,
      this.openCards,
      this.cardsDue,
      this.progress});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    totalCards = json['total_cards'];
    openCards = json['open_cards'];
    cardsDue = json['cards_due'];
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['total_cards'] = this.totalCards;
    data['open_cards'] = this.openCards;
    data['cards_due'] = this.cardsDue;
    data['progress'] = this.progress;
    return data;
  }
}
