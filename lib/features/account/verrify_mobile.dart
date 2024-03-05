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
class VerifyMobilePage extends StatefulWidget {
  const VerifyMobilePage({super.key});

  @override
  State<VerifyMobilePage> createState() => _VerifyMobilePageState();
}

class _VerifyMobilePageState extends State<VerifyMobilePage> {
  TextEditingController phoneNumbersController = TextEditingController();
  c.Country? country;
  Country? getCountry;
  String countryCode = "+44";
  String mask = '00-000-0000';
  String phoneNumber = '';
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
            sText("Enter your mobile number",size: 20,weight: FontWeight.w700),
            const SizedBox(height: 10,),
            sText("Activation code will be sent to your mobile number to sign up",size: 14),
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

                  initialCountryCode: isoCountryCodes != null ? isoCountryCodes!.toUpperCase() : "UK" ,
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
                      phoneNumber = phone.number.split("-").join("");
                      countryCode = phone.countryCode;
                      print("phoneNumber:$phoneNumber");
                      print("countryCode:$countryCode");
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
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: mainButton(
                  content: sText("Continue",color: Colors.white,size: 18,weight: FontWeight.w600),
                  backgroundColor: primaryColor,
                  shadowStrength: 0,
                  height: 50,
                  radius: 30,
                  onPressed: (){
                    context.push(Routing.confirmOTP);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
