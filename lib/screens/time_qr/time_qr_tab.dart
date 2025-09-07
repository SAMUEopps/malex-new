/*import 'dart:async';

import 'package:flutter/material.dart';
import 'widgets/time_qr_body.dart';
import 'helpers/work_phases.dart';
import 'helpers/time_of_day_x.dart';

export 'helpers/work_phases.dart' show kWorkPhases;

class TimeQrTab extends StatefulWidget {
  final VoidCallback? onDownloadQr;
  final VoidCallback? onShareQr;

  const TimeQrTab({super.key, this.onDownloadQr, this.onShareQr});

  @override
  State<TimeQrTab> createState() => _TimeQrTabState();
}

class _TimeQrTabState extends State<TimeQrTab> {
  final _scrollController = ScrollController();
  final _desktopId = 'DESK01';
  DateTime _lastUpdate = DateTime.now();
  Timer? _minuteTimer;
  Timer? _phaseCheckTimer;

  String _currentEvent = 'time_in';

  @override
  void initState() {
    super.initState();
    _updateEventFromTime();
    _minuteTimer = Timer.periodic(const Duration(minutes: 1), (_) => _updateAndSet());
    _phaseCheckTimer = Timer.periodic(const Duration(seconds: 30), (_) => _updateEventFromTime());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _minuteTimer?.cancel();
    _phaseCheckTimer?.cancel();
    super.dispose();
  }

  void _updateAndSet() {
    setState(() {
      _lastUpdate = DateTime.now();
      _updateEventFromTime();
    });
  }

  void _updateEventFromTime() {
    final now = TimeOfDay.now();
    final newPhase = kWorkPhases.cast<WorkPhase?>().firstWhere(
          (p) => now.isBetween(p!.start, p.end),
          orElse: () => kWorkPhases.first,
        );
    if (newPhase!.key != _currentEvent) {
      setState(() {
        _currentEvent = newPhase.key;
        _lastUpdate = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TimeQrBody(
        scrollController: _scrollController,
        currentEvent: _currentEvent,
        desktopId: _desktopId,
        lastUpdate: _lastUpdate,
      ),
    );
  }
}*/

 import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';

// Import your existing components
import 'widgets/time_qr_body.dart';
import 'helpers/work_phases.dart';
import 'helpers/time_of_day_x.dart';

export 'helpers/work_phases.dart' show kWorkPhases;

class TimeQrTab extends StatefulWidget {
  final VoidCallback? onDownloadQr;
  final VoidCallback? onShareQr;

  const TimeQrTab({super.key, this.onDownloadQr, this.onShareQr});

  @override
  State<TimeQrTab> createState() => _TimeQrTabState();
}

class _TimeQrTabState extends State<TimeQrTab> {
  final _scrollController = ScrollController();
  final _desktopId = 'DESK01';
  DateTime _lastUpdate = DateTime.now();
  Timer? _minuteTimer;
  Timer? _phaseCheckTimer;
  String _currentEvent = 'time_in';

  // --- camera_windows / CameraPlatform state ---
  List<CameraDescription> _cameras = <CameraDescription>[];
  int _cameraId = -1;
  bool _isCameraInitialized = false;
  Size? _previewSize;
  StreamSubscription<CameraErrorEvent>? _errorStreamSubscription;
  StreamSubscription<CameraClosingEvent>? _cameraClosingStreamSubscription;

  // Media settings used when creating the camera (adjust if desired)
  final MediaSettings _mediaSettings = const MediaSettings(
    resolutionPreset: ResolutionPreset.medium,
    fps: 15,
    videoBitrate: 200000,
    audioBitrate: 32000,
    enableAudio: false,
  );

  // Face recognition simulation variables
  bool _isFaceRecognitionActive = false;
  String _faceRecognitionStatus = 'Not Active';

  @override
  void initState() {
    super.initState();
    _updateEventFromTime();
    _minuteTimer = Timer.periodic(const Duration(minutes: 1), (_) => _updateAndSet());
    _phaseCheckTimer = Timer.periodic(const Duration(seconds: 30), (_) => _updateEventFromTime());

    // Fetch cameras and initialize the first one if available
    _fetchCameras();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _minuteTimer?.cancel();
    _phaseCheckTimer?.cancel();
    _errorStreamSubscription?.cancel();
    _cameraClosingStreamSubscription?.cancel();
    _disposeCurrentCamera();
    super.dispose();
  }

  /// Fetch available cameras (camera_windows exposes these via CameraPlatform).
  Future<void> _fetchCameras() async {
    try {
      final cameras = await CameraPlatform.instance.availableCameras();
      if (mounted) {
        setState(() {
          _cameras = cameras;
        });
      }
      if (_cameras.isNotEmpty) {
        await _initializeCamera(); // automatically initialize first camera
      }
    } catch (e, st) {
      debugPrint('Failed to fetch cameras: $e\n$st');
      // keep falling back to "camera not available" UI
    }
  }

  /// Create + initialize camera using CameraPlatform APIs (used by camera_windows).
  Future<void> _initializeCamera() async {
    if (_cameras.isEmpty) return;

    int cameraId = -1;
    try {
      final CameraDescription camera = _cameras[0];

      // Create camera with the desired settings; returns an integer cameraId.
      cameraId = await CameraPlatform.instance.createCameraWithSettings(
        camera,
        _mediaSettings,
      );

      // Subscribe to camera error / closing events (optional but useful).
      _errorStreamSubscription?.cancel();
      _errorStreamSubscription = CameraPlatform.instance.onCameraError(cameraId).listen(
        (CameraErrorEvent e) => _onCameraError(e),
      );

      _cameraClosingStreamSubscription?.cancel();
      _cameraClosingStreamSubscription =
          CameraPlatform.instance.onCameraClosing(cameraId).listen(_onCameraClosing);

      // Wait for the "onCameraInitialized" event and call initializeCamera.
      final Future<CameraInitializedEvent> initialized =
          CameraPlatform.instance.onCameraInitialized(cameraId).first;

      await CameraPlatform.instance.initializeCamera(cameraId);

      final CameraInitializedEvent event = await initialized;
      _previewSize = Size(event.previewWidth, event.previewHeight);

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
          _cameraId = cameraId;
        });
      }
    } on CameraException catch (e) {
      debugPrint('Camera initialization failed: ${e.code} ${e.description}');
      // If something went wrong and we have a created cameraId, dispose it.
      if (cameraId >= 0) {
        try {
          await CameraPlatform.instance.dispose(cameraId);
        } catch (disposeErr) {
          debugPrint('Error disposing failed camera: $disposeErr');
        }
      }
      if (mounted) {
        setState(() {
          _isCameraInitialized = false;
          _cameraId = -1;
          _previewSize = null;
        });
      }
    } catch (e) {
      debugPrint('Unexpected camera init error: $e');
    }
  }

  Future<void> _disposeCurrentCamera() async {
    if (_cameraId >= 0 && _isCameraInitialized) {
      try {
        await CameraPlatform.instance.dispose(_cameraId);
      } on CameraException catch (e) {
        debugPrint('Failed to dispose camera: ${e.code}: ${e.description}');
      } finally {
        if (mounted) {
          setState(() {
            _isCameraInitialized = false;
            _cameraId = -1;
            _previewSize = null;
          });
        }
      }
    }
  }

  void _onCameraError(CameraErrorEvent event) {
    debugPrint('Camera error: ${event.description}');
    // On error, try to dispose and re-fetch cameras.
    _disposeCurrentCamera().then((_) => _fetchCameras());
  }

 void _onCameraClosing(CameraClosingEvent event) {
  debugPrint('Camera closing event received: ${event.reason}');
}

