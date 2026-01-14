import 'package:flutter/material.dart';
import 'singup.dart'; import 'home.dart';  


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ... (Kode Header Anda di sini) ...
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  _buildTextField("Email", Icons.email_outlined, false),
                  const SizedBox(height: 15),
                  _buildTextField("Password", Icons.lock_outline, true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {}, child: const Text("Lupa Password?")),
                  ),
                  const SizedBox(height: 20),
                  
                  // PERBAIKAN TOMBOL LOGIN: Navigasi ditaruh di dalam callback
                  _buildButton("Log In", Colors.orange[700]!, () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }),
                  
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Belum punya akun?"),
                      TextButton(
                        onPressed: () {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupPage()),
                          );
                        }, 
                        child: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildTextField(String hint, IconData icon, bool isPassword) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}