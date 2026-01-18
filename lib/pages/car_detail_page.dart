import 'package:flutter/material.dart';
import '../api_service.dart';
import 'face_scan_page.dart'; // Import halaman scan wajah otomatis

class CarDetailPage extends StatelessWidget {
  final Map<String, String> car;
  final Map<String, dynamic> userData;

  const CarDetailPage({super.key, required this.car, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car['name']!),
        backgroundColor: const Color(0xFF1E3C72),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Mobil
            Image.network(
              car['image']!,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car['name']!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    car['price']!,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xFF1E3C72),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Deskripsi Mobil",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Mobil ${car['name']} tipe ${car['type']} ini memiliki rating ${car['rating']} dari pelanggan. "
                    "Kondisi mesin sangat terawat, AC dingin, dan siap menemani perjalanan Anda.",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),

                  // TOMBOL SEWA DENGAN VERIFIKASI WAJAH OTOMATIS
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        // 1. PINDAH KE HALAMAN SCAN WAJAH (OTOMATIS 4 TAHAP)
                        final bool? isVerified = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FaceScanPage(),
                          ),
                        );

                        // 2. JIKA VERIFIKASI SELESAI (SUKSES)
                        if (isVerified == true) {
                          try {
                            // Tampilkan loading dialog
                            if (!context.mounted) return;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );

                            // 3. SIMPAN DATA KE LARAVEL
                            final response = await ApiService.rentCar(
                              userId: userData['id'],
                              carName: car['name']!,
                              carType: car['type']!,
                              price: car['price']!,
                            );

                            if (!context.mounted) return;
                            Navigator.pop(context); // Tutup loading

                            if (response.statusCode == 201) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Verifikasi Wajah Sukses! ${car['name']} berhasil disewa.",
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              // Kembali ke halaman Home
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Gagal menyimpan data ke server.",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } catch (e) {
                            if (!context.mounted) return;
                            Navigator.pop(context); // Tutup loading jika error
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Terjadi kesalahan koneksi server.",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else {
                          // JIKA USER MEMBATALKAN SCAN WAJAH
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Penyewaan dibatalkan. Scan wajah wajib dilakukan.",
                              ),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3C72),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Sewa Sekarang",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
