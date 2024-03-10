import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Password",size: 15,weight: FontWeight.w600),
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
                    placeholder: "Current Password",
                    prefixImage: "lock.png",
                    obscureText: true,
                    onChange: (value){
                      setState(() {
                      });
                    },
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    placeholder: "New Password",
                    prefixImage: "lock.png",
                    obscureText: true,
                    onChange: (value){
                      setState(() {
                      });
                    },
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    placeholder: "Confirm Password",
                    prefixImage: "lock.png",
                    obscureText: true,
                    onChange: (value){
                      setState(() {
                      });
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
