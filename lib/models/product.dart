// lib/models/product.dart

class Product {
  final String name;
  final String description;
  final String image;
  final int price;

  // Add category and foodType for filtering, making them nullable
  final String? category;
  final String? foodType;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    this.category,
    this.foodType,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      // Use the null-aware operator to provide a default empty string
      name: json['name'] as String? ?? '', 
      description: json['description'] as String? ?? '',
      image: json['image'] as String? ?? '',
      
      // Safely parse the price from the JSON object.
      // The `json['price']` is a dynamic value, which can be either a String or an int.
      // First, convert it to a String, then try to parse it as an int.
      // If parsing fails (e.g., the value is not a valid number), default to 0.
      price: int.tryParse(json['price'].toString()) ?? 0, 
      
      // Safely handle category and foodType
      category: json['category'] as String?,
      foodType: json['foodType'] as String?,
    );
  }
}