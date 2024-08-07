import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
  TextEditingController description = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController subject = TextEditingController();
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
                  controller: firstName,
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
                  controller: businessName,
                  placeholder: "Business Name",
                  onChange: (value){
                    setState(() {
                      authenticationController.emailValid = EmailValidator.validate(value);
                      authenticationController.email = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                IntlPhoneField(
                    decoration:   const InputDecoration(
                        counterStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1F546033), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1F546033), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Color(0xFF1F546033), width: 1),
                          borderRadius:  BorderRadius.all(Radius.circular(30)),
                        ),
                        fillColor: Colors.white,
                        filled: true


                    ),
                    dropdownIcon: const Icon(Icons.arrow_drop_down_rounded,color: Colors.black,),
                    controller: phoneNumbersController,

                    initialCountryCode: authenticationController.isoCountryCodes ,
                    disableLengthCheck: true,
                    dropdownTextStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    dropdownIconPosition: IconPosition.trailing,
                    textInputAction: TextInputAction.go,
                    autofocus: false,
                    style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    flagsButtonPadding: const EdgeInsets.only(left: 8),
                    textAlignVertical: TextAlignVertical.center,
                    inputFormatters: [
                      MaskedTextInputFormatter(mask: mask),
                    ],
                    validator: (phone) {
                      final isValid = phone?.completeNumber.isEmpty;
                      if(isValid != null && isValid) {
                        return 'invalid phone number';
                      }
                      return null;
                    },
                    onChanged: (phone) {
                      setState(() {
                        authenticationController.mobileNumber = phone.completeNumber.split("-").join("");
                        authenticationController.mcc = phone.countryCode;
                        authenticationController.mobileNumberWithoutCountryCode = phone.number.split("-").join("");
                        authenticationController.isoCountryCodes = phone.countryISOCode;
                        print("phoneNumber:${authenticationController.mobileNumber}");
                        print("countryCode:${authenticationController.mcc}");
                        print("isoCountryCodes:${authenticationController.isoCountryCodes}");
                        print("maxLength:${intl.countries.firstWhere((element) => element.code == phone.countryISOCode).maxLength}");
                        if(intl.countries.firstWhere((element) => element.code == phone.countryISOCode).maxLength == 9){
                          mask = "00-000-0000";
                        }else if(intl.countries.firstWhere((element) => element.code == phone.countryISOCode).maxLength == 10){
                          mask = '00-0000-0000';
                        }else if(intl.countries.firstWhere((element) => element.code == phone.countryISOCode).maxLength == 11){
                          mask = '000-0000-0000';
                        }else{
                          mask = '0000-0000-0000';
                        }
                      });
                    }
                  // },
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  controller: email,
                  placeholder: "Email Address",
                  onChange: (value){
                    setState(() {
                      authenticationController.emailValid = EmailValidator.validate(value);
                      authenticationController.email = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  controller: subject,
                  placeholder: "Subject",
                  onChange: (value){
                    setState(() {

                    });
                  },
                ),

                const SizedBox(height: 20,),
                SizedBox(
                  height: 200,
                  child: CustomDescriptionField(
                    controller:description ,
                    placeholder: "Write description",
                    onChange: (value){
                      setState(() {
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                sText("${description.text.length}/250",color: const Color(0XFF879EA4),size: 12),

                const SizedBox(height: 20,),
                mainButton(
                    content: sText("Submit",color: Colors.white,size: 18,weight: FontWeight.w600),
                    backgroundColor: primaryColor,
                    shadowStrength: 0,
                    height: 50,
                    radius: 30,
                    onPressed: ()async{
                      if(firstName.text.isNotEmpty && businessName.text.isNotEmpty && authenticationController.mobileNumber.isNotEmpty && email.text.isNotEmpty && subject.text.isNotEmpty && description.text.isNotEmpty){
                       await  authenticationController.contactSupport(context, {
                          "full_name": firstName.text,
                          "business_name": businessName.text,
                          "email": email.text,
                          "mobile_number":authenticationController.mobileNumber,
                          "subject": subject.text,
                          "message": description.text
                        });
                      }else{
                        toastMessage("All fields are required", context);
                      }
                      
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