Future<void> _captureNow() async {
  if (!_isCameraInitialized || _cameraId < 0) return;
  try {
    setState(() {
      _faceRecognitionStatus = 'Processing...';
    });

    // Take a picture (returns XFile). We don't use the path here; just simulate detection.
    final XFile file = await CameraPlatform.instance.takePicture(_cameraId);
    debugPrint('Captured image at: ${file.path}');

    // Simulated face-detection result flow
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _faceRecognitionStatus = 'Employee Recognized';
      });
    }
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _faceRecognitionStatus = 'Time Recorded Successfully';
      });
    }
  } catch (e) {
    debugPrint('Capture failed: $e');
    if (mounted) {
      setState(() {
        _faceRecognitionStatus = 'Processing failed';
      });
    }
  }
}


  void _toggleFaceRecognition() {
    setState(() {
      _isFaceRecognitionActive = !_isFaceRecognitionActive;
      if (_isFaceRecognitionActive) {
        _faceRecognitionStatus = 'Scanning...';
        // simulate recognition flow
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted && _isFaceRecognitionActive) {
            setState(() {
              _faceRecognitionStatus = 'Employee Recognized';
            });

            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _faceRecognitionStatus = 'Time Recorded Successfully';
                });
              }
            });
          }
        });
      } else {
        _faceRecognitionStatus = 'Not Active';
      }
    });
  }

  void _updateAndSet() {
    setState(() {
      _lastUpdate = DateTime.now();
      _updateEventFromTime();
    });
  }

  void _updateEventFromTime() {
    final now = TimeOfDay.now();
    final newPhase = kWorkPhases.cast<WorkPhase?>().firstWhere(
          (p) => now.isBetween(p!.start, p.end),
          orElse: () => kWorkPhases.first,
        );
    if (newPhase!.key != _currentEvent) {
      setState(() {
        _currentEvent = newPhase.key;
        _lastUpdate = DateTime.now();
      });
    }
  }

  Widget _buildCameraPreviewWidget() {
    if (_isCameraInitialized && _cameraId >= 0 && _previewSize != null) {
      // Use the platform buildPreview widget.
      final Widget preview = CameraPlatform.instance.buildPreview(_cameraId);
      // Keep aspect ratio per preview size
      final double aspect = _previewSize!.width / _previewSize!.height;
      return AspectRatio(aspectRatio: aspect, child: preview);
    } else if (_isCameraInitialized && _cameraId >= 0) {
      // fallback if preview size isn't set yet
      return CameraPlatform.instance.buildPreview(_cameraId);
    } else {
      // placeholder when no camera
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFDCE0E3)),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt, size: 40, color: Colors.grey),
              SizedBox(height: 8),
              Text('Camera not available', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Face Recognition Section
          /*Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Face Recognition (Windows)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 12),

                // Camera Preview (uses camera_windows via CameraPlatform)
                _buildCameraPreviewWidget(),

                const SizedBox(height: 12),

                // Face Recognition Status
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getStatusColor(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getStatusIcon(),
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _faceRecognitionStatus,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Face Recognition Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _toggleFaceRecognition,
                      icon: Icon(
                        _isFaceRecognitionActive ? Icons.stop : Icons.face_retouching_natural,
                      ),
                      label:
                          Text(_isFaceRecognitionActive ? 'Stop Recognition' : 'Start Recognition'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isFaceRecognitionActive ? const Color(0xFFE74C3C) : const Color(0xFF2ECC71),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Manual face capture functionality
                        if (_isFaceRecognitionActive) {
                          _captureNow();
                        }
                      },
                      icon: const Icon(Icons.camera_enhance),
                      label: const Text('Capture Now'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2C3E50),
                        side: const BorderSide(color: Color(0xFFDCE0E3)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),*/

          // Existing QR Code Section
          TimeQrBody(
            scrollController: _scrollController,
            currentEvent: _currentEvent,
            desktopId: _desktopId,
            lastUpdate: _lastUpdate,
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    if (_faceRecognitionStatus == 'Employee Recognized') {
      return const Color(0xFF2ECC71); // Green for success
    } else if (_faceRecognitionStatus == 'Time Recorded Successfully') {
      return const Color(0xFF3498DB); // Blue for completion
    } else if (_faceRecognitionStatus == 'Scanning...' || _faceRecognitionStatus == 'Processing...') {
      return const Color(0xFFF39C12); // Orange for in progress
    }
    return const Color(0xFF7F8C8D); // Gray for inactive
  }

  IconData _getStatusIcon() {
    if (_faceRecognitionStatus == 'Employee Recognized') {
      return Icons.face;
    } else if (_faceRecognitionStatus == 'Time Recorded Successfully') {
      return Icons.check_circle;
    } else if (_faceRecognitionStatus == 'Scanning...' || _faceRecognitionStatus == 'Processing...') {
      return Icons.access_time;
    }
    return Icons.face_retouching_off;
  }
}

extension on CameraClosingEvent {
  get reason => null;
}