import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:country_picker/country_picker.dart' as c;
import 'package:intl_phone_field/countries.dart' as intl;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrop/routes.dart';
class VerifyIdentityPage extends StatefulWidget {
  const VerifyIdentityPage({super.key});

  @override
  State<VerifyIdentityPage> createState() => _VerifyIdentityPageState();
}

class _VerifyIdentityPageState extends State<VerifyIdentityPage> {

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
            sText("Verify your identity",size: 20,weight: FontWeight.w700),
            const SizedBox(height: 10,),
            sText("Upload documents to verify your identity. You can upload a BRP, Passport, Driver’s License or any government issued document.",size: 14),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0XFF879EA4)),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                children: [
                    Image.asset("assets/images/upload.png",width: 24,height: 24,),
                    const SizedBox(width: 20,),
                    sText("Upload Document*",size: 17,weight: FontWeight.w600,color: const Color(0XFF183A37))
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                sText("Owners_BRP",color: Colors.black,size: 17,weight: FontWeight.w600),
                const SizedBox(width: 10,),
                Image.asset("assets/images/check-circle.png",width: 24,height: 24,)
              ],
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
                  onPressed: (){
                    context.push(Routing.takeSelfiePage);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
