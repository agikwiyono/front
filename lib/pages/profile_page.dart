import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  // Variabel untuk menerima data user dari MainPage
  final Map<String, dynamic>? userData;

  const ProfilePage({super.key, this.userData});

  static const Color primaryColor = Color(0xFF1E3C72);

  @override
  Widget build(BuildContext context) {
    // 1. Ambil data dari Map (sesuai nama kolom di database MySQL kamu)
    final String userName = userData?['name'] ?? "Nama Pengguna";
    final String userEmail = userData?['email'] ?? "email@example.com";
    final String? profilePhoto = userData?['profile_photo'];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Header Profil dengan Background Gradient
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, Color(0xFF2A5298)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              // Tombol Edit/Kamera
              Positioned(
                top: 40,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              // Avatar Dinamis
              Positioned(
                bottom: -50,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.grey[200],
                    // Mengecek apakah profilePhoto ada di database
                    backgroundImage:
                        profilePhoto != null && profilePhoto.isNotEmpty
                        ? NetworkImage(profilePhoto)
                        : const NetworkImage(
                            'https://i.pravatar.cc/150?img=32',
                          ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 65),

          // Tampilan Nama & Email Dinamis
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        userName, // MENAMPILKAN NAMA DARI DATABASE
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(Icons.verified, color: Colors.blue[600], size: 24),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  userEmail, // MENAMPILKAN EMAIL DARI DATABASE
                  style: const TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // Statistik User
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard(
                  context,
                  "Riwayat",
                  "12",
                  Icons.history,
                  Colors.orangeAccent,
                ),
                _buildStatCard(
                  context,
                  "Poin",
                  "450",
                  Icons.stars,
                  Colors.yellow,
                ),
                _buildStatCard(
                  context,
                  "Dompet",
                  "Rp 500rb",
                  Icons.account_balance_wallet,
                  Colors.green,
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // Menu List
          _buildMenuItem(Icons.person_outline, "Edit Profil", () {}),
          _buildMenuItem(Icons.directions_car, "Mobil Favorit", () {}),
          _buildMenuItem(Icons.receipt_long, "Riwayat Pesanan", () {}),
          _buildMenuItem(
            Icons.notifications_active,
            "Notifikasi",
            () {},
            notificationCount: 2,
          ),
          _buildMenuItem(Icons.payment, "Metode Pembayaran", () {}),
          _buildMenuItem(Icons.settings, "Pengaturan Akun", () {}),

          const SizedBox(height: 20),

          // Tombol Logout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Kembali ke halaman Login dan hapus semua history navigasi
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil('/', (route) => false);
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Keluar Akun",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Widget Helper untuk Kotak Statistik
  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: (width - 60) / 3,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  // Widget Helper untuk Item Menu
  Widget _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    int? notificationCount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFF0F4F8),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primaryColor, size: 22),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          trailing: notificationCount != null
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    notificationCount.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              : const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }
}
