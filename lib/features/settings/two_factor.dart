import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';

class TwoFactor extends StatefulWidget {
  const TwoFactor({super.key});

  @override
  State<TwoFactor> createState() => _TwoFactorState();
}

class _TwoFactorState extends State<TwoFactor> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Two-Factor Authentication",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 20,),
                sText("To enhance the security of your Urbandrop Merchant account, we recommend enabling "
                    "Two-Factor Authentication (2FA). This additional layer of protection requires you to"
                    " enter a unique code along with your password during login.",size: 15,weight: FontWeight.w500),

                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: mainButton(
                        content: sText("Enable",color: Colors.white,size: 18,weight: FontWeight.w600),
                        backgroundColor: primaryColor,
                        shadowStrength: 0,
                        height: 50,
                        radius: 30,
                        onPressed: (){
                        }),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
