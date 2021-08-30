import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/cubit/api_key/api_key_cubit.dart';
import 'package:kamus_kamek/cubit/country/country_cubit.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:kamus_kamek/models/translation_model.dart';
import 'package:kamus_kamek/services/translation_services.dart';
import 'package:kamus_kamek/ui/widgets/custom_form.dart';
import 'package:kamus_kamek/ui/widgets/custom_label_flag_and_country.dart';
import 'package:kamus_kamek/ui/widgets/custom_toast.dart';
import 'package:kamus_kamek/ui/widgets/loading_indicator.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/size_config.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final LanguageIdentifier languageIdentifier =
      GoogleMlKit.nlp.languageIdentifier();

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

      // TODO: Will this be used?
      // final String languageIdentification =
      //     await languageIdentifier.identifyLanguage(text);
      // print("{ LANGUAGE IDENTIFICATION $languageIdentification}");

      if (context.read<CountryCubit>().state is CountryLoaded) {
        List<CountryModel> listCountries =
            (context.read<CountryCubit>().state as CountryLoaded).listCountries;
        country2 = listCountries.firstWhere(
            (element) => element.country == "Indonesian",
            orElse: () => listCountries[1]);
      }

      ApiReturnValue<TranslationModel> result =
          await TranslationServices.translateText(
              apiKey: (context.read<APIKeyCubit>().state as APIKeyLoaded)
                  .listAPIKeys
                  .firstWhere((element) => element.name == "cloud_translation")
                  .key,
              text: text,
              target: country2.code!);

      if (result.value == null) {
        releaseResources();
        closeScreen(context);
        customToast("Tidak dapat membaca teks");
      }

      if (context.read<CountryCubit>().state is CountryLoaded) {
        List<CountryModel> listCountries =
            (context.read<CountryCubit>().state as CountryLoaded).listCountries;
        country1 = listCountries.firstWhere(
            (element) =>
                element.country == result.value!.dectectedSourceLanguage,
            orElse: () => listCountries[0]);
      }

      textEditingController1 = TextEditingController(text: text);
      textEditingController2 =
          TextEditingController(text: "${result.value?.translatedText}");
    } else {
      releaseResources();
      closeScreen(context);
      customToast("Tidak dapat membaca teks");
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
      releaseResources();
    }
  }

  Future<String?> translateText(
      {required String text, required String target, String? source}) async {
    print("{ TEXT WILL TRANSLATE $text}");
    print("{ COUNTRY1 ${country1.code}}");
    print("{ COUNTRY2 ${country2.code}}");
    ApiReturnValue<TranslationModel> result =
        await TranslationServices.translateText(
            apiKey: (context.read<APIKeyCubit>().state as APIKeyLoaded)
                .listAPIKeys
                .firstWhere((element) => element.name == "cloud_translation")
                .key,
            text: text,
            target: target,
            source: source);

    if (result.value != null) {
      return result.value?.translatedText;
    } else {
      customToast(result.message!);
      return "";
    }
  }

  void releaseResources() {
    languageIdentifier.close();
    textDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        releaseResources();

        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: (isLoading)
            ? Center(child: loadingIndicator())
            : SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                        onTap: () {
                          releaseResources();
                          closeScreen(context);
                        },
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
                      onChanged: () async {
                        String? result = await translateText(
                            text: textEditingController1.text,
                            source: country1.code,
                            target: country2.code!);
                        setState(() {
                          textEditingController2 =
                              TextEditingController(text: result);
                        });
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
                    ),
                    SizedBox(
                      height: 40,
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
          return Container(
              constraints: BoxConstraints(
                maxHeight: SizeConfig.screenHeight * 0.9,
                minHeight: SizeConfig.screenHeight * 0.5,
              ),
              child: SingleChildScrollView(
                child: BlocBuilder<CountryCubit, CountryState>(
                  builder: (context, state) {
                    if (state is CountryLoaded) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: state.listCountries
                            .map((e) => InkWell(
                                  onTap: () async {
                                    closeScreen(context);
                                    if (isCountry1) {
                                      String? result = await translateText(
                                          text: textEditingController1.text,
                                          target: e.code!);
                                      textEditingController1 =
                                          TextEditingController(text: result);

                                      country1 = e;
                                    } else {
                                      country2 = e;
                                    }
                                    String? result = await translateText(
                                        text: textEditingController1.text,
                                        source: country1.code,
                                        target: country2.code!);
                                    textEditingController2 =
                                        TextEditingController(text: result);

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
                      );
                    } else if (state is CountryLoadingFailed) {
                      return SizedBox.shrink();
                    } else {
                      return Center(child: loadingIndicator());
                    }
                  },
                ),
              ));
        });
  }
}
