// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:kamus_kamek/config/text_style.dart';
// import 'package:kamus_kamek/ui/screens/result_screen.dart';
// import 'package:kamus_kamek/ui/widgets/custom_toast.dart';
// import 'package:kamus_kamek/ui/widgets/loading_indicator.dart';
// import 'package:kamus_kamek/utils/navigator.dart';
// import 'package:kamus_kamek/utils/size_config.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({Key? key}) : super(key: key);

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   CameraController? controller;
//   List<CameraDescription> cameras = [];
//   CameraDescription? selectedCamera;

//   @override
//   void initState() {
//     super.initState();
//     getCameras().then((_) {
//       if (cameras != []) {
//         selectedCamera = cameras[0];
//         controller = CameraController(cameras[0], ResolutionPreset.max);
//         controller?.initialize().then((_) => {
//               if (mounted) {setState(() {})}
//             });
//       }
//     });
//   }

//   Future getCameras() async {
//     cameras = await availableCameras();
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: (controller == null) ? loadingIndicator() : buildCamera());
//   }

//   CameraPreview buildCamera() {
//     return CameraPreview(
//       controller!,
//       child: Container(
//         height: SizeConfig.screenHeight,
//         padding: EdgeInsets.fromLTRB(
//             SizeConfig.defaultMargin, 40, SizeConfig.defaultMargin, 40),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: GestureDetector(
//                   onTap: () => closeScreen(context),
//                   child: Icon(
//                     Icons.close,
//                   )),
//             ),
//             Spacer(),
//             Text(
//               "Sejajarkan teks dengan garis,\n\nTampilan horizontal tersedia.",
//               style: whiteFontStyle.copyWith(),
//               textAlign: TextAlign.center,
//             ),
//             Spacer(),
//             FloatingActionButton(
//               onPressed: () async {
//                 // startScreen(context, ResultScreen());
//                 try {
//                   final image = await controller?.takePicture();
//                   print("IMAGE PATH ${image?.path}");
//                   startScreen(context, ResultScreen(File(image!.path)));
//                 } catch (e) {
//                   print("ERROR $e");
//                   customToast(e.toString());
//                 }
//               },
//               elevation: 0,
//               backgroundColor: Colors.white,
//               child: Container(
//                 margin: EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.black)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'dart:ffi';
// // import 'dart:io';

// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:camera/camera.dart';
// // import 'package:kamus_kamek/config/text_style.dart';
// // import 'package:kamus_kamek/ui/screens/result_screen.dart';
// // import 'package:kamus_kamek/ui/widgets/custom_toast.dart';
// // import 'package:kamus_kamek/ui/widgets/loading_indicator.dart';
// // import 'package:kamus_kamek/utils/navigator.dart';
// // import 'package:kamus_kamek/utils/size_config.dart';
// // import 'package:google_ml_kit/google_ml_kit.dart';

// // class CameraScreen extends StatefulWidget {
// //   const CameraScreen({Key? key}) : super(key: key);

// //   @override
// //   _CameraScreenState createState() => _CameraScreenState();
// // }

// // class _CameraScreenState extends State<CameraScreen> {
// //   CameraController? _camera;
// //   bool _cameraInitialized = false;
// //   CameraImage? _savedImage;

// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   void initializeCamera() async {
// //     // Get list if cameras of the device
// //     List<CameraDescription> cameras = await availableCameras();

// //     // Create the CameraController
// //     _camera = CameraController(cameras.first, ResolutionPreset.veryHigh);
// //     _camera?.initialize().then((_) async {
// //       // Start ImageStream
// //       await _camera
// //           ?.startImageStream((CameraImage image) => _processCameraImage(image));
// //       setState(() {
// //         _cameraInitialized = true;
// //       });
// //     });
// //   }

// //   void _processCameraImage(CameraImage image) async {
// //     setState(() {
// //       _savedImage = image;
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _camera?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         body: (_cameraInitialized) ? buildCamera() : loadingIndicator());
// //   }

// //   CameraPreview buildCamera() {
// //     return  CameraPreview(
// //       _camera!,
// //       child: Padding(
// //         padding: EdgeInsets.fromLTRB(
// //             SizeConfig.defaultMargin, 40, SizeConfig.defaultMargin, 40),
// //         child: Column(
// //           children: [
// //             Align(
// //               alignment: Alignment.centerLeft,
// //               child: GestureDetector(
// //                   onTap: () => closeScreen(context),
// //                   child: Icon(
// //                     Icons.close,
// //                   )),
// //             ),
// //             Spacer(),
// //             Text(
// //               "Sejajarkan teks dengan garis,\n\nTampilan horizontal tersedia.",
// //               style: whiteFontStyle.copyWith(),
// //               textAlign: TextAlign.center,
// //             ),
// //             Spacer(),
// //             FloatingActionButton(
// //               onPressed: ()  {
// //                 Pointer<Uint8> p = allocate(count: _ca)
// //               },
// //               elevation: 0,
// //               backgroundColor: Colors.white,
// //               child: Container(
// //                 margin: EdgeInsets.all(5),
// //                 decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     border: Border.all(color: Colors.black)),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'dart:io';

// // import 'package:camera/camera.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_ml_kit/google_ml_kit.dart';
// // import 'package:image_picker/image_picker.dart';

// // enum ScreenMode { liveFeed, gallery }

// // class CameraView extends StatefulWidget {
// //   CameraView(
// //       {Key? key,
// //       required this.title,
// //       required this.customPaint,
// //       required this.onImage,
// //       this.initialDirection = CameraLensDirection.back})
// //       : super(key: key);

// //   final String title;
// //   final CustomPaint? customPaint;
// //   final Function(InputImage inputImage) onImage;
// //   final CameraLensDirection initialDirection;

// //   @override
// //   _CameraViewState createState() => _CameraViewState();
// // }

// // class _CameraViewState extends State<CameraView> {
// //   ScreenMode _mode = ScreenMode.liveFeed;
// //   CameraController? _controller;
// //   File? _image;
// //   ImagePicker? _imagePicker;
// //   int _cameraIndex = 0;

// //   List<CameraDescription> cameras = [];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     getCameras().then((_) {
// // //       if (cameras != []) {
// // //         selectedCamera = cameras[0];
// // //         controller = CameraController(cameras[0], ResolutionPreset.max);
// // //         controller?.initialize().then((_) => {
// // //               if (mounted) {setState(() {})}
// // //             });
// // //       }
// // //     });
// // //   }

// //   Future getCameras() async {
// //     cameras = await availableCameras();
// //     print("CAMERAS INISTATE $cameras");
// //   }

// //   @override
// //   void initState() {
// //     super.initState();

// //     getCameras().then((_) {
// //       for (var i = 0; i < cameras.length; i++) {
// //         if (cameras[i].lensDirection == widget.initialDirection) {
// //           _cameraIndex = i;
// //         }
// //       }
// //       _startLiveFeed();

// //       setState(() {});
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _stopLiveFeed();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.title),
// //         actions: [
// //           Padding(
// //             padding: EdgeInsets.only(right: 20.0),
// //             child: GestureDetector(
// //               onTap: _switchScreenMode,
// //               child: Icon(
// //                 _mode == ScreenMode.liveFeed
// //                     ? Icons.photo_library_outlined
// //                     : (Platform.isIOS
// //                         ? Icons.camera_alt_outlined
// //                         : Icons.camera),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: _body(),
// //       floatingActionButton: _floatingActionButton(),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
// //     );
// //   }

// //   Widget? _floatingActionButton() {
// //     if (_mode == ScreenMode.gallery) return null;
// //     if (cameras.length == 1) return null;
// //     return Container(
// //         height: 70.0,
// //         width: 70.0,
// //         child: FloatingActionButton(
// //           child: Icon(
// //             Platform.isIOS
// //                 ? Icons.flip_camera_ios_outlined
// //                 : Icons.flip_camera_android_outlined,
// //             size: 40,
// //           ),
// //           onPressed: _switchLiveCamera,
// //         ));
// //   }

// //   Widget _body() {
// //     Widget body;
// //     if (_mode == ScreenMode.liveFeed)
// //       body = _liveFeedBody();
// //     else
// //       body = _galleryBody();
// //     return body;
// //   }

// //   Widget _liveFeedBody() {
// //     print("CONTROLLER LIVEFEEDBODY $_controller");
// //     if (_controller?.value.isInitialized == false) {
// //       return Container();
// //     }
// //     return Container(
// //       color: Colors.black,
// //       child: Stack(
// //         fit: StackFit.expand,
// //         children: <Widget>[
// //           CameraPreview(_controller!),
// //           if (widget.customPaint != null) widget.customPaint!,
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _galleryBody() {
// //     return ListView(shrinkWrap: true, children: [
// //       _image != null
// //           ? Container(
// //               height: 400,
// //               width: 400,
// //               child: Stack(
// //                 fit: StackFit.expand,
// //                 children: <Widget>[
// //                   Image.file(_image!),
// //                   if (widget.customPaint != null) widget.customPaint!,
// //                 ],
// //               ),
// //             )
// //           : Icon(
// //               Icons.image,
// //               size: 200,
// //             ),
// //       Padding(
// //         padding: EdgeInsets.symmetric(horizontal: 16),
// //         child: ElevatedButton(
// //           child: Text('From Gallery'),
// //           onPressed: () => _getImage(ImageSource.gallery),
// //         ),
// //       ),
// //       Padding(
// //         padding: EdgeInsets.symmetric(horizontal: 16),
// //         child: ElevatedButton(
// //           child: Text('Take a picture'),
// //           onPressed: () => _getImage(ImageSource.camera),
// //         ),
// //       ),
// //     ]);
// //   }

// //   Future _getImage(ImageSource source) async {
// //     final pickedFile = await _imagePicker?.getImage(source: source);
// //     if (pickedFile != null) {
// //       _processPickedFile(pickedFile);
// //     } else {
// //       print('No image selected.');
// //     }
// //     setState(() {});
// //   }

// //   void _switchScreenMode() async {
// //     if (_mode == ScreenMode.liveFeed) {
// //       _mode = ScreenMode.gallery;
// //       await _stopLiveFeed();
// //     } else {
// //       _mode = ScreenMode.liveFeed;
// //       await _startLiveFeed();
// //     }
// //     setState(() {});
// //   }

// //   Future _startLiveFeed() async {
// //     print("CAMERAS STARTLIVEFEED $cameras");
// //     final camera = cameras[_cameraIndex];
// //     _controller = CameraController(
// //       camera,
// //       ResolutionPreset.low,
// //       enableAudio: false,
// //     );
// //     _controller?.initialize().then((_) {
// //       if (!mounted) {
// //         return;
// //       }
// //       _controller?.startImageStream(_processCameraImage);
// //       setState(() {});
// //     });
// //   }

// //   Future _stopLiveFeed() async {
// //     await _controller?.stopImageStream();
// //     await _controller?.dispose();
// //     _controller = null;
// //   }

// //   Future _switchLiveCamera() async {
// //     if (_cameraIndex == 0)
// //       _cameraIndex = 1;
// //     else
// //       _cameraIndex = 0;
// //     await _stopLiveFeed();
// //     await _startLiveFeed();
// //   }

// //   Future _processPickedFile(PickedFile pickedFile) async {
// //     setState(() {
// //       _image = File(pickedFile.path);
// //     });
// //     final inputImage = InputImage.fromFilePath(pickedFile.path);
// //     widget.onImage(inputImage);
// //   }

// //   Future _processCameraImage(CameraImage image) async {
// //     final WriteBuffer allBytes = WriteBuffer();
// //     for (Plane plane in image.planes) {
// //       allBytes.putUint8List(plane.bytes);
// //     }
// //     final bytes = allBytes.done().buffer.asUint8List();

// //     final Size imageSize =
// //         Size(image.width.toDouble(), image.height.toDouble());

// //     final camera = cameras[_cameraIndex];
// //     final imageRotation =
// //         InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
// //             InputImageRotation.Rotation_0deg;

// //     final inputImageFormat =
// //         InputImageFormatMethods.fromRawValue(image.format.raw) ??
// //             InputImageFormat.NV21;

// //     final planeData = image.planes.map(
// //       (Plane plane) {
// //         return InputImagePlaneMetadata(
// //           bytesPerRow: plane.bytesPerRow,
// //           height: plane.height,
// //           width: plane.width,
// //         );
// //       },
// //     ).toList();

// //     final inputImageData = InputImageData(
// //       size: imageSize,
// //       imageRotation: imageRotation,
// //       inputImageFormat: inputImageFormat,
// //       planeData: planeData,
// //     );

// //     final inputImage =
// //         InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

// //     widget.onImage(inputImage);
// //   }
// // }
