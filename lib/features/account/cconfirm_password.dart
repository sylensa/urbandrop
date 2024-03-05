import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:country_picker/country_picker.dart' as c;
import 'package:intl_phone_field/countries.dart' as intl;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/routes.dart';
class ConfirmPasswordPage extends StatefulWidget {
  const ConfirmPasswordPage({super.key});

  @override
  State<ConfirmPasswordPage> createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: scaffoldBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: CustomTextField(
                placeholder: "Password",
                prefixImage: "lock.png",
                obscureText: true,
                onChange: (value){
                  setState(() {
                  });
                },
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: CustomTextField(
                placeholder: "Confirm Password",
                prefixImage: "lock.png",
                obscureText: true,
                onChange: (value){
                  setState(() {
                  });
                },
              ),
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: mainButton(
                  content: sText("Save",color: Colors.white,size: 18,weight: FontWeight.w600),
                  backgroundColor: primaryColor,
                  shadowStrength: 0,
                  height: 50,
                  radius: 30,
                  onPressed: (){
                    context.push(Routing.confirmOTP);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
