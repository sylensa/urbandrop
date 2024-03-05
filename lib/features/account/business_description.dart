import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:country_picker/country_picker.dart' as c;
import 'package:intl_phone_field/countries.dart' as intl;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/routes.dart';
class BusinessDescriptionPage extends StatefulWidget {
  const BusinessDescriptionPage({super.key});

  @override
  State<BusinessDescriptionPage> createState() => _BusinessDescriptionPageState();
}

class _BusinessDescriptionPageState extends State<BusinessDescriptionPage> {
  TextEditingController phoneNumbersController = TextEditingController();

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
            sText("Business description",size: 20,weight: FontWeight.w700),
            const SizedBox(height: 10,),
            sText("Nearly there! Give a brief description about your business to help users",size: 14),
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
                    context.push(Routing.confirmOTP);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
