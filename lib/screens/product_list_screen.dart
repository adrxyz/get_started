// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // Product data model
// class Product {
//   final int id;
//   final String name;
//   final String image;
//   final String description;
//   final int price;

//   const Product({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.description,
//     required this.price,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       image: json['image'] as String,
//       description: json['description'] as String,
//       price: json['price'] as int,
//     );
//   }
// }

// // Function to parse the list of products from the JSON response
// List<Product> parseProducts(String responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<Product>((json) => Product.fromJson(json)).toList();
// }

// // Function to fetch the products from the API
// Future<List<Product>> fetchProducts() async {
//   // Use the correct URL for Android emulator to connect to localhost
//   final response = await http.get(Uri.parse('http://10.0.2.2:3000/products'));

//   if (response.statusCode == 200) {
//     return parseProducts(response.body);
//   } else {
//     throw Exception('Failed to load products');
//   }
// }

// // Widget to display the list of products
// class ProductScreen extends StatefulWidget {
//   const ProductScreen({Key? key}) : super(key: key);

//   @override
//   _ProductScreenState createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   late Future<List<Product>> futureProducts;

//   @override
//   void initState() {
//     super.initState();
//     futureProducts = fetchProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Products'),
//       ),
//       body: FutureBuilder<List<Product>>(
//         future: futureProducts,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final product = snapshot.data![index];
//                 return ListTile(
//                   title: Text(product.name),
//                   subtitle: Text('\$${product.price}'),
//                   leading: Image.network(
//                     product.image,
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return const Icon(Icons.broken_image, size: 50);
//                     },
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ItemDetailView(
//                           itemName: product.name,
//                           itemImage: product.image,
//                           itemDescription: product.description,
//                           itemPrice: product.price,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text('No products found.'));
//           }
//         },
//       ),
//     );
//   }
// }

// // Widget for the product detail view
// class ItemDetailView extends StatelessWidget {
//   final String itemName;
//   final String itemImage;
//   final String itemDescription;
//   final int itemPrice;

//   const ItemDetailView({
//     required this.itemName,
//     required this.itemImage,
//     required this.itemDescription,
//     required this.itemPrice,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(itemName),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Image.network(
//                   itemImage,
//                   height: 200,
//                   fit: BoxFit.contain,
//                   errorBuilder: (context, error, stackTrace) {
//                     return const Icon(Icons.broken_image, size: 100);
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 itemName,
//                 style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 '\$${itemPrice}',
//                 style: const TextStyle(fontSize: 20, color: Colors.green),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 itemDescription,
//                 style: const TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }