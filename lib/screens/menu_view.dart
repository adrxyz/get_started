import 'package:flutter/material.dart';
import 'detailed_item_view.dart'; // Make sure this path is correct

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  int _selectedCategoryIndex = 4; // 'Sushi' is the selected category
  int _selectedFoodTypeIndex = 1; // 'Veggie' is the selected food type

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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Soup',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            _buildSoupMenuGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 70, // Adjusted height for a more compact design
      color: const Color(0xFF1A237E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _categoryIconChip(0, Icons.ramen_dining, 'Noodles'),
          _categoryIconChip(1, Icons.rice_bowl, 'Rice'),
          _categoryIconChip(2, Icons.lunch_dining, 'Soup'),
          _categoryIconChip(3, Icons.local_florist, 'Salat'),
          _categoryIconChip(4, Icons.tapas, 'Sushi'),
        ],
      ),
    );
  }

  Widget _buildFoodTypeTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _foodTypeChip(0, 'Seafood'),
          _foodTypeChip(1, 'Veggie'),
          _foodTypeChip(2, 'Meat'),
          _foodTypeChip(3, 'Poultry'),
        ],
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
                    color: Color(0xFFE57373), // A light red color
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

  Widget _buildSoupMenuGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildMenuItem(
            'Miso',
            'Ramen, lotus root, daikon, radish, shiitake, garlic...',
            'assets/images/image_1.png',
            4),
        _buildMenuItem(
            'Chicken noodle',
            'Ramen, pumpkin, greens, nori, tomatoes, chili...',
            'assets/images/image_2.png',
            5),
        _buildMenuItem(
            'Spicy',
            'Ramen, vegetable broth, basil, paprika, carrot...',
            'assets/images/image_3.png',
            5),
        _buildMenuItem(
            'Tonkatsu',
            'Ramen, vegetable broth, bean sprouts, carrots...',
            'assets/images/image_4.png',
            4),
      ],
    );
  }

  Widget _buildMenuItem(
      String name, String description, String imagePath, int price) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailView(
              itemName: name,
              itemImage: imagePath,
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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Center(
                    child: ClipOval(
                      child: Image.asset(imagePath,
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