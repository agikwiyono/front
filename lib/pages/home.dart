import 'package:flutter/material.dart';
// IMPORT FILE BARU
import 'brand_selector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color primaryColor = const Color(0xFF1E3C72);
  // Hapus currentIndex di sini karena sudah diatur di MainPage
  String selectedBrand = "Toyota";

  // --- DATA MOBIL (Tetap sama seperti sebelumnya) ---
  final List<Map<String, String>> toyotaCars = [
    {
      "name": "Rush 2023",
      "type": "SUV",
      "rating": "4.8",
      "price": "Rp 600rb/hari",
      "image":
          "https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&fit=crop&w=500&q=80",
    },
    {
      "name": "Fortuner 2022",
      "type": "SUV",
      "rating": "4.9",
      "price": "Rp 1.2jt/hari",
      "image":
          "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=500&q=80",
    },
    {
      "name": "Corolla Cross",
      "type": "Hybrid",
      "rating": "5.0",
      "price": "Rp 900rb/hari",
      "image":
          "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?auto=format&fit=crop&w=500&q=80",
    },
    {
      "name": "Avanza 2015",
      "type": "MPV",
      "rating": "4.6",
      "price": "Rp 300rb/hari",
      "image":
          "https://images.unsplash.com/photo-1623869675781-80aa31012a5a?auto=format&fit=crop&w=500&q=80",
    },
    {
      "name": "Innova 2021",
      "type": "MPV",
      "rating": "4.8",
      "price": "Rp 750rb/hari",
      "image":
          "https://images.unsplash.com/photo-1593546358165-28a446274c26?auto=format&fit=crop&w=500&q=80",
    },
  ];

  // ... (Data Honda, Mitsubishi, Suzuki, Hyundai tetap sama seperti kode sebelumnya) ...

  List<Map<String, String>> get activeCars {
    switch (selectedBrand) {
      case "Toyota":
        return toyotaCars;
      // Tambahkan case brand lain di sini jika data sudah dimasukkan kembali
      default:
        return toyotaCars;
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

  @override
  Widget build(BuildContext context) {
    // PERBAIKAN: Gunakan Scaffold minimalis tanpa BottomNavigationBar
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearch(),
            _buildPromo(),
            const SizedBox(height: 30),
            BrandSelector(
              selectedBrand: selectedBrand,
              onBrandSelected: _handleBrandTap,
              primaryColor: primaryColor,
            ),
            const SizedBox(height: 25),
            _buildCarCategoryList(),
            const SizedBox(height: 30), // Ukuran disesuaikan
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {},
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Lokasi",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Row(
            children: const [
              Icon(Icons.location_on, color: Colors.red, size: 16),
              SizedBox(width: 4),
              Text(
                " Jakarta, ID",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
          ),
        ),
      ],
    );
  }

  // ... (Gunakan fungsi _buildSearch, _buildPromo, _buildCarCategoryList, dan _buildPremiumCarCard yang sama seperti sebelumnya) ...

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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari mobil impian...",
                  prefixIcon: Icon(Icons.search, color: primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildPromo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, primaryColor.withOpacity(0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Diskon 20%\nKhusus Mahasiswa",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Klaim Sekarang",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.directions_car_filled,
              color: Colors.white30,
              size: 70,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarCategoryList() {
    final grouped = groupedCars;
    return Column(
      children: grouped.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "${entry.key} $selectedBrand",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: entry.value.length,
                itemBuilder: (context, index) =>
                    _buildPremiumCarCard(entry.value[index]),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildPremiumCarCard(Map<String, String> car) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              car['image']!,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  car['price']!,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
