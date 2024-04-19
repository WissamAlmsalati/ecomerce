
class BannerMoudule{

  String imageurl;


  BannerMoudule({required this.imageurl});

  factory BannerMoudule.fromJson(Map<String, dynamic> json) {
    return BannerMoudule(
      imageurl: json['imageurl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageurl': imageurl,
    };
  }
}