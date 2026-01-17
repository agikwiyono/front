import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // --- 1. KONFIGURASI & STATE ---
  final Color primaryColor = const Color(0xFF1E3C72);
  String selectedBrand = "Toyota";

  // --- DATA BRAND & LOGO (PERBAIKAN GAMBAR) ---
  // Kita buat list data agar tidak perlu menulis ulang widget brand satu per satu
  final List<Map<String, String>> brandData = [
    {
      "name": "Toyota",
      "image": "https://logos-download.com/wp-content/uploads/2016/05/Toyota_logo_logotype.png"
    },
    {
      "name": "Honda",
      "image": "https://logos-download.com/wp-content/uploads/2016/05/Honda_logo_logotype.png"
    },
    {
      "name": "Mitsubishi",
      "image": "https://logos-download.com/wp-content/uploads/2016/10/Mitsubishi_logo.png"
    },
    {
      "name": "Suzuki",
      "image": "https://logos-download.com/wp-content/uploads/2016/05/Suzuki_logo_logotype.png"
    },
    {
      "name": "Hyundai",
      "image": "https://logos-download.com/wp-content/uploads/2016/10/Hyundai_logo_logotype.png"
    },
  ];

  // --- 2. DATA MOBIL ---
  final List<Map<String, String>> toyotaCars = [
    {"name": "Rush 2023", "type": "SUV", "rating": "4.8", "price": "Rp 600rb/hari"},
    {"name": "Fortuner 2022", "type": "SUV", "rating": "4.9", "price": "Rp 1.2jt/hari"},
    {"name": "Corolla Cross 2024", "type": "Hybrid", "rating": "5.0", "price": "Rp 900rb/hari"},
    {"name": "Avanza 2015", "type": "MPV", "rating": "4.6", "price": "Rp 300rb/hari"},
    {"name": "Innova 2021", "type": "MPV", "rating": "4.8", "price": "Rp 750rb/hari"},
  ];

  final List<Map<String, String>> hondaCars = [
    {"name": "Brio 2015", "type": "City Car", "rating": "4.5", "price": "Rp 300rb/hari"},
    {"name": "Jazz 2019", "type": "Hatchback", "rating": "4.7", "price": "Rp 450rb/hari"},
    {"name": "Civic Type R 2023", "type": "Sport", "rating": "5.0", "price": "Rp 2.5jt/hari"},
    {"name": "HR-V 2023", "type": "SUV", "rating": "4.8", "price": "Rp 700rb/hari"},
    {"name": "CR-V 2022", "type": "SUV", "rating": "4.8", "price": "Rp 900rb/hari"},
  ];

  final List<Map<String, String>> mitsubishiCars = [
    {"name": "Pajero Sport 2019", "type": "SUV", "rating": "4.8", "price": "Rp 1jt/hari"},
    {"name": "Xpander 2021", "type": "MPV", "rating": "4.7", "price": "Rp 450rb/hari"},
    {"name": "Outlander PHEV 2023", "type": "Hybrid", "rating": "4.9", "price": "Rp 1.2jt/hari"},
  ];

  final List<Map<String, String>> suzukiCars = [
    {"name": "Ertiga 2016", "type": "MPV", "rating": "4.7", "price": "Rp 450rb/hari"},
    {"name": "Jimny 2023", "type": "SUV", "rating": "4.9", "price": "Rp 800rb/hari"},
    {"name": "Ignis 2016", "type": "City Car", "rating": "4.6", "price": "Rp 300rb/hari"},
  ];

  final List<Map<String, String>> hyundaiCars = [
    {"name": "Creta 2023", "type": "SUV", "rating": "4.7", "price": "Rp 650rb/hari"},
    {"name": "Stargazer 2023", "type": "MPV", "rating": "4.6", "price": "Rp 550rb/hari"},
    {"name": "Ioniq 5 2023", "type": "Electric", "rating": "4.9", "price": "Rp 1.5jt/hari"},
    {"name": "Santa Fe 2022", "type": "SUV", "rating": "4.8", "price": "Rp 1.2jt/hari"},
  ];

  // Logic Helper untuk memilih list mobil
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearch(),
            _buildPromo(),
            const SizedBox(height: 30),
            _buildBrandSelector(), // Memanggil brand selector
            const SizedBox(height: 20),
            _buildCarListTitle(),
            _buildCarList(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- UI COMPONENTS ---

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
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari mobil...",
                prefixIcon: Icon(Icons.search, color: primaryColor),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [primaryColor, primaryColor.withOpacity(0.7)]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Promo Mahasiswa", style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 5),
                  Text("Diskon 20%\nSewa Mobil", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Icon(Icons.directions_car, color: Colors.white30, size: 50),
          ],
        ),
      ),
    );
  }

  // --- BAGIAN YANG DIPERBAIKI (BRAND SELECTOR) ---
  Widget _buildBrandSelector() {
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
          // Kita menggunakan 'map' untuk me-looping data brandData
          // Ini jauh lebih efisien daripada menulis widget manual 5 kali
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
      onTap: () => setState(() => selectedBrand = label),
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Container(
              width: 60,  // Ukuran diperbesar sedikit agar logo terlihat jelas
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isActive ? primaryColor.withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: isActive ? primaryColor : Colors.transparent, width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: Offset(0,2))
                ],
              ),
              // Menampilkan Logo
              child: Image.network(
                imageUrl, 
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback jika gambar gagal load
                  return Icon(Icons.directions_car, color: Colors.grey);
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildCarListTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Mobil $selectedBrand", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TextButton(onPressed: () {}, child: const Text("Lihat Semua")),
        ],
      ),
    );
  }

  Widget _buildCarList() {
    return Column(
      children: activeCars.map((car) => _buildCarCard(car)).toList(),
    );
  }

  Widget _buildCarCard(Map<String, String> car) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
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
                Text(car['type'] ?? "", style: TextStyle(color: primaryColor, fontSize: 12)),
                Text(car['name'] ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 14),
                    const SizedBox(width: 4),
                    Text(car['rating'] ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                Text(car['price'] ?? "", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
              child: const Icon(Icons.add, color: Colors.white, size: 18),
            ),
          )
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: primaryColor,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.key), label: "Sewa"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
      ],
    );
  }
}