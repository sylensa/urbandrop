import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/routes.dart';
class VerifyIdentityPage extends StatefulWidget {
  const VerifyIdentityPage({super.key});

  @override
  State<VerifyIdentityPage> createState() => _VerifyIdentityPageState();
}

class _VerifyIdentityPageState extends State<VerifyIdentityPage> {
AuthenticationController authenticationController = AuthenticationController();

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
            sText("Verify your identity",size: 20,weight: FontWeight.w700),
            const SizedBox(height: 10,),
            sText("Upload documents to verify your identity. You can upload a BRP, Passport, Driver’s License or any government issued document.",size: 14),
            const SizedBox(height: 20,),
            InkWell(
              onTap: ()async{
                if(authenticationController.frontImageFile == null){
                  authenticationController.frontImageFile = await authenticationController.attachCamera();
                }else {
                  authenticationController.backImageFile ??= await authenticationController.attachCamera();
                }
                setState(() {

                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0XFF879EA4)),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  children: [
                      Image.asset("assets/images/upload.png",width: 24,height: 24,),
                      const SizedBox(width: 20,),
                      Expanded(child: sText(authenticationController.frontImageFile == null ? "Tap to upload frontpage document*" : authenticationController.backImageFile == null ? "Tap to upload back page document*" : "Document selected successfully " ,size: 17,weight: FontWeight.w600,color: const Color(0XFF183A37)))
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20,),
            if(authenticationController.frontImageFile != null || authenticationController.backImageFile != null)
            GestureDetector(
              onTap: ()async{
                if(authenticationController.frontImageFile != null){
                  authenticationController.frontImageFile = null;
                  authenticationController.frontImageFile = await authenticationController.attachCamera();
                }else{
                  authenticationController.backImageFile = null;
                  authenticationController.backImageFile = await authenticationController.attachCamera();
                }
             setState(() {

             });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: sText("Re-upload",color: primaryColor,weight: FontWeight.w600,size: 16),
              ),
            ),
            // Row(
            //   children: [
            //     sText("Owners_BRP",color: Colors.black,size: 17,weight: FontWeight.w600),
            //     const SizedBox(width: 10,),
            //     Image.asset("assets/images/check-circle.png",width: 24,height: 24,)
            //   ],
            // ),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: mainButton(
                  content: sText("Continue",color: Colors.white,size: 18,weight: FontWeight.w600),
                  backgroundColor: authenticationController.frontImageFile != null && authenticationController.backImageFile != null ?primaryColor : Colors.grey[400]!,
                  shadowStrength: 0,
                  height: 50,
                  radius: 30,
                  onPressed: (){
                    if(authenticationController.frontImageFile != null && authenticationController.backImageFile != null){
                      context.push(Routing.takeSelfiePage);
                    }else{
                      toastMessage("Upload front and back of your document", context);
                    }

                  }),
            ),
          ],
        ),
      ),
    );
  }
}
