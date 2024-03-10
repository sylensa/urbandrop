import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';

class PaymentInformation extends StatefulWidget {
  const PaymentInformation({super.key});

  @override
  State<PaymentInformation> createState() => _PaymentInformationState();
}

class _PaymentInformationState extends State<PaymentInformation> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Payment information",size: 15,weight: FontWeight.w600),
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
                  CustomTextField(
                    placeholder: "Account Name",
                    onChange: (value){

                    },
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    placeholder: "Account number",
                    onChange: (value){

                    },
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    placeholder: "Sort code",
                    onChange: (value){

                    },
                  ),

                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: mainButton(
                        content: sText("Save",color: Colors.white,size: 18,weight: FontWeight.w600),
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
