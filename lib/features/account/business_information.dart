import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/social_login_widgets.dart';
import 'package:urbandrop/routes.dart';

class BusinessInformationPage extends StatefulWidget {
  const BusinessInformationPage({super.key});

  @override
  State<BusinessInformationPage> createState() => _BusinessInformationPageState();
}

class _BusinessInformationPageState extends State<BusinessInformationPage> {
  AuthenticationController authenticationController = AuthenticationController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldKey,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                padding: const EdgeInsets.only(top: 0),
                width: appWidth(context),
                color: primaryColor,
              ),
              Positioned(
                top: 70,
                child: Image.asset("assets/images/white_image.png",color: Colors.white,width: appWidth(context),height: 270,fit: BoxFit.fitHeight,),
              ),
              Positioned(
                top: 10,
                child: Image.asset("assets/images/background_1.png",width: appWidth(context),height: 300,fit: BoxFit.fitHeight,),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                sText("Business information",size: 20,weight: FontWeight.w700),
                const SizedBox(height: 10,),
                sText("Nearly there! Tell us the name of your business. This name will be displayed on your profile.",size: 14),
                const SizedBox(height: 20,),
                CustomTextField(
                  placeholder: "Business name",
                  onChange: (value){
                    setState(() {
                      authenticationController.emailValid = EmailValidator.validate(value);
                      authenticationController.email = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  placeholder: "Business type",
                  onChange: (value){
                    setState(() {
                      authenticationController.password = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  placeholder: "Address",
                  onChange: (value){
                    setState(() {
                      authenticationController.verifyPassword = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomTextField(
                        placeholder: "City/Town",
                        onChange: (value){
                          setState(() {
                            authenticationController.verifyPassword = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 2,
                      child: CustomTextField(
                        placeholder: "Postcode",
                        onChange: (value){
                          setState(() {
                            authenticationController.verifyPassword = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                mainButton(
                    content: sText("Continue",color: Colors.white,size: 18,weight: FontWeight.w600),
                    backgroundColor: primaryColor,
                    shadowStrength: 0,
                    height: 50,
                    radius: 30,
                    onPressed: (){
                      context.push(Routing.businessDescriptionPage);
                    }),
                const SizedBox(height: 20,),


              ],
            ),
          )
        ],
      ),
    );
  }
}
