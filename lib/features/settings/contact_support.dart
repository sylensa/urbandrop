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
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:country_picker/country_picker.dart' as c;
import 'package:intl_phone_field/countries.dart' as intl;

class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({super.key});

  @override
  State<ContactSupportPage> createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  AuthenticationController authenticationController = AuthenticationController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController phoneNumbersController = TextEditingController();
  c.Country? country;
  Country? getCountry;
  String countryCode = "+44";
  String mask = '00-000-0000';
  String phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        title: sText("Contact Support",size: 15,weight: FontWeight.w600),
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
                  placeholder: "Full Name",
                  onChange: (value){
                    setState(() {
                      authenticationController.emailValid = EmailValidator.validate(value);
                      authenticationController.email = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  placeholder: "Business Name",
                  onChange: (value){
                    setState(() {
                      authenticationController.emailValid = EmailValidator.validate(value);
                      authenticationController.email = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  placeholder: "Phone Number",
                  onChange: (value){
                    setState(() {
                      authenticationController.emailValid = EmailValidator.validate(value);
                      authenticationController.email = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  placeholder: "Email Address",
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
                      sText("Subject/Category",color: const Color(0xFF879EA4)),
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
                sText("0/250",color: const Color(0XFF879EA4),size: 12),

                const SizedBox(height: 20,),
                mainButton(
                    content: sText("Submit",color: Colors.white,size: 18,weight: FontWeight.w600),
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
