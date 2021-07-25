import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/ui/widgets/custom_form.dart';
import 'package:kamus_kamek/ui/widgets/loading_indicator.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/size_config.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen(this.imageUrl, {Key? key}) : super(key: key);

  final File imageUrl;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late TextEditingController textController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    recognisedText();
  }

  final TextDetector textDetector = GoogleMlKit.vision.textDetector();

  Future recognisedText() async {
    final RecognisedText recognisedText =
        await textDetector.processImage(InputImage.fromFile(widget.imageUrl));
    if (recognisedText.blocks.length > 0 ) {
      String text = "";

      for (TextBlock block in recognisedText.blocks) {
        for (TextLine line in block.lines) {
          for (TextElement word in line.elements) {
            text = text + word.text + " ";
          }
        }
      }

      textController = TextEditingController(text: "$text");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (isLoading)
          ? Center(child: loadingIndicator())
          : Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.defaultMargin, 40, SizeConfig.defaultMargin, 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () => closeScreen(context),
                        child: Icon(
                          Icons.close,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    CustomForm(textController, 
                      maxLines: 10,),
                    SizedBox(
                      height: 50,
                    ),
                    CustomForm(
                      textController,
                      readOnly: true,
                      labelStyle: greyFontStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      labelText: "Indonesia",
                      maxLines: 10,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:kamus_kamek/ui/screens/camera_screen.dart';
// import 'package:kamus_kamek/ui/widgets/text_detetcor_painter.dart';

// class ResultScreen extends StatefulWidget {
//   const ResultScreen({Key? key}) : super(key: key);

//   @override
//   _ResultScreenState createState() => _ResultScreenState();
// }

// class _ResultScreenState extends State<ResultScreen> {
//   TextDetector textDetector = GoogleMlKit.vision.textDetector();
//   bool isBusy = false;
//   CustomPaint? customPaint;

//   @override
//   void dispose() async {
//     super.dispose();
//     await textDetector.close();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CameraView(
//       title: "Text Detector",
//       customPaint: customPaint,
//       onImage: (inputImage) {
//         processImage(inputImage);
//       },
//     );
//   }

//   Future<void> processImage(InputImage inputImage) async {
//     if (isBusy) return;
//     isBusy = true;
//     final recognisedText = await textDetector.processImage(inputImage);
//     print('{==FOUND ${recognisedText.blocks.length} TEXTBLOCKS==}');
//     if (inputImage.inputImageData?.size != null &&
//         inputImage.inputImageData?.imageRotation != null) {
//       final painter = TextDetectorPainter(
//           recognisedText,
//           inputImage.inputImageData!.size,
//           inputImage.inputImageData!.imageRotation);
//       customPaint = CustomPaint(painter: painter);
//     } else {
//       customPaint = null;
//     }
//     isBusy = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }
// }
