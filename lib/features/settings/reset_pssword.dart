import 'package:flutter/material.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
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
                    controller: currentPassword,
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
                    controller: newPassword,
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
                    controller: confirmNewPassword,
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
                        backgroundColor: currentPassword.text.isNotEmpty && newPassword.text.isNotEmpty && confirmNewPassword.text.isNotEmpty ? primaryColor : Colors.grey,
                        shadowStrength: 0,
                        height: 50,
                        radius: 30,
                        onPressed: ()async{
                          if(currentPassword.text.isNotEmpty && newPassword.text.isNotEmpty && confirmNewPassword.text.isNotEmpty){
                            if(confirmNewPassword.text == newPassword.text){
                              await AuthenticationController().changePassword(context,currentPassword: currentPassword.text,newPassword: newPassword.text);
                            }else{
                              toastMessage("New and confirm password does not match", context);
                            }
                          }else{
                            toastMessage("All fields are required", context);
                          }
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
