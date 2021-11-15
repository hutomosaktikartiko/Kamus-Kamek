import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/custom_color.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/cubit/cubits.dart';
import 'package:kamus_kamek/ui/widgets/custom_dialog.dart';
import 'package:kamus_kamek/ui/widgets/custom_label_flag_and_country.dart';
import 'package:kamus_kamek/ui/widgets/loading_indicator.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/preferences.dart';
import 'package:kamus_kamek/utils/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamus_kamek/utils/utils.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkTheme = false;
  bool isLoading = true;

  String codeCountry = "";

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    await Preferences.instance()
        .then((value) => codeCountry = value.defaultLanguage);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: (isLoading) ? loadingIndicator() : buildBody(),
    );
  }

  Column buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // buildListCard(
        //     label: "Dark Theme",
        //     paddingVertical: 0,
        //     rightWidget: Switch(
        //         value: isDarkTheme,
        //         onChanged: (value) {
        //           setState(() {
        //             isDarkTheme = value;
        //           });
        //         })),
        buildListCard(
            label: "Default language",
            rightWidget: (codeCountry == "") ? Text("Select Country") : FadeInImage(
              placeholder: AssetImage("assets/images/placeholder.jpg"),
              height: 19,
              width: 27,
              fit: BoxFit.cover,
              image: NetworkImage(baseUrlFlag(codeCountry)),
            ),
            onTap: () {
              buildListSelectCountryItem();
            }),
        // buildListCard(
        //   label: "About Us",
        // ),
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
      {required String label,
      Widget? rightWidget,
      double? paddingVertical,
      Function? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
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

  void buildListSelectCountryItem() {
    CustomDialog.showBottomSheet(
      context: context,
      listCountries: (context.read<CountryCubit>().state as CountryLoaded)
          .listCountries
          .map((e) => InkWell(
                onTap: () async {
                  await Preferences.instance().then((pref) {
                    if (e.code != pref.defaultLanguage) {
                      closeScreen(context);
                      pref.defaultLanguage = e.code;

                      codeCountry = pref.defaultLanguage;

                      setState(() {});
                    } else {
                      CustomDialog.showToast(
                          "Tidak bisa memilih negara yang sama.");
                    }
                  });
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
}
