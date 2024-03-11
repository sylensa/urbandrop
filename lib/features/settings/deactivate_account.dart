import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/bottomsheet_ex.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/delete_account_sheet.dart';
import 'package:urbandrop/features/widget/radio_text_widget.dart';

class DeactivateAccount extends StatefulWidget {
  const DeactivateAccount({super.key});

  @override
  State<DeactivateAccount> createState() => _DeactivateAccountState();
}

class _DeactivateAccountState extends State<DeactivateAccount> {
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
        title: sText("Deactivate Account",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sText("Are you sure you want to deactivate your Urbandrop Merchant account?"
                " Deactivating your account will disable access to the platform, and you "
                "will no longer be able to receive orders or manage your business. Please note "
                "that this action is irreversible.",size: 12,weight: FontWeight.w400),
            const SizedBox(height: 20,),
            sText("Tell us why you’re deactivating?",size: 12,weight: FontWeight.w600),
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
                content:  sText("Deactivate account",color: Colors.white,weight: FontWeight.w600,size: 18),
                onPressed:(){
                  const DeleteAccountSheet(title: "Deactivate account").asFixedBottomSheet(context, title: "Delete account", showCotrols: false);

                }),

          ],
        ),
      ),
    );
  }
}
