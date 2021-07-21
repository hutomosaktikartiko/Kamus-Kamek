import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/custom_color.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: buildBody(),
    );
  }

  SafeArea buildBody() {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 10),
        children: [
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
                GestureDetector(onTap: () {}, child: Icon(Icons.settings))
              ],
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Container(
            height: SizeConfig.screenHeight * 0.83,
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(40))),
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
}
