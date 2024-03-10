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

class UpdateBusinessInformationPage extends StatefulWidget {
  const UpdateBusinessInformationPage({super.key});

  @override
  State<UpdateBusinessInformationPage> createState() => _UpdateBusinessInformationPageState();
}

class _UpdateBusinessInformationPageState extends State<UpdateBusinessInformationPage> {
  AuthenticationController authenticationController = AuthenticationController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        title: sText("Shop information",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: const Color(0XFF1F546033)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      sText("Business type",color: Color(0xFF879EA4)),
                      const Icon(Icons.keyboard_arrow_down,color: Color(0XFF879EA4),)
                    ],
                  ),
                ),
              
                const SizedBox(height: 20,),
                SizedBox(
                  height: 200,
                  child: CustomDescriptionField(
                    placeholder: "Write description",
                    maxLines: 5,
                    onChange: (value){
                      setState(() {
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                sText("0/150",color: const Color(0XFF879EA4),size: 12),
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
                    content: sText("Save",color: Colors.white,size: 18,weight: FontWeight.w600),
                    backgroundColor: primaryColor,
                    shadowStrength: 0,
                    height: 50,
                    radius: 30,
                    onPressed: (){
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
