import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/routes.dart';

class ConfirmOTP extends StatefulWidget {
  final bool confirmEmail;
  const ConfirmOTP({super.key, required this.confirmEmail});

  @override
  State<ConfirmOTP> createState() => _ConfirmOTPState();
}

class _ConfirmOTPState extends State<ConfirmOTP> {
  TextEditingController pinController = TextEditingController();
  AuthenticationController authenticationController = AuthenticationController();
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
              child: sText(widget.confirmEmail ? "Verify email address" : "Verify mobile number",size: 20,weight: FontWeight.w700),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: sText("We must confirm that it is you in order to protect your security. Kindly input the 4-digit code that we sent to your ${widget.confirmEmail ? "${userInstance?.email}" : "${userInstance?.mcc}${userInstance?.mobileNumber}"}. It expires in ten minutes.",size: 14),
            ),

            const SizedBox(height: 20,),
            Pinput(
              controller: pinController,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              onChanged: (v){
                setState(() {

                  authenticationController.pinCode = v;
                });
              },
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: () async{
                if(!widget.confirmEmail){
                  authenticationController.resendEmail(context,);
                }else{
                  print("${userInstance?.mcc}");
                  authenticationController.mobileNumber = "${userInstance?.mcc}${userInstance?.mobileNumber}";
                  authenticationController.mobileNumberWithoutCountryCode = "${userInstance?.mobileNumber}";
                  authenticationController.mcc = "${userInstance?.mcc}";
                  authenticationController.resendOTP(context,verify: false);
                }

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
                  content: sText("Verify ${widget.confirmEmail ? "email" : "number"}",color: Colors.white,size: 18,weight: FontWeight.w600),
                  backgroundColor:authenticationController.validatePinCode() ? primaryColor : Colors.grey,
                  shadowStrength: 0,
                  height: 50,
                  radius: 30,
                  onPressed: (){
                    print(authenticationController.validatePinCode());
                    if(authenticationController.validatePinCode()){
                    if(widget.confirmEmail){
                      authenticationController.verifyEmail(context,);
                    }
                    else{
                      authenticationController.verifyMobile(context,);
                    }

                    }


                  }),
            ),
          ],
        ),
      ),
    );
  }
}
