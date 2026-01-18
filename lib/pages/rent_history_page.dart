import 'package:flutter/material.dart';
import 'dart:convert';
import '../api_service.dart';

class RentHistoryPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const RentHistoryPage({super.key, required this.userData});

  @override
  State<RentHistoryPage> createState() => _RentHistoryPageState();
}

class _RentHistoryPageState extends State<RentHistoryPage> {
  List rentals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await ApiService.getMyRentals(widget.userData['id']);
      if (response.statusCode == 200) {
        setState(() {
          rentals = jsonDecode(response.body)['data'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Mobil Saya",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : rentals.isEmpty
          ? _buildEmptyState()
          : RefreshIndicator(
              onRefresh: _fetchData,
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: rentals.length,
                itemBuilder: (context, index) {
                  final item = rentals[index];
                  return _buildRentalCard(item);
                },
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_car_filled_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 15),
          const Text(
            "Belum ada mobil yang disewa",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildRentalCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E3C72).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.directions_car, color: Color(0xFF1E3C72)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['car_name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  item['car_type'],
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 5),
                Text(
                  item['price'],
                  style: const TextStyle(
                    color: Color(0xFF1E3C72),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: item['status'] == 'active'
                  ? Colors.green[50]
                  : Colors.orange[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              item['status'].toString().toUpperCase(),
              style: TextStyle(
                color: item['status'] == 'active'
                    ? Colors.green
                    : Colors.orange,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
