import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Brand yang sedang terpilih (default: Toyota)
  String selectedBrand = "Toyota";

  // Data Mobil Toyota
  final List<Map<String, String>> toyotaCars = [
    {"name": "Rush 2023", "type": "SUV", "rating": "4.8", "price": "Rp 600rb/hari"},
    {"name": "Fortuner 2022", "type": "SUV", "rating": "4.9", "price": "Rp 1.2jt/hari"},
    {"name": "Corolla Cross 2024", "type": "Hybrid", "rating": "5.0", "price": "Rp 900rb/hari"},
    {"name": "Calya 2018", "type": "MPV", "rating": "4.5", "price": "Rp 350rb/hari"},
    {"name": "Avanza 2015", "type": "MPV", "rating": "4.6", "price": "Rp 300rb/hari"},
    {"name": "Innova 2021", "type": "MPV", "rating": "4.8", "price": "Rp 750rb/hari"},
    {"name": "Yaris 2029", "type": "Hatchback", "rating": "4.9", "price": "Rp 550rb/hari"},
  ];

  // --- DATA BARU: Data Mobil Honda ---
  final List<Map<String, String>> hondaCars = [
    {"name": "Brio 2015", "type": "City Car", "rating": "4.5", "price": "Rp 300rb/hari"},
    {"name": "Jazz 2019", "type": "Hatchback", "rating": "4.7", "price": "Rp 450rb/hari"},
    {"name": "Honda Civic 2014", "type": "Sedan", "rating": "4.6", "price": "Rp 500rb/hari"},
    {"name": "Honda Civic Type R 2023", "type": "Sport", "rating": "5.0", "price": "Rp 2.5jt/hari"},
    {"name": "Honda WR-V 2018", "type": "SUV", "rating": "4.5", "price": "Rp 450rb/hari"},
    {"name": "Honda BR-V 2022", "type": "SUV", "rating": "4.7", "price": "Rp 550rb/hari"},
    {"name": "Honda HR-V 2023", "type": "SUV", "rating": "4.8", "price": "Rp 700rb/hari"},
    {"name": "Honda CR-V 2022", "type": "SUV", "rating": "4.8", "price": "Rp 900rb/hari"},
    {"name": "Honda Civic Hybrid 2024", "type": "Hybrid", "rating": "4.9", "price": "Rp 1.1jt/hari"},
    {"name": "Honda NSX 2025", "type": "Supercar", "rating": "5.0", "price": "Rp 10jt/hari"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.notes_rounded, color: Colors.black, size: 28),
          onPressed: () {},
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFF1E3C72),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
              ),
            ),
          ),
        ],
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Lokasi Anda", style: TextStyle(color: Colors.grey, fontSize: 12)),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 14),
                Text(" Jakarta, Indonesia", 
                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Search Section ---
            _buildSearchSection(),

            // --- Banner Promo ---
            _buildPromoBanner(),

            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Cari Berdasarkan Brand", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),

            // --- Kategori Brand ---
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Row(
                children: [
                  _buildBrandIcon("Toyota", "https://www.carlogos.org/car-logos/toyota-logo-2020-640.png"),
                  _buildBrandIcon("Honda", "https://www.carlogos.org/car-logos/honda-logo-1700x1150.png"),
                  _buildBrandIcon("Mitsubishi", "https://www.carlogos.org/car-logos/mitsubishi-logo-2100x1900.png"),
                  _buildBrandIcon("Suzuki", "https://www.carlogos.org/car-logos/suzuki-logo-1800x1800.png"),
                  _buildBrandIcon("Hyundai", "https://www.carlogos.org/car-logos/hyundai-logo-1900x950.png"),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mobil $selectedBrand Populer", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text("Lihat Semua")),
                ],
              ),
            ),

            // --- LOGIKA PERUBAHAN LIST MOBIL ---
            // Jika Toyota -> tampilkan list Toyota
            // Jika Honda -> tampilkan list Honda
            // Selain itu -> tampilkan pesan placeholder
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: selectedBrand == "Toyota" 
                  ? toyotaCars.map((car) => _buildCarCard(car['name']!, car['type']!, car['rating']!, car['price']!)).toList()
                  : selectedBrand == "Honda"
                      ? hondaCars.map((car) => _buildCarCard(car['name']!, car['type']!, car['rating']!, car['price']!)).toList()
                      : [const Center(child: Padding(padding: EdgeInsets.all(20), child: Text("Data mobil untuk brand ini belum tersedia")))],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF1E3C72),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Sewa"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }

  // Widget Bagian Pencarian
  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari mobil impian...",
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF1E3C72)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFF1E3C72), borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.tune, color: Colors.white),
          )
        ],
      ),
    );
  }

  // Widget Banner Promo
  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF1E3C72), Color(0xFF2A5298)]),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Limited Offer", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  SizedBox(height: 10),
                  Text("Diskon 20%\nKhusus Pengguna Baru", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.2)),
                ],
              ),
            ),
            Icon(Icons.directions_car_filled, color: Colors.white30, size: 60),
          ],
        ),
      ),
    );
  }

  // Widget Brand Icon
  Widget _buildBrandIcon(String label, String imageUrl) {
    bool isSelected = selectedBrand == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBrand = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF1E3C72).withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? const Color(0xFF1E3C72) : Colors.transparent, width: 2),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.w600, color: isSelected ? const Color(0xFF1E3C72) : Colors.black87)),
          ],
        ),
      ),
    );
  }

  // Widget Kartu Mobil
  Widget _buildCarCard(String name, String type, String rating, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: NetworkImage('https://img.daisyui.com/images/stock/photo-1605379399642-870262d3d051.webp'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: const TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 14),
                    Text(" $rating", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                Text(price, style: const TextStyle(color: Color(0xFF1E3C72), fontWeight: FontWeight.w900, fontSize: 14)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFF1E3C72), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.add, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }
}