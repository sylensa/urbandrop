import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/bottomsheet_ex.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/delete_account_sheet.dart';
import 'package:urbandrop/features/widget/radio_text_widget.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  AuthenticationController authenticationController =  AuthenticationController();

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Delete Account",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sText("Deleting your account will permanently remove all your data, "
                "including profile information, saved preferences, and activity history. "
                "You will lose access to your subscription benefits, if any, "
                "and any unused credits or rewards associated with your account will be forfeited.",size: 12,weight: FontWeight.w400),
            const SizedBox(height: 20,),
            sText("Tell us why you’re leaving?",size: 12,weight: FontWeight.w600),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                children: [
                  for(int index = 0 ; index < authenticationController.data.length; index++)
                  Column(
                    children: [
                      RadioTextWidget(
                        onTap: (){
                          setState(() {
                           authenticationController.deleteOptions =  authenticationController.data[index];
                          });
                        },
                          selected: authenticationController.deleteOptions?.name == authenticationController.data[index].name ,
                          text:authenticationController.data[index].name
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 200,
                    child: CustomDescriptionField(
                      controller: authenticationController.deleteDescription,
                      placeholder: "Write description",
                      onChange: (value){
                        setState(() {
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            mainButton(
                width: appWidth(context),
                height: 50,
                radius: 30,
                outlineColor: Colors.transparent,
                shadowStrength: 0,
                backgroundColor:authenticationController.deleteDescription.text.isNotEmpty && authenticationController.deleteOptions != null ? appMainRedColor :Colors.grey,
                content:  sText("Delete account",color: Colors.white,weight: FontWeight.w600,size: 18),
                onPressed:(){
                  if(authenticationController.deleteDescription.text.isNotEmpty && authenticationController.deleteOptions != null) {
                    DeleteAccountSheet(title: "Delete account",authenticationController: authenticationController,).asFixedBottomSheet(context, title: "Delete account", showCotrols: false);
                  }
                }),

          ],
        ),
      ),
    );
  }
}
