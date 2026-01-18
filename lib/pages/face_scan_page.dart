import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceScanPage extends StatefulWidget {
  const FaceScanPage({super.key});

  @override
  State<FaceScanPage> createState() => _FaceScanPageState();
}

class _FaceScanPageState extends State<FaceScanPage> {
  CameraController? _controller;
  bool _isBusy = false;
  String _instruction = "Posisikan wajah di tengah";
  int _step = 0;

  // PENTING: Cek apakah platform mendukung ML Kit (Hanya Android/iOS)
  bool get _isMobile =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  FaceDetector? _faceDetector;

  @override
  void initState() {
    super.initState();
    // Hanya inisialisasi detector jika di mobile asli
    if (_isMobile) {
      _faceDetector = FaceDetector(
        options: FaceDetectorOptions(
          enableClassification: true,
          enableLandmarks: true,
        ),
      );
    }
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    final front = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      front,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: kIsWeb
          ? ImageFormatGroup.jpeg
          : ImageFormatGroup.yuv420,
    );

    try {
      await _controller!.initialize();

      // Jalankan stream hanya di Android
      if (_isMobile) {
        _controller!.startImageStream((image) => _processCameraImage(image));
      } else {
        setState(() => _instruction = "Klik tombol untuk verifikasi wajah");
      }
    } catch (e) {
      debugPrint("Kamera error: $e");
    }

    if (mounted) setState(() {});
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (!_isMobile || _faceDetector == null || _isBusy) return;
    _isBusy = true;

    final sensorOrientation = _controller!.description.sensorOrientation;
    final rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    if (rotation == null) return;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null) return;

    if (image.planes.length != 1) return;
    final plane = image.planes.first;

    final inputImage = InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );

    final faces = await _faceDetector!.processImage(inputImage);

    if (faces.isNotEmpty && mounted) {
      final face = faces.first;
      setState(() {
        if (_step == 0) {
          _instruction = "Luruskan wajah ke kamera";
          if (face.headEulerAngleY! < 10 && face.headEulerAngleY! > -10)
            _step++;
        } else if (_step == 1) {
          _instruction = "Menoleh ke KANAN";
          if (face.headEulerAngleY! < -25) _step++;
        } else if (_step == 2) {
          _instruction = "Menoleh ke KIRI";
          if (face.headEulerAngleY! > 25) _step++;
        } else if (_step == 3) {
          _instruction = "Kedipkan mata Anda";
          if ((face.leftEyeOpenProbability ?? 1.0) < 0.4) _finishValidation();
        }
      });
    }
    _isBusy = false;
  }

  void _finishValidation() {
    if (_isMobile) _controller?.stopImageStream();
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    if (_isMobile) _controller?.stopImageStream();
    _controller?.dispose();
    _faceDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Verifikasi Wajah"),
        backgroundColor: const Color(0xFF1E3C72),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          CameraPreview(_controller!),

          // Lingkaran Overlay
          CustomPaint(size: Size.infinite, painter: FaceOverlayPainter()),

          Positioned(
            bottom: 80,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    _instruction,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3C72),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Tombol ini hanya muncul di Laptop (Web)
                if (!_isMobile)
                  ElevatedButton.icon(
                    onPressed: () async {
                      await _controller!.takePicture();
                      _finishValidation();
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Ambil Foto Verifikasi"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FaceOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.7);
    final circlePath = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: 140,
        ),
      );
    final outerPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final finalPath = Path.combine(
      PathOperation.difference,
      outerPath,
      circlePath,
    );
    canvas.drawPath(finalPath, paint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      140,
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
