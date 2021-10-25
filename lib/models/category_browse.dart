class CategoryBrowse {
  int id;
  int categoryId;
  String title;
  String video;
  String content;
  String image;
  int cardId;
  int order;

  CategoryBrowse(
      {this.id,
      this.categoryId,
      this.title,
      this.video,
      this.content,
      this.image,
      this.cardId,
      this.order});

  CategoryBrowse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    video = json['video'];
    content = json['content'];
    image = json['image'];
    cardId = json['card_id'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['video'] = this.video;
    data['content'] = this.content;
    data['image'] = this.image;
    data['card_id'] = this.cardId;
    data['order'] = this.order;
    return data;
  }
}
