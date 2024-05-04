class Clothing {
  String id;
  String quantity;
  String name;
  String price;
  String size;
  String color;
  String description;
  String image;
  String category;
  String discount;

  Clothing({
    required this.id,
    required this.quantity,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.color,
    required this.size,
    required this.price,
    this.discount = '0',
  });

  // Define a fromMap constructor to create a Recipe object from a map
  factory Clothing.fromJson(Map<String, dynamic> map) {
    return Clothing(
      id: map['id'],
      quantity: map['quantity'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      category: map['category'],
      discount: map['discount'],
      color: map['color'],
      size: map['size'],
      price: map['price'],
    );
  }

  // Define a toMap method to convert a Recipe object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'name': name,
      'description': description,
      'image': image,
      'category': category,
      'discount': discount,
      'color': color,
      'size': size,
      'price': price,
    };
  }
}
