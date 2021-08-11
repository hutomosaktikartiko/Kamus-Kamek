import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:kamus_kamek/models/translation_model.dart';
import 'package:kamus_kamek/services/country_services.dart';
import 'package:kamus_kamek/services/translation_services.dart';
import 'package:kamus_kamek/ui/widgets/custom_form.dart';
import 'package:kamus_kamek/ui/widgets/custom_label_flag_and_country.dart';
import 'package:kamus_kamek/ui/widgets/custom_toast.dart';
import 'package:kamus_kamek/ui/widgets/loading_indicator.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/size_config.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen(this.imageUrl, {Key? key}) : super(key: key);

  final File imageUrl;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late TextEditingController textEditingController1;
  late TextEditingController textEditingController2;
  bool isLoading = true;

  late CountryModel country1;
  late CountryModel country2;

  @override
  void initState() {
    super.initState();
    recognisedText();
  }

  final TextDetector textDetector = GoogleMlKit.vision.textDetector();

  Future recognisedText() async {
    final RecognisedText recognisedText =
        await textDetector.processImage(InputImage.fromFile(widget.imageUrl));
    if (recognisedText.blocks.length > 0) {
      String text = "";

      for (TextBlock block in recognisedText.blocks) {
        for (TextLine line in block.lines) {
          for (TextElement word in line.elements) {
            text = text + word.text + " ";
          }
        }
      }

      country2 = listCountries
          .firstWhere((element) => element.country == "Indonesian");

      ApiReturnValue<TranslationModel> result =
          await TranslationServices.translateText(
              text: text, target: country2.code ?? "id");

      if (result.value != null) {
        textEditingController1 = TextEditingController(text: text);
        textEditingController2 =
            TextEditingController(text: "${result.value?.translatedText}");
        country1 = listCountries.firstWhere((element) =>
            (element.code == result.value!.dectectedSourceLanguage));
      } else {
        textEditingController1 = TextEditingController();
        textEditingController2 = TextEditingController();
        country1 = listCountries
            .firstWhere((element) => element.country == "English (US)");
        country2 = listCountries
            .firstWhere((element) => element.country == "Indonesian");
        customToast(
            result.message ?? "Gagal menerjemahkan, silahkan coba kembali!");
      }
    } else {
      closeScreen(context);
      customToast("Tidak dapat membaca teks");
    }

    setState(() {
      isLoading = false;
    });
  }

  Future translateText(String text) async {
    ApiReturnValue<TranslationModel> result =
        await TranslationServices.translateText(
            text: text, target: country2.code!, source: country1.code);

    if (result.value != null) {
      setState(() {
        textEditingController2 =
            TextEditingController(text: result.value?.translatedText);
      });
    } else {
      customToast(result.message!);
    }
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
                    CustomForm(
                      textEditingController1,
                      maxLines: 10,
                      onTapLabel: () => buildListSelectCountryItem(true),
                      labelText: country1.country,
                      onChanged: () {
                        translateText(textEditingController1.text);
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomForm(
                      textEditingController2,
                      readOnly: true,
                      labelStyle: greyFontStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      labelText: country2.country,
                      maxLines: 10,
                      onTapLabel: () => buildListSelectCountryItem(false),
                      hintStyle: greyFontStyle.copyWith(
                          fontSize: 30, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void buildListSelectCountryItem(bool isCountry1) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
              height: SizeConfig.screenHeight * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: CountryServices.getCountry()
                      .map((e) => InkWell(
                            onTap: () {
                              closeScreen(context);
                              if (isCountry1) {
                                country1 = e;
                              } else {
                                country2 = e;
                              }
                              translateText(textEditingController1.text);
                              setState(() {});
                            },
                            child: Container(
                                width: SizeConfig.screenWidth,
                                padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: SizeConfig.defaultMargin),
                                child: CustomLabelFlagAndCountry(e)),
                          ))
                      .toList(),
                ),
              ));
        });
  }
}
