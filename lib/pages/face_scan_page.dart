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
  int _step = 0; // 0: Tengah, 1: Kanan, 2: Kiri, 3: Kedip

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true, // Untuk deteksi kedip
      enableLandmarks: true,
    ),
  );

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      front,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await _controller!.initialize();

    _controller!.startImageStream((image) => _processCameraImage(image));
    if (mounted) setState(() {});
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isBusy) return;
    _isBusy = true;

    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) {
      _isBusy = false;
      return;
    }

    final faces = await _faceDetector.processImage(inputImage);

    if (faces.isNotEmpty) {
      final face = faces.first;

      // LOGIKA DETEKSI OTOMATIS BERDASARKAN STEP
      if (mounted) {
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
            if ((face.leftEyeOpenProbability ?? 1.0) < 0.4) {
              _finishValidation();
            }
          }
        });
      }
    }
    _isBusy = false;
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    final sensorOrientation = _controller!.description.sensorOrientation;
    final rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null ||
        (format != InputImageFormat.yuv420 && format != InputImageFormat.nv21))
      return null;

    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  void _finishValidation() {
    _controller?.stopImageStream();
    Navigator.pop(context, true); // Sukses
  }

  @override
  void dispose() {
    _controller?.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          CameraPreview(_controller!),
          // Overlay Lingkaran
          CustomPaint(size: Size.infinite, painter: FaceOverlayPainter()),
          Positioned(
            bottom: 80,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                _instruction,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3C72),
                ),
              ),
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
          radius: 150,
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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
