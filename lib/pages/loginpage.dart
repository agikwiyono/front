import 'package:flutter/material.dart';
import 'dart:async'; // Untuk timer gambar berganti
import 'signupage.dart'; 
import 'home.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // List gambar mobil mewah dari Unsplash
  final List<String> _carImages = [
    'https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=1000', // Porsche
    'https://images.unsplash.com/photo-1567818738100-41eba9e4c1f5?q=80&w=1000', // Lamborghini
    'https://images.unsplash.com/photo-1583121274602-3e2820c69888?q=80&w=1000', // Ferrari
  ];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // Timer untuk mengganti gambar otomatis setiap 4 detik
    Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < _carImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image Carousel
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _carImages.length,
              itemBuilder: (context, index) {
                return Image.network(
                  _carImages[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),

          // 2. Overlay Gelap agar konten terbaca
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),

          // 3. Konten Login
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  
                  // LOGO BARU YANG LEBIH BAGUS
                  _buildPremiumLogo(),

                  const SizedBox(height: 60),

                  // KARTU LOGIN MODERN
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E3C72),
                          ),
                        ),
                        const SizedBox(height: 25),
                        _buildTextField("Email Address", Icons.email_rounded, false),
                        const SizedBox(height: 20),
                        _buildTextField("Password", Icons.lock_rounded, true),
                        
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {}, 
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        _buildButton("GO TO DRIVE", const Color(0xFF1E3C72), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                          }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  
                  // TOMBOL SIGN UP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("New Member?", style: TextStyle(color: Colors.white70)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage())
                          );
                        }, 
                        child: const Text(
                          "Join Now", 
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumLogo() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 50),
        ),
        const SizedBox(height: 10),
        const Text(
          "RENTALUXE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
          ),
        ),
        Container(
          height: 2,
          width: 50,
          color: Colors.orange,
        ),
        const Text(
          "PREMIUM CAR RENTAL",
          style: TextStyle(color: Colors.white60, fontSize: 10, letterSpacing: 2),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, IconData icon, bool isPassword) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF1E3C72)),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), 
          borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
        ),
        onPressed: onPressed,
        child: Text(
          text, 
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5)
        ),
      ),
    );
  }
}