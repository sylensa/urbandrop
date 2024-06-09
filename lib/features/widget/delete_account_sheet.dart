import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';

class DeleteAccountSheet extends StatelessWidget {
  final String title;
  final bool? isDelete;
  final AuthenticationController authenticationController;
  const DeleteAccountSheet({super.key, required this.title, required this.authenticationController, this.isDelete = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20,),
          Image.asset("assets/images/delete_account.png"),
          const SizedBox(height: 20,),
          isDelete! ?
          sText("Once you delete your account, there’s no getting it back. Are you sure you want to do this?",size: 15,weight: FontWeight.w500,align: TextAlign.center) :
          sText("Once you deactivate your account, you'll be able to reactive your account. Are you sure you want to do this?",size: 15,weight: FontWeight.w500,align: TextAlign.center) ,
          const SizedBox(height: 40,),
          mainButton(
              width: appWidth(context),
              height: 50,
              radius: 30,
              outlineColor: Colors.transparent,
              shadowStrength: 0,
              backgroundColor: appMainRedColor,
              content:  sText(title,color: Colors.white,weight: FontWeight.w600,size: 18),
              onPressed:()async{
                context.pop();
                if(isDelete!){
                  await authenticationController.delete(context, {
                    "reason": authenticationController.deleteOptions?.name,
                    "description":authenticationController.deleteDescription.text
                  });
                }else{
                  await authenticationController.deactivate(context, {
                    "reason": authenticationController.deactivateOptions?.name,
                    "description":authenticationController.deactivateDescription.text
                  });
                }

              }),
          const SizedBox(height: 20,),
          mainButton(
              width: appWidth(context),
              height: 50,
              radius: 30,
              outlineColor: const Color(0XFF183A37),
              shadowStrength: 0,
              backgroundColor: Colors.white,
              content:  sText("Go back",color:  const Color(0XFF183A37),weight: FontWeight.w600,size: 18),
              onPressed:()async{
                context.pop();

              }),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
