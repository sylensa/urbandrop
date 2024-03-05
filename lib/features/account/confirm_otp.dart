import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/routes.dart';

class ConfirmOTP extends StatefulWidget {
  const ConfirmOTP({super.key});

  @override
  State<ConfirmOTP> createState() => _ConfirmOTPState();
}

class _ConfirmOTPState extends State<ConfirmOTP> {
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: scaffoldBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: sText("Verify mobile number",size: 20,weight: FontWeight.w700),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: sText("We must confirm that it is you in order to protect your security. Kindly input the 4-digit code that we sent to your mobile device. It expires in ten minutes.",size: 14),
            ),

            const SizedBox(height: 20,),
            Pinput(

              controller: pinController,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: () async{
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Resend Code',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: mainButton(
                  content: sText("Verify number",color: Colors.white,size: 18,weight: FontWeight.w600),
                  backgroundColor: primaryColor,
                  shadowStrength: 0,
                  height: 50,
                  radius: 30,
                  onPressed: (){
                    context.push(Routing.businessInformationPage);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
