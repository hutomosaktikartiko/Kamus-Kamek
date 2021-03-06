import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/cubit/api_key/api_key_cubit.dart';
import 'package:kamus_kamek/cubit/country/country_cubit.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:kamus_kamek/models/translation_model.dart';
import 'package:kamus_kamek/services/image_services.dart';
import 'package:kamus_kamek/ui/screens/result_screen.dart';
import 'package:kamus_kamek/ui/screens/setting_screen.dart';
import 'package:kamus_kamek/ui/widgets/custom_connection_error.dart';
import 'package:kamus_kamek/ui/widgets/custom_dialog.dart';
import 'package:kamus_kamek/ui/widgets/custom_form.dart';
import 'package:kamus_kamek/ui/widgets/custom_label_flag_and_country.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/preferences.dart';
import 'package:kamus_kamek/utils/size_config.dart';
import 'package:kamus_kamek/services/translation_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  bool isLoading = true;
  bool isError = false;

  List<CountryModel> listCountries = [];

  @override
  void initState() {
    setInitValue();
    super.initState();
  }

  void setInitValue() async {
    if ((context.read<CountryCubit>().state is CountryLoaded) &&
        (context.read<APIKeyCubit>().state is APIKeyLoaded)) {
          String codeCountry = await Preferences.instance().then((value) => value.defaultLanguage);
      listCountries =
          (context.read<CountryCubit>().state as CountryLoaded).listCountries;
      country1 = listCountries.firstWhere(
          (element) => element.country == "English (US)",
          orElse: () => listCountries[0]);
      country2 = listCountries.firstWhere(
          (element) => element.code == codeCountry,
          orElse: () => listCountries[1]);
    } else {
      isError = true;
    }
    setState(() {});
  }

  Future<String?> translateText(
      {required String text, required String target, String? source}) async {
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
      CustomDialog.showToast(result.message!);
      return "";
    }
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      key: _scaffold,
      body: RefreshIndicator(
          onRefresh: () async {
            await context.read<CountryCubit>().getCountries();
            textEditingController1 = TextEditingController();
            textEditingController2 = TextEditingController();
            setInitValue();
          },
          child: (isError)
              ? CustomConnectionError(
                  message: "Terjadi Kesalahan Jaringan",
                  onTap: () async {
                    await context.read<CountryCubit>().getCountries();
                    await context.read<APIKeyCubit>().getAPIKeys();
                    setInitValue();
                  },
                )
              : buildBody()),
      floatingActionButton: (isError)
          ? null
          : FloatingActionButton(
              onPressed: () => showImageActionSheet(),
              child: Icon(Icons.camera),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: false,
    );
  }

  SafeArea buildBody() {
    return SafeArea(
      child: GestureDetector(
        onTap: () => hideKeyboard(),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                            padding: EdgeInsets.symmetric(horizontal: 5)),
                        onPressed: () {
                          buildBottomSheet(isCountry1: true);
                        },
                        child: buildSelectedCountryCard(country1),
                      ),
                      GestureDetector(
                        onTap: () async {
                          hideKeyboard();
                          CountryModel swicthCountry = country1;
                          String lastValue = textEditingController2.text;
                          setState(() {
                            country1 = country2;
                            country2 = swicthCountry;
                            textEditingController2 = TextEditingController(
                                text: textEditingController1.text);
                            textEditingController1 =
                                TextEditingController(text: lastValue);
                          });
                        },
                        child: Icon(Icons.swap_horiz),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 5)),
                        onPressed: () {
                          buildBottomSheet(isCountry1: false);
                        },
                        child: buildSelectedCountryCard(country2),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        hideKeyboard();
                        startScreen(context, SettingScreen());
                      },
                      child: Icon(Icons.settings))
                ],
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Container(
              height: SizeConfig.screenHeight * 0.859,
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(40))),
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  CustomForm(
                    textEditingController1,
                    maxLines: 10,
                    hintText: country1.hintText,
                    labelText: country1.country,
                    onTapLabel: () => buildBottomSheet(isCountry1: true),
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
                    onTapLabel: () => buildBottomSheet(isCountry1: false),
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
      ),
    );
  }

  void buildBottomSheet({required bool isCountry1}) {
    hideKeyboard();
    CustomDialog.showBottomSheet(
      context: context,
      listCountries: listCountries
          .map((e) => InkWell(
                onTap: () async {
                  if (e.code != country1.code && e.code != country2.code) {
                    closeScreen(context);
                    if (isCountry1) {
                      String? result = await translateText(
                          text: textEditingController1.text, target: e.code!);
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
                  } else {
                    CustomDialog.showToast(
                        "Tidak bisa memilih negara yang sama.");
                  }
                },
                child: Container(
                    width: SizeConfig.screenWidth,
                    padding: EdgeInsets.symmetric(
                        vertical: 15, horizontal: SizeConfig.defaultMargin),
                    child: CustomLabelFlagAndCountry(e)),
              ))
          .toList(),
    );
  }

  SizedBox buildSelectedCountryCard(CountryModel country) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.33,
      child: CustomLabelFlagAndCountry(country),
    );
  }

  void showImageActionSheet() {
    hideKeyboard();
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
                      var result =
                          await ImageServices.selectImage(isGallery: false);
                      if (result != null) {
                        startScreen(_scaffold.currentContext!,
                            ResultScreen(File(result.path)));
                      }
                    } catch (e) {
                      print("ERROR $e");
                      CustomDialog.showToast(e.toString());
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.perm_media),
                  title: Text("Galeri"),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      var result =
                          await ImageServices.selectImage(isGallery: true);
                      if (result != null) {
                        startScreen(_scaffold.currentContext!,
                            ResultScreen(File(result.path)));
                      }
                    } catch (e) {
                      print("ERROR $e");
                      CustomDialog.showToast(e.toString());
                    }
                  },
                ),
              ],
            ));
  }
}
