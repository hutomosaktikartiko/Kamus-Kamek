import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:kamus_kamek/models/translation_model.dart';
import 'package:kamus_kamek/services/country_services.dart';
import 'package:kamus_kamek/services/image_services.dart';
import 'package:kamus_kamek/ui/screens/result_screen.dart';
import 'package:kamus_kamek/ui/screens/setting_screen.dart';
import 'package:kamus_kamek/ui/widgets/custom_form.dart';
import 'package:kamus_kamek/ui/widgets/custom_toast.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/size_config.dart';
import 'package:kamus_kamek/services/translation_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey _scaffold = GlobalKey();

  late CountryModel country1;
  late CountryModel country2;

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  @override
  void initState() {
    country1 = listCountries
        .firstWhere((element) => element.country == "English (US)");
    country2 =
        listCountries.firstWhere((element) => element.country == "Indonesian");
    super.initState();
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
      backgroundColor: Color(0xFFE5E5E5),
      key: _scaffold,
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showImageActionSheet(),
        child: Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: false,
    );
  }

  SafeArea buildBody() {
    return SafeArea(
      child: ListView(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 10)),
                      onPressed: () {
                        buildBottomSheet(true);
                      },
                      child: buildSelectedCountryCard(country1),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.swap_horiz),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 10)),
                      onPressed: () {
                        buildBottomSheet(false);
                      },
                      child: buildSelectedCountryCard(country2),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () => startScreen(context, SettingScreen()),
                    child: Icon(Icons.settings))
              ],
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Container(
            height: SizeConfig.screenHeight * 0.859,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18,
                ),
                CustomForm(
                  textEditingController1,
                  maxLines: 10,
                  hintText: country1.hintText,
                  labelText: country1.country,
                  onTapLabel: () => buildBottomSheet(true),
                  onChanged: () {
                    translateText(textEditingController1.text);
                  },
                ),
                SizedBox(
                  height: 90,
                ),
                Divider(),
                SizedBox(
                  height: 18,
                ),
                CustomForm(
                  textEditingController2,
                  readOnly: true,
                  hintText: country2.hintText,
                  onTapLabel: () => buildBottomSheet(false),
                  labelStyle: greyFontStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                  labelText: country2.country,
                  maxLines: 10,
                  hintStyle: greyFontStyle.copyWith(
                      fontSize: 30, fontWeight: FontWeight.w600),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void buildBottomSheet(bool isCountry1) {
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
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FadeInImage(
                                        placeholder: AssetImage(
                                            "assets/images/placeholder.jpg"),
                                        height: 26,
                                        width: 26,
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${e.flagUrl}"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        e.country!,
                                        style: blackFontStyle.copyWith(
                                            fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )),
                          ))
                      .toList(),
                ),
              ));
        });
  }

  SizedBox buildSelectedCountryCard(CountryModel country) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.3,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              placeholder: AssetImage("assets/images/placeholder.jpg"),
              height: 26,
              width: 26,
              fit: BoxFit.cover,
              image: NetworkImage("${country.flagUrl}"),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              country.country ?? "",
              style: blackFontStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  void showImageActionSheet() {
    showModalBottomSheet(
        context: _scaffold.currentContext!,
        builder: (context) => Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Kamera"),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      ImageServices.selectImage(isGallery: false).then(
                          (value) => startScreen(_scaffold.currentContext!,
                              ResultScreen(File(value.path))));
                    } catch (e) {
                      print("ERROR $e");
                      customToast(e.toString());
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.perm_media),
                  title: Text("Galeri"),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      ImageServices.selectImage(isGallery: true).then((value) =>
                          startScreen(_scaffold.currentContext!,
                              ResultScreen(File(value.path))));
                    } catch (e) {
                      print("ERROR $e");
                      customToast(e.toString());
                    }
                  },
                ),
              ],
            ));
  }
}
