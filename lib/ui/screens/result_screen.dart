import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/ui/widgets/custom_form.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/size_config.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: "Stop");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
              CustomForm(textController),
              SizedBox(height: 50,),
              CustomForm(textController, readOnly: true, labelStyle: greyFontStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500), labelText: "Indonesia",)
            ],
          ),
        ),
      ),
    );
  }
}
