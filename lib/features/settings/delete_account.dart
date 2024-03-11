import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  List<ListNames> data = [
    ListNames(name: "Found a better alternative",enable: false),
    ListNames(name: "Dissatisfied with service/features",enable: false),
    ListNames(name: "Moving to a different location",enable: false),
    ListNames(name: "Account compromised/security concerns",enable: false),
    ListNames(name: "Personal reasons / Financial reasons",enable: false),
    ListNames(name: "Other (enter reason below)",enable: false),
  ];
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
                  for(int index = 0 ; index < data.length; index++)
                  Column(
                    children: [
                      RadioTextWidget(
                        onTap: (){
                          setState(() {
                           for(int i =0; i < data.length;i++){
                             data[i].enable = false;
                           }
                            data[index].enable = true;
                          });
                        },
                          selected:data[index].enable ,
                          text:data[index].name
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                  const SizedBox(height: 10,),
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
                backgroundColor: appMainRedColor,
                content:  sText("Delete account",color: Colors.white,weight: FontWeight.w600,size: 18),
                onPressed:(){
                   const DeleteAccountSheet(title: "Delete account").asFixedBottomSheet(context, title: "Delete account", showCotrols: false);

                }),

          ],
        ),
      ),
    );
  }
}
