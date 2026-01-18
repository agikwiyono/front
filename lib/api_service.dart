import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Gunakan 10.0.2.2 untuk Emulator Android
  // Gunakan localhost atau 127.0.0.1 untuk Emulator iOS / Chrome
  // Gunakan alamat IP Laptop Anda jika menggunakan HP Fisik
  static const String baseUrl = "http://192.168.100.192:8000/api";

  // FUNGSI REGISTER (Kompatibel dengan WEB & MOBILE)
  static Future<http.Response> register({
    required String name,
    required String address,
    required String age,
    required String email,
    required String password,
    required String fileName,
    required List<int>? fileBytes,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/register'),
      );

      request.headers.addAll({'Accept': 'application/json'});

      request.fields['name'] = name;
      request.fields['address'] = address;
      request.fields['age'] = age;
      request.fields['email'] = email;
      request.fields['password'] = password;

      if (fileBytes != null && fileBytes.isNotEmpty) {
        request.files.add(
          http.MultipartFile.fromBytes('image', fileBytes, filename: fileName),
        );
      }

      var streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      rethrow;
    }
  }

  // FUNGSI LOGIN
  static Future<http.Response> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> getMyRentals(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/rentals/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // FUNGSI SEWA MOBIL (BARU: Untuk mencatat ke database)
  static Future<http.Response> rentCar({
    required int userId,
    required String carName,
    required String carType,
    required String price,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/rent-car'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'car_name': carName,
          'car_type': carType,
          'price': price,
        }),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
