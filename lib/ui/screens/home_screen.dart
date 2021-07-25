import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/custom_color.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/ui/screens/result_screen.dart';
import 'package:kamus_kamek/ui/screens/setting_screen.dart';
import 'package:kamus_kamek/ui/widgets/custom_toast.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/size_config.dart';
import 'package:kamus_kamek/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey _scaffold = GlobalKey();

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
                    buildSelectedCountryCard(),
                    GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(Icons.swap_horiz),
                        )),
                    buildSelectedCountryCard(),
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
                Text(
                  "English",
                  style: mainColor2FontStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 19,
                ),
                TextFormField(
                  style: blackFontStyle.copyWith(
                      fontSize: 30, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: "Enter text",
                    hintStyle: mainColor2FontStyle.copyWith(
                        color: mainColor2.withOpacity(0.21),
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                Divider(),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Indonesia",
                  style: greyFontStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 19,
                ),
                TextFormField(
                  style: blackFontStyle.copyWith(
                      fontSize: 30, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    hintText: "Masukkan teks",
                    contentPadding: EdgeInsets.zero,
                    hintStyle: greyFontStyle.copyWith(
                        color: grey.withOpacity(0.21),
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  TextButton buildSelectedCountryCard() {
    return TextButton(
      style:
          TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 10)),
      onPressed: () {},
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/examples/flag_en.png",
              height: 26,
              width: 26,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "English",
            style: blackFontStyle.copyWith(
                fontSize: 14, fontWeight: FontWeight.w500),
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
                      Utils.pickeMedia(isGallery: false).then((value) =>
                          startScreen(_scaffold.currentContext!,
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
                      Utils.pickeMedia(isGallery: true).then((value) =>
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
