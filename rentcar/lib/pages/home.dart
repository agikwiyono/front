import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
            ),
          ),
        ],
        title: const Text(
          "RentCar",
          style: TextStyle(color: Color(0xFF1E3C72), fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Cari mobil favoritmu...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Banner Promo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Promo Spesial!", style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 5),
                    Text("Diskon 20% untuk\nsewa pertama Anda", 
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              
              const Text("Kategori", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryIcon(Icons.directions_car, "Sedan"),
                  _buildCategoryIcon(Icons.airport_shuttle, "SUV"),
                  _buildCategoryIcon(Icons.electric_car, "Luxury"),
                  _buildCategoryIcon(Icons.sports_motorsports, "Sport"),
                ],
              ),
              const SizedBox(height: 25),

              // Daftar Mobil Populer
              const Text("Mobil Populer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              _buildCarCard("Mercedes C-Class", "assets/mercy.png", "Rp 1.2jt/hari"),
              _buildCarCard("Toyota Alphard", "assets/alphard.png", "Rp 2.5jt/hari"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: const Color(0xFF1E3C72)),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildCarCard(String name, String imagePath, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, spreadRadius: 5),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: NetworkImage('https://img.daisyui.com/images/stock/photo-1605379399642-870262d3d051.webp'), // Dummy Image
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(price, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey),
        ],
      ),
    );
  }
}