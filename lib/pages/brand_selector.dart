import 'package:flutter/material.dart';

// Class ini berdiri sendiri, jadi primaryColor dimiliki oleh class ini
// bukan mengambil dari home.dart
class BrandSelector extends StatelessWidget {
  final String selectedBrand;
  final Function(String) onBrandSelected;
  final Color primaryColor; // Kita terima warna lewat Constructor

  const BrandSelector({
    super.key,
    required this.selectedBrand,
    required this.onBrandSelected,
    required this.primaryColor, 
  });

  // Data Logo Brand
  static const List<Map<String, String>> brandData = [
    // Menggunakan Link Wikimedia yang stabil
    {"name": "Toyota", "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Toyota_logo.svg/1200px-Toyota_logo.svg.png"},
    {"name": "Honda", "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Honda_logo_2019.svg/1200px-Honda_logo_2019.svg.png"},
    {"name": "Mitsubishi", "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Mitsubishi_logo.svg/1200px-Mitsubishi_logo.svg.png"},
    {"name": "Suzuki", "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Suzuki_logo_2019.svg/1200px-Suzuki_logo_2019.svg.png"},
    {"name": "Hyundai", "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Hyundai_logo_2021.svg/1200px-Hyundai_logo_2021.svg.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text("Pilih Brand", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: brandData.map((brand) {
              return _buildBrandChip(brand['name']!, brand['image']!);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandChip(String label, String imageUrl) {
    bool isActive = selectedBrand == label;
    
    // Menggunakan primaryColor yang dikirim dari Parent
    final Color activeBg = primaryColor.withOpacity(0.1);
    final Color activeBorder = primaryColor;

    return GestureDetector(
      onTap: () => onBrandSelected(label),
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isActive ? activeBg : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: isActive ? activeBorder : Colors.transparent, width: 2),
              ),
              child: Image.network(
                imageUrl, 
                fit: BoxFit.contain,
                errorBuilder: (c, o, s) => const Icon(Icons.directions_car, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}