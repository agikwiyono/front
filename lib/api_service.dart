import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.100.192:8000/api";

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

  // FUNGSI AMBIL RIWAYAT SEWA
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

  // FUNGSI SEWA MOBIL (DIPERBARUI: Mengirim Foto Verifikasi Wajah)
  static Future<http.Response> rentCar({
    required int userId,
    required String carName,
    required String carType,
    required String price,
    required String fileName,
    required List<int>? fileBytes,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/rent-car'),
      );
      request.headers.addAll({'Accept': 'application/json'});

      request.fields['user_id'] = userId.toString();
      request.fields['car_name'] = carName;
      request.fields['car_type'] = carType;
      request.fields['price'] = price;

      if (fileBytes != null) {
        // Ini bagian paling aman untuk Web & Mobile
        request.files.add(
          http.MultipartFile.fromBytes(
            'verification_photo',
            fileBytes,
            filename: fileName,
          ),
        );
      }

      var streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      rethrow;
    }
  }
}
