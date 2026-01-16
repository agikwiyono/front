import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            // Search Section - FIXED BOXSHADOW ERROR
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Cari mobil impian...",
                          prefixIcon: const Icon(Icons.search, color: Color(0xFF1E3C72)),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3C72),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white),
                  )
                ],
              ),
            ),

            // Banner Promo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                  ),
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
                          Text("Diskon 20%\nKhusus Pengguna Baru", 
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.2)),
                        ],
                      ),
                    ),
                    Icon(Icons.directions_car_filled, color: Colors.white30, size: 60),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Kategori", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),

            // Kategori Horizontal Scroll
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  _buildCategoryIcon(Icons.grid_view_rounded, "Semua", true),
                  _buildCategoryIcon(Icons.directions_car, "Sedan", false),
                  _buildCategoryIcon(Icons.airport_shuttle, "SUV", false),
                  _buildCategoryIcon(Icons.electric_car, "EV", false),
                  _buildCategoryIcon(Icons.sports_motorsports, "Sport", false),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Mobil Populer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text("Lihat Semua")),
                ],
              ),
            ),

            // Car List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildCarCard("Mercedes C-Class", "Luxury", "4.8", "Rp 1.2jt/hari"),
                  _buildCarCard("Toyota Alphard", "Premium", "4.9", "Rp 2.5jt/hari"),
                ],
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

  Widget _buildCategoryIcon(IconData icon, String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF1E3C72) : Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                if (!isActive) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
              ],
            ),
            child: Icon(icon, color: isActive ? Colors.white : const Color(0xFF1E3C72)),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildCarCard(String name, String type, String rating, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10)),
        ],
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