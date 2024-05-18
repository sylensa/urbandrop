import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:country_picker/country_picker.dart' as c;
import 'package:intl_phone_field/countries.dart' as intl;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrop/routes.dart';
class TakeSelfiePage extends StatefulWidget {
  const TakeSelfiePage({super.key});

  @override
  State<TakeSelfiePage> createState() => _TakeSelfiePageState();
}

class _TakeSelfiePageState extends State<TakeSelfiePage> {
  AuthenticationController authenticationController = AuthenticationController();

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
            sText("Take a selfie",size: 20,weight: FontWeight.w700),
            const SizedBox(height: 10,),
            sText("This selfie will be used to verify your identity",size: 14),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Image.asset("assets/images/selfie_1.png",width: 108,height: 123,)),
                  const SizedBox(width: 10,),
                  Expanded(child: Image.asset("assets/images/selfie_2.png",width: 108,height: 123,)),
                  const SizedBox(width: 10,),
                  Expanded(child: Image.asset("assets/images/selfie_3.png",width: 108,height: 123,)),

                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/selfie_4.png",width: 108,height: 123,),
                  const SizedBox(width: 20,),
                  Image.asset("assets/images/selfie_5.png",width: 108,height: 123,),

                ],
              ),
            ),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: mainButton(
                  content: sText("Continue",color: Colors.white,size: 18,weight: FontWeight.w600),
                  backgroundColor: primaryColor,
                  shadowStrength: 0,
                  height: 50,
                  radius: 30,
                  onPressed: ()async{
                    await context.push(Routing.selfieCameraScreen);
                    setState(() {
                      print("sellfie:${authenticationController.selfieImageFile?.path}");

                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
