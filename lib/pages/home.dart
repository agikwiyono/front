import 'package:flutter/material.dart';
// IMPORT INI WAJIB ADA DI BARIS KEDUA
import 'profile_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color primaryColor = const Color(0xFF1E3C72);
  int currentIndex = 0; 
  String selectedBrand = "Toyota";

  final List<Map<String, String>> toyotaCars = [
    {"name": "Rush 2023", "type": "SUV", "rating": "4.8", "price": "Rp 600rb/hari", "image": "https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&w=500&q=80"},
    {"name": "Fortuner 2022", "type": "SUV", "rating": "4.9", "price": "Rp 1.2jt/hari", "image": "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=500&q=80"},
    {"name": "Corolla Cross", "type": "Hybrid", "rating": "5.0", "price": "Rp 900rb/hari", "image": "https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&fit=crop&w=500&q=80"},
    {"name": "Avanza 2015", "type": "MPV", "rating": "4.6", "price": "Rp 300rb/hari", "image": "https://images.unsplash.com/photo-1623869675781-80aa31012a5a?auto=format&fit=crop&w=500&q=80"},
    {"name": "Innova 2021", "type": "MPV", "rating": "4.8", "price": "Rp 750rb/hari", "image": "https://images.unsplash.com/photo-1609521263047-f8f205293f24?auto=format&fit=crop&w=500&q=80"},
  ];

  final List<Map<String, String>> hondaCars = [
    {"name": "Brio 2015", "type": "City Car", "rating": "4.5", "price": "Rp 300rb/hari", "image": "https://images.unsplash.com/photo-1619682817481-e994891cd1f5?auto=format&fit=crop&w=500&q=80"},
    {"name": "Jazz 2019", "type": "Hatchback", "rating": "4.7", "price": "Rp 450rb/hari", "image": "https://images.unsplash.com/photo-1541899481282-d53bffe3c35d?auto=format&fit=crop&w=500&q=80"},
    {"name": "Civic Type R", "type": "Sport", "rating": "5.0", "price": "Rp 2.5jt/hari", "image": "https://images.unsplash.com/photo-1544636331-e26879cd4d9b?auto=format&fit=crop&w=500&q=80"},
    {"name": "HR-V 2023", "type": "SUV", "rating": "4.8", "price": "Rp 700rb/hari", "image": "https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?auto=format&fit=crop&w=500&q=80"},
    {"name": "CR-V 2022", "type": "SUV", "rating": "4.8", "price": "Rp 900rb/hari", "image": "https://images.unsplash.com/photo-1568844293986-8c1a5f8e0d97?auto=format&fit=crop&w=500&q=80"},
  ];

  final List<Map<String, String>> mitsubishiCars = [
    {"name": "Pajero Sport", "type": "SUV", "rating": "4.8", "price": "Rp 1jt/hari", "image": "https://images.unsplash.com/photo-1519245659620-e859806a8d3b?auto=format&fit=crop&w=500&q=80"},
    {"name": "Xpander 2021", "type": "MPV", "rating": "4.7", "price": "Rp 450rb/hari", "image": "https://images.unsplash.com/photo-1617531653332-bd46c24f2068?auto=format&fit=crop&w=500&q=80"},
    {"name": "Outlander PHEV", "type": "Hybrid", "rating": "4.9", "price": "Rp 1.2jt/hari", "image": "https://images.unsplash.com/photo-1494976388531-d1058494cdd8?auto=format&fit=crop&w=500&q=80"},
  ];

  final List<Map<String, String>> suzukiCars = [
    {"name": "Ertiga 2016", "type": "MPV", "rating": "4.7", "price": "Rp 450rb/hari", "image": "https://images.unsplash.com/photo-1609521263047-f8f205293f24?auto=format&fit=crop&w=500&q=80"},
    {"name": "Jimny 2023", "type": "SUV", "rating": "4.9", "price": "Rp 800rb/hari", "image": "https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?auto=format&fit=crop&w=500&q=80"},
    {"name": "Ignis 2016", "type": "City Car", "rating": "4.6", "price": "Rp 300rb/hari", "image": "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?auto=format&fit=crop&w=500&q=80"},
  ];

  final List<Map<String, String>> hyundaiCars = [
    {"name": "Creta 2023", "type": "SUV", "rating": "4.7", "price": "Rp 650rb/hari", "image": "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=500&q=80"},
    {"name": "Stargazer", "type": "MPV", "rating": "4.6", "price": "Rp 550rb/hari", "image": "https://images.unsplash.com/photo-1623869675781-80aa31012a5a?auto=format&fit=crop&w=500&q=80"},
    {"name": "Ioniq 5", "type": "Electric", "rating": "4.9", "price": "Rp 1.5jt/hari", "image": "https://images.unsplash.com/photo-1593941707882-a5bba14938c7?auto=format&fit=crop&w=500&q=80"},
    {"name": "Santa Fe", "type": "SUV", "rating": "4.8", "price": "Rp 1.2jt/hari", "image": "https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&w=500&q=80"},
  ];

  List<Map<String, String>> get activeCars {
    switch (selectedBrand) {
      case "Toyota": return toyotaCars;
      case "Honda": return hondaCars;
      case "Mitsubishi": return mitsubishiCars;
      case "Suzuki": return suzukiCars;
      case "Hyundai": return hyundaiCars;
      default: return [];
    }
  }

  Map<String, List<Map<String, String>>> get groupedCars {
    Map<String, List<Map<String, String>>> grouped = {};
    for (var car in activeCars) {
      String type = car['type'] ?? 'Lainnya';
      if (!grouped.containsKey(type)) {
        grouped[type] = [];
      }
      grouped[type]!.add(car);
    }
    return grouped;
  }

  void _handleBrandTap(String brandName) {
    setState(() {
      selectedBrand = brandName;
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: (currentIndex == 0) ? _buildAppBar() : null,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Container(
            color: const Color(0xFFF8FAFC),
            child: _getCurrentPageContent(), 
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- LOGIC Navigasi ada di sini, bukan di file profil ---
  Widget _getCurrentPageContent() {
    switch (currentIndex) {
      case 0: return _buildHomeContent();
      case 1: return _buildPlaceholderContent("Sewa Mobil");
      case 2: return _buildPlaceholderContent("Favorit");
      
      default: return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearch(),
          _buildPromo(),
          const SizedBox(height: 30),
          _BrandSelector(selectedBrand: selectedBrand, onBrandSelected: _handleBrandTap),
          const SizedBox(height: 25),
          _buildCarCategoryList(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildPlaceholderContent(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 20),
          Text("Halaman $title\nSedang dalam pengembangan", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(icon: const Icon(Icons.menu, color: Colors.black), onPressed: () {}),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Lokasi", style: TextStyle(color: Colors.grey, fontSize: 12)),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red, size: 16),
              const SizedBox(width: 4),
              Text(" Jakarta, ID", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
          ),
        )
      ],
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari mobil impian...",
                  prefixIcon: Icon(Icons.search, color: primaryColor),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.tune, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _buildPromo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, primaryColor.withOpacity(0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 15, offset: Offset(0, 10))],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                    child: const Text("Promo Spesial", style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ),
                  const SizedBox(height: 10),
                  const Text("Diskon 20%\nKhusus Mahasiswa", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.2)),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Text("Klaim Sekarang", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.directions_car_filled, color: Colors.white30, size: 70),
          ],
        ),
      ),
    );
  }

  Widget _buildCarCategoryList() {
    final grouped = groupedCars;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: grouped.entries.map((entry) {
        String category = entry.key;
        List<Map<String, String>> cars = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$category $selectedBrand", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text("Lihat Semua", style: TextStyle(fontSize: 12))),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  return _buildModernCarCard(cars[index]);
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildModernCarCard(Map<String, String> car) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                child: Image.network(
                  car['image']!,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, o, s) => Container(height: 120, color: Colors.grey[200], child: Icon(Icons.error)),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 12),
                      const SizedBox(width: 4),
                      Text(car['rating']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(car['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(car['price']!, style: TextStyle(color: primaryColor, fontWeight: FontWeight.w800, fontSize: 13)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), shape: BoxShape.circle),
                      child: Icon(Icons.favorite_border, size: 16, color: primaryColor),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.add, color: Colors.white, size: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: currentIndex, 
      onTap: _onBottomNavTap, 
      selectedItemColor: primaryColor,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.key), label: "Sewa"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
      ],
    );
  }
}

class _BrandSelector extends StatelessWidget {
  final String selectedBrand;
  final Function(String) onBrandSelected;

  const _BrandSelector({
    required this.selectedBrand,
    required this.onBrandSelected,
  });

  static const List<Map<String, String>> brandData = [
    {"name": "Toyota", "image": "https://logos-download.com/wp-content/uploads/2016/05/Toyota_logo_logotype.png"},
    {"name": "Honda", "image": "https://logos-download.com/wp-content/uploads/2016/05/Honda_logo_logotype.png"},
    {"name": "Mitsubishi", "image": "https://logos-download.com/wp-content/uploads/2016/10/Mitsubishi_logo.png"},
    {"name": "Suzuki", "image": "https://logos-download.com/wp-content/uploads/2016/05/Suzuki_logo_logotype.png"},
    {"name": "Hyundai", "image": "https://logos-download.com/wp-content/uploads/2016/10/Hyundai_logo_logotype.png"},
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
                color: isActive ? const Color(0xFF1E3C72).withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: isActive ? const Color(0xFF1E3C72) : Colors.transparent, width: 2),
              ),
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}