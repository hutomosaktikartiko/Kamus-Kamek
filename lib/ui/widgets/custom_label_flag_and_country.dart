import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/models/country_model.dart';

class CustomLabelFlagAndCountry extends StatelessWidget {
  const CustomLabelFlagAndCountry(
    this.country, {
    Key? key,
  }) : super(key: key);

  final CountryModel country;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FadeInImage(
          placeholder: AssetImage("assets/images/placeholder.jpg"),
          height: 19,
          width: 27,
          fit: BoxFit.cover,
          image: NetworkImage("${country.flagUrl}"),
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
    );
  }
}
