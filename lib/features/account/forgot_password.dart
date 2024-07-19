import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:country_picker/country_picker.dart' as c;
import 'package:intl_phone_field/countries.dart' as intl;
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/routes.dart';
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

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
            sText("Enter email",size: 20,weight: FontWeight.w700),
            const SizedBox(height: 10,),
            sText("Enter your email address to receive a pass word reset link.",size: 14),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: CustomTextField(
                placeholder: "Email",
                controller: emailController,
                prefixImage: "email.png",
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
                  content: sText("Continue",color: Colors.white,size: 18,weight: FontWeight.w600),
                  backgroundColor: emailController.text.isNotEmpty ? primaryColor : Colors.grey,
                  shadowStrength: 0,
                  height: 50,
                  radius: 30,
                  onPressed: (){
                    if(emailController.text.isNotEmpty){
                      AuthenticationController().sendPasswordLink(context,email: emailController.text);
                    }

                  }),
            ),
          ],
        ),
      ),
    );
  }
}
