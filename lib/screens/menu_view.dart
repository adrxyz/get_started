// lib/views/menu_view.dart

import 'package:flutter/material.dart';
import 'package:get_started/models/product.dart';
import 'package:get_started/services/api_service.dart';
import 'detailed_item_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  int _selectedCategoryIndex = 4;
  int _selectedFoodTypeIndex = 1;

  late Future<List<Product>> _productsFuture;

  // Define the category and food type names
  final List<String> _categoryNames = ['Noodles', 'Rice', 'Soup', 'Salad', 'Sushi'];
  final List<String> _foodTypeNames = ['Seafood', 'Veggie', 'Meat', 'Poultry'];

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F0E0),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Asia',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            Row(
              children: const [
                Icon(Icons.person_outline, color: Colors.black),
                SizedBox(width: 16),
                Icon(Icons.shopping_bag_outlined, color: Colors.black),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCategoryTabs(),
            _buildFoodTypeTabs(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                _categoryNames[_selectedCategoryIndex], // Display the current category name
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products found.'));
                } else {
                  // Filter the products based on the selected category and food type
                  final String selectedCategory = _categoryNames[_selectedCategoryIndex];
                  final String selectedFoodType = _foodTypeNames[_selectedFoodTypeIndex];
                  
                  final filteredProducts = snapshot.data!.where((product) {
                    // This is where you filter the products. 
                    // Make sure your Product model has these properties.
                    return product.category == selectedCategory && product.foodType == selectedFoodType;
                  }).toList();

                  if (filteredProducts.isEmpty) {
                    return const Center(child: Text('No items found in this category.'));
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredProducts.length, // Use the filtered list here
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index]; // Use the filtered list here
                      return _buildMenuItem(
                        product.name,
                        product.description,
                        product.image,
                        product.price,
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 70,
      color: const Color(0xFF1A237E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _categoryNames.asMap().entries.map((entry) {
          int index = entry.key;
          String text = entry.value;
          return _categoryIconChip(
            index,
            _getCategoryIcon(index), // A helper method to get the icon
            text,
          );
        }).toList(),
      ),
    );
  }

  // A helper method for category icons
  IconData _getCategoryIcon(int index) {
    switch (index) {
      case 0: return Icons.ramen_dining;
      case 1: return Icons.rice_bowl;
      case 2: return Icons.lunch_dining;
      case 3: return Icons.local_florist;
      case 4: return Icons.tapas;
      default: return Icons.tapas;
    }
  }

  Widget _buildFoodTypeTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _foodTypeNames.asMap().entries.map((entry) {
          int index = entry.key;
          String text = entry.value;
          return _foodTypeChip(index, text);
        }).toList(),
      ),
    );
  }

  Widget _foodTypeChip(int index, String text) {
    bool isSelected = index == _selectedFoodTypeIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFoodTypeIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: isSelected
                ? const BorderSide(
                    color: Color(0xFFE57373),
                    width: 2.0,
                  )
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _categoryIconChip(int index, IconData icon, String text) {
    bool isSelected = index == _selectedCategoryIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isSelected ? Colors.black : Colors.white,
                ),
                if (isSelected)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      String name, String description, String imagePath, int price) {
    final fullImageUrl = 'http://10.0.2.2:3000/$imagePath';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailView(
              itemName: name,
              itemImage: fullImageUrl,
              itemDescription: description,
              itemPrice: price,
            ),
          ),
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A237E),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Center(
                    child: ClipOval(
                      child: Image.network(fullImageUrl,
                          fit: BoxFit.cover, height: 100, width: 100),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A237E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '\$$price',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.arrow_forward, color: Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}