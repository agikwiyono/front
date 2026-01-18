import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Gunakan 10.0.2.2 untuk Emulator Android
  // Gunakan localhost atau 127.0.0.1 untuk Emulator iOS / Chrome
  // Gunakan alamat IP Laptop Anda jika menggunakan HP Fisik
  static const String baseUrl = "http://192.168.100.192:8000/api";

  // FUNGSI REGISTER TERBARU (Kompatibel dengan WEB & MOBILE)
  static Future<http.Response> register({
    required String name,
    required String address,
    required String age,
    required String email,
    required String password,
    required String fileName,    // Gunakan nama file dari file picker
    required List<int>? fileBytes, // Gunakan bytes agar jalan di Web
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/register'),
      );

      // Header agar Laravel merespon dengan JSON
      request.headers.addAll({'Accept': 'application/json'});

      // Menambahkan data teks
      request.fields['name'] = name;
      request.fields['address'] = address;
      request.fields['age'] = age;
      request.fields['email'] = email;
      request.fields['password'] = password;

      // Menambahkan file gambar menggunakan bytes agar aman untuk Web
      if (fileBytes != null && fileBytes.isNotEmpty) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'image', // Harus sesuai dengan $request->file('image') di Laravel
            fileBytes,
            filename: fileName,
          ),
        );
      }

      // Mengirim request
      var streamedResponse = await request.send();

      // Mengubah StreamedResponse menjadi Response biasa
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      rethrow;
    }
  }

  // Fungsi untuk Login
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
}