import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/ui/screens/result_screen.dart';
import 'package:kamus_kamek/ui/widgets/loading_indicator.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/size_config.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  List<CameraDescription> cameras = [];

  @override
  void initState() {
    super.initState();
    getCameras().then((_) {
      if (cameras != []) {
        controller = CameraController(cameras[0], ResolutionPreset.max);
        controller?.initialize().then((_) => {
              if (mounted) {setState(() {})}
            });
      }
    });
  }

  Future getCameras() async {
    cameras = await availableCameras();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (controller == null) ? loadingIndicator() : buildCamera());
  }

  CameraPreview buildCamera() {
    return CameraPreview(
      controller!,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            SizeConfig.defaultMargin, 40, SizeConfig.defaultMargin, 40),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                  onTap: () => closeScreen(context),
                  child: Icon(
                    Icons.close,
                  )),
            ),
            Spacer(),
            Text(
              "Sejajarkan teks dengan garis,\n\nTampilan horizontal tersedia.",
              style: whiteFontStyle.copyWith(),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            FloatingActionButton(
              onPressed: () => startScreen(context, ResultScreen()),
              elevation: 0,
              backgroundColor: Colors.white,
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
