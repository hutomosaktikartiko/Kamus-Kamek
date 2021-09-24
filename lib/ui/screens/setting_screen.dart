import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/custom_color.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/size_config.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  Column buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildListCard(
            label: "Dark Theme",
            paddingVertical: 0,
            rightWidget: Switch(
                value: isDarkTheme,
                onChanged: (value) {
                  setState(() {
                    isDarkTheme = value;
                  });
                })),
        buildListCard(
          label: "Default language",
        ),
        buildListCard(
          label: "About Us",
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        "Pengaturan",
        style:
            blackFontStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () => closeScreen(context),
        child: Icon(
          Icons.arrow_back_ios,
          color: grey,
        ),
      ),
    );
  }

  InkWell buildListCard(
      {required String label, Widget? rightWidget, double? paddingVertical}) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.defaultMargin,
            vertical: (paddingVertical == null) ? 15 : paddingVertical),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: blackFontStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            (rightWidget == null)
                ? Icon(
                    Icons.arrow_forward_ios,
                    color: grey,
                  )
                : rightWidget
          ],
        ),
      ),
    );
  }
}
