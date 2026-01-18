import 'package:flutter/material.dart';
import 'home.dart';
import 'profile_page.dart';

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
    // List halaman
    final List<Widget> pages = [
      const HomePage(),
      const Center(child: Text("Halaman Sewa")),
      const Center(child: Text("Halaman Favorit")),
      // Data diteruskan ke ProfilePage di sini
      ProfilePage(userData: widget.userData),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: const Color(0xFF1E3C72),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.key), label: "Sewa"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
