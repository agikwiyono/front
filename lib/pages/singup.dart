import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Center(
        child: _buildVerificationCard(),
      ),
    );
  }

  Widget _buildVerificationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.camera_front, size: 40, color: Color(0xFF1E3C72)),
          const SizedBox(height: 10),
          const Text("Verifikasi Identitas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Text("Ambil foto SIM/KTP untuk keamanan sewa", textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () { /* Logika buka kamera */ },
            child: const Text("Buka Kamera"),
          )
        ],
      ),
    );
  }
}