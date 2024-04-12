class Clothing {
  String id;
  String name;
  String description;
  String image;
  String category;
  String discount;

  Clothing({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    this.discount = '0',
  });

  // Define a fromMap constructor to create a Recipe object from a map
  factory Clothing.fromMap(Map<String, dynamic> map) {
    return Clothing(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      category: map['category'],
      discount: map['discount'],
    );
  }

  // Define a toMap method to convert a Recipe object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'category': category,
      'discount': discount,
    };
  }
}
