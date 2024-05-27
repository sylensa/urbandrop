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
class UploadSelfiePage extends StatefulWidget {
  const UploadSelfiePage({super.key});

  @override
  State<UploadSelfiePage> createState() => _UploadSelfiePageState();
}

class _UploadSelfiePageState extends State<UploadSelfiePage> {


  @override
  Widget build(BuildContext context) {
    print("selfie:${authenticationController.selfieImageFile?.path}");
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
            Expanded(
              child: ListView(
                children: [
                  sText("Upload selfie",size: 20,weight: FontWeight.w700),
                  const SizedBox(height: 10,),
                  sText("This selfie will be used to verify your identity",size: 14),
                  const SizedBox(height: 20,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: displayLocalImageDevice("${authenticationController.selfieImageFile?.path}",radius: 0,height: 400,width: appWidth(context)),
                  ),

                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: mainButton(
                        content: sText("Complete",color: Colors.white,size: 18,weight: FontWeight.w600),
                        backgroundColor: primaryColor,
                        shadowStrength: 0,
                        height: 50,
                        radius: 30,
                        onPressed: ()async{
                         var response = await authenticationController.signUpKYC(context);
                         if(response){
                           context.go(Routing.successfulPage);
                         }

                        }),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: outlineButton(
                        content: sText("Retake",color: Color(0XFF183A37),size: 18,weight: FontWeight.w600),
                        backgroundColor: Colors.white,
                        shadowStrength: 0,
                        height: 50,
                        radius: 30,
                        onPressed: ()async{
                           context.pop();
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
