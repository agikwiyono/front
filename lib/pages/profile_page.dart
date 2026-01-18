import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'package:rentcar/main.dart'; // PENTING: Import main.dart agar bisa akses themeNotifier

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const ProfilePage({super.key, this.userData});

  static const Color primaryColor = Color(0xFF1E3C72);

  @override
  Widget build(BuildContext context) {
    final String userName = userData?['name'] ?? "kamskams";
    final String userEmail = userData?['email'] ?? "w@gmail.com";
    final String userAddress =
        userData?['address'] ?? "Jalan Merdeka No. 123, Iams";
    final String userAge = userData?['age'] != null
        ? "${userData!['age']} Tahun"
        : "22 Tahun";
    final String? profilePhoto = userData?['profile_photo'];

    // Cek apakah sekarang sedang Dark Mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Warna teks dinamis (Putih saat gelap, Biru/Hitam saat terang)
    final textColor = isDarkMode ? Colors.white : const Color(0xFF1E3C72);
    final subTextColor = isDarkMode ? Colors.grey[400] : Colors.grey;
    final cardColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      // Background diambil otomatis dari settingan main.dart
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: cardColor, // Dinamis
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          "Profil Saya",
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: cardColor, // Dinamis
              shape: BoxShape.circle,
            ),
            child: IconButton(
              // Ikon berubah: Bulan jika terang, Matahari jika gelap
              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,
                color: isDarkMode ? Colors.yellow : Colors.black,
              ),
              onPressed: () {
                // LOGIKA DARK MODE DIAKTIFKAN DI SINI
                themeNotifier.value = themeNotifier.value == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // FOTO PROFIL
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: cardColor, width: 3),
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        profilePhoto != null && profilePhoto.isNotEmpty
                        ? NetworkImage(profilePhoto)
                        : const NetworkImage(
                            'https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg',
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Text(
              userName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: textColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              userEmail,
              style: TextStyle(
                fontSize: 14,
                color: subTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            const SizedBox(height: 30),

            // INFO CARDS
            _buildInfoCard(
              title: "ALAMAT",
              value: userAddress,
              icon: Icons.location_on,
              iconColor: Colors.blueAccent,
              bgColor: Colors.blue.withOpacity(0.1),
              cardBaseColor: cardColor,
              textColor: isDarkMode ? Colors.white : Colors.black87,
            ),
            _buildInfoCard(
              title: "UMUR",
              value: userAge,
              icon: Icons.cake,
              iconColor: Colors.pinkAccent,
              bgColor: Colors.pink.withOpacity(0.1),
              cardBaseColor: cardColor,
              textColor: isDarkMode ? Colors.white : Colors.black87,
            ),
            _buildInfoCard(
              title: "STATUS AKUN",
              value: "Terverifikasi",
              icon: Icons.verified_user,
              iconColor: Colors.green,
              bgColor: Colors.green.withOpacity(0.1),
              cardBaseColor: cardColor,
              textColor: isDarkMode ? Colors.white : Colors.black87,
            ),

            const SizedBox(height: 20),

            // TOMBOL LOGOUT
            SizedBox(
              width: double.infinity,
              height: 60,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  "Keluar Akun",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: isDarkMode
                      ? Colors.red.withOpacity(0.1)
                      : const Color(0xFFFFE5E5),
                  side: BorderSide(
                    color: isDarkMode ? Colors.red : const Color(0xFFFFCCCC),
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required Color cardBaseColor,
    required Color textColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardBaseColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
