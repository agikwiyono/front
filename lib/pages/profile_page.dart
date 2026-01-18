import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const ProfilePage({super.key, this.userData});

  static const Color primaryColor = Color(0xFF1E3C72);

  @override
  Widget build(BuildContext context) {
    final String userName = userData?['name'] ?? "Nama Pengguna";
    final String userEmail = userData?['email'] ?? "email@example.com";
    final String? profilePhoto = userData?['profile_photo'];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(), // Menambah kenyamanan scroll
      child: Column(
        children: [
          // Header Profil
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

          // Nama & Email (Menggunakan Padding agar tidak overflow)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      // Menghindari overflow jika nama terlalu panjang
                      child: Text(
                        userName,
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
                  userEmail,
                  style: const TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // Statistik (Menggunakan Row yang dibatasi width agar tidak overflow)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
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
                );
              },
            ),
          ),

          const SizedBox(height: 25),

          // Banner Premium
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "PREMIUM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Nikmati diskon\nlebih banyak!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1503376763036-066120622c74?auto=format&fit=crop&w=200&q=80',
                      width: 80, // Ukuran disesuaikan agar tidak overflow
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
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
          _buildMenuItem(Icons.help_outline, "Bantuan & Pusat Dukungan", () {}),
          _buildMenuItem(Icons.settings, "Pengaturan Akun", () {}),

          const SizedBox(height: 20),

          // Tombol Logout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
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
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // --- FIX ERROR: Hapus 'const' di depan Icon karena menggunakan variabel primaryColor ---
  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: (width - 60) / 3, // Membagi rata agar tidak overflow
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
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
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(fontSize: 9, color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

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
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFF0F4F8),
              shape: BoxShape.circle,
            ),
            // PERBAIKAN: Hapus 'const' di sini
            child: Icon(icon, color: primaryColor, size: 22),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black87,
            ),
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                )
              : const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }
}
