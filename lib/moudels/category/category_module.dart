class Category{
  String id;
  String name;
  String image;

  Category({required this.id, required this.name, required this.image});

  factory Category.fromMap(Map<String, dynamic> map){
    return Category(
      name: map['name'],
      image: map['image'],
      id: map['id'] ,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'image': image,
    };
  }
}