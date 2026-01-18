import 'package:flutter/material.dart';
import 'home.dart';
import 'profile_page.dart';
import 'rent_history_page.dart'; // Import halaman riwayat sewa yang baru dibuat

class MainPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const MainPage({super.key, required this.userData});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // List halaman utama diperbarui untuk menyertakan RentHistoryPage
    final List<Widget> pages = [
      // Tab 0: Home Dashboard
      HomePage(userData: widget.userData),

      // Tab 1: PERBAIKAN - Sekarang memanggil RentHistoryPage asli
      RentHistoryPage(userData: widget.userData),

      // Tab 2: Placeholder untuk Favorit
      const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey),
            SizedBox(height: 10),
            Text("Halaman Favorit", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),

      // Tab 3: Profil Pengguna
      ProfilePage(userData: widget.userData),
    ];

    return Scaffold(
      // Menggunakan IndexedStack agar posisi scroll tidak hilang saat berpindah tab
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF1E3C72), // Warna Biru Tua
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // Agar label selalu muncul
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.key_outlined),
            activeIcon: Icon(Icons.key),
            label: "Sewa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: "Favorit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
