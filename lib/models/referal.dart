class Referal {
  String profilePicture;
  String createdAt;
  String name;

  Referal({this.profilePicture, this.createdAt, this.name});

  Referal.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    name = json['name'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['profile_picture'] = this.profilePicture;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    return data;
  }

  getImageUrls() => profilePicture != null
      ? "http://13.52.150.132$profilePicture"
      : profilePicture;
}
