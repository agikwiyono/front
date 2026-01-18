import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Menggunakan static const agar mudah dipanggil, tapi kita HILANGKAN const di bawah jika error
  static const Color primaryColor = Color(0xFF1E3C72);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, const Color(0xFF2A5298)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
              ),
              // Tombol Kamera (EDIT)
              Positioned(
                top: 40,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  // PERBAIKAN PENTING: Menghapus 'const' di sini
                  child: Icon(Icons.camera_alt, color: primaryColor, size: 20),
                ),
              ),
              // Avatar
              Positioned(
                bottom: -50,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                  ),
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=400&q=80'),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 65),          
          
          // Nama & Verified Badge
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Mahasiswa RPL", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(width: 5),
                  Icon(Icons.verified, color: Colors.blue[600], size: 24), 
                ],
              ),
              const SizedBox(height: 5),
              const Text("mahasiswa.rpl@univ.ac.id", style: TextStyle(color: Colors.grey)),
            ],
          ),
          
          const SizedBox(height: 25),

          // Statistik
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard(context, "Riwayat", "12", Icons.history, Colors.orangeAccent),
                _buildStatCard(context, "Poin", "450", Icons.stars, Colors.yellow),
                _buildStatCard(context, "Dompet", "Rp 500rb", Icons.account_balance_wallet, Colors.green),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // Banner Premium dengan Gambar Mobil
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                          child: const Text("PREMIUM", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 8),
                        const Text("Nikmati diskon\nlebih banyak!", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, height: 1.2)),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1503376763036-066120622c74?auto=format&fit=crop&w=200&q=80',
                      width: 100,
                      height: 80,
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
          _buildMenuItem(Icons.notifications_active, "Notifikasi", () {}, notificationCount: 2),
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
                onPressed: () {},
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text("Keluar Akun", style: TextStyle(color: Colors.white, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color iconColor) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: (width - 60) / 3, 
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
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
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 2),
          Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {int? notificationCount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFF0F4F8),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primaryColor, size: 22),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black87)),
          trailing: notificationCount != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.red[400], borderRadius: BorderRadius.circular(20)),
                child: Text(notificationCount.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              )
            : const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }
}