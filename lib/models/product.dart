// lib/models/product.dart
class Product {
  final int id;
  final String name;
  final String description;
  final String image;
  final int price;
  final String category;
  final String type;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
    required this.type,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      category: json['category'],
      type: json['type'],
    );
  }
}