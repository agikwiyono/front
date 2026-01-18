import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'loginpage.dart';
import '/api_service.dart'; // Pastikan path import sesuai struktur folder Anda

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _ageErrorText;
  bool _isUnderage = false;
  bool _isLoading = false;
  String _fileName = "Belum ada file terpilih";
  PlatformFile? _pickedFile;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg'],
      withData: true, // PENTING: Harus true agar bytes terbaca di Web
    );

    if (result != null) {
      setState(() {
        _pickedFile = result.files.first;
        _fileName = _pickedFile!.name;
      });
    }
  }

  void _validateAge(String value) {
    if (value.isEmpty) {
      setState(() {
        _ageErrorText = null;
        _isUnderage = false;
      });
      return;
    }
    int? age = int.tryParse(value);
    setState(() {
      if (age == null) {
        _ageErrorText = "Masukkan angka valid";
        _isUnderage = true;
      } else if (age < 17) {
        _ageErrorText = "Umur minimal 17 tahun";
        _isUnderage = true;
      } else {
        _ageErrorText = null;
        _isUnderage = false;
      }
    });
  }

  Future<void> _handleSignup() async {
    // Validasi tambahan sebelum kirim
    if (_pickedFile == null || _pickedFile!.bytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Silakan pilih file identitas terlebih dahulu"),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      // MEMANGGIL API SERVICE DENGAN BYTES (Web Compatible)
      final response = await ApiService.register(
        name: _nameController.text,
        address: _addressController.text,
        age: _ageController.text,
        email: _emailController.text,
        password: _passwordController.text,
        fileName: _pickedFile!.name,
        fileBytes: _pickedFile!.bytes!, // Mengirim data biner file
      );

      print("Response: ${response.body}");

      if (response.statusCode == 201) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Registrasi Berhasil!")));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server menolak: ${response.body}")),
        );
      }
    } catch (e) {
      print("Error Detail: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Gagal terhubung ke server. Cek koneksi Anda!"),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("Create Account"),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF1E3C72),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3C72),
                ),
              ),
              const SizedBox(height: 20),
              _buildInputField("Full Name", Icons.person, _nameController),
              const SizedBox(height: 15),
              _buildInputField("Home Address", Icons.home, _addressController),
              const SizedBox(height: 15),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                onChanged: _validateAge,
                decoration: _inputDecoration(
                  "Age",
                  Icons.calendar_today,
                  error: _ageErrorText,
                ),
              ),
              const SizedBox(height: 15),
              _buildInputField("Email", Icons.email, _emailController),
              const SizedBox(height: 15),
              _buildInputField(
                "Password",
                Icons.lock,
                _passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 25),
              const Text(
                "Identity Verification",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              _buildUploadCard(),
              const SizedBox(height: 30),
              _buildSubmitButton(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon, {
    String? error,
  }) {
    return InputDecoration(
      labelText: label,
      errorText: error,
      prefixIcon: Icon(icon, color: const Color(0xFF1E3C72)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    IconData icon,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: _inputDecoration(label, icon),
    );
  }

  Widget _buildUploadCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(
            _pickedFile != null ? Icons.check_circle : Icons.cloud_upload,
            size: 40,
            color: _pickedFile != null ? Colors.green : const Color(0xFF1E3C72),
          ),
          const SizedBox(height: 10),
          Text(_fileName, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: _pickFile,
            child: const Text("Choose File"),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    bool isFormValid =
        !_isUnderage &&
        _pickedFile != null &&
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty;

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton(
              onPressed: isFormValid ? _handleSignup : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3C72),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                "Complete Registration",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
