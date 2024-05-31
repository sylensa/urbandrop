import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Routing;
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';

import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/routes.dart';
class BusinessDescriptionPage extends StatefulWidget {
  const BusinessDescriptionPage({super.key});

  @override
  State<BusinessDescriptionPage> createState() => _BusinessDescriptionPageState();
}

class _BusinessDescriptionPageState extends State<BusinessDescriptionPage> {
  AuthenticationController authenticationController = AuthenticationController();
  TextEditingController businessDescription = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    businessDescription.text = userInstance?.businessDescription ?? "";
    authenticationController.businessDescription = userInstance?.businessDescription ?? "";
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: scaffoldBackgroundColor,
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              sText("Business description",size: 20,weight: FontWeight.w700),
              const SizedBox(height: 10,),
              sText("Nearly there! Give a brief description about your business to help users",size: 14),
              const SizedBox(height: 20,),
              SizedBox(
                height: 200,
                child: CustomDescriptionField(
                  placeholder: "Write description",
                  controller: businessDescription,
                  maxLines: 5,
                  onChange: (value){
                    setState(() {
                      authenticationController.businessDescription = value;
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
                    backgroundColor: authenticationController.businessDescription.isNotEmpty ? primaryColor : Colors.grey[400]!,
                    shadowStrength: 0,
                    height: 50,
                    radius: 30,
                    onPressed: ()async{
                      try{
                        if(authenticationController.businessDescription.isNotEmpty){
                          showLoaderDialog(context);
                          var response = await authenticationController.update(context, {
                            "business_description":authenticationController.businessDescription,
                          });
                          if(response){
                            context.pop();
                            toastSuccessMessage("Updated successfully", context);
                            context.push(Routing.verifyIdentityPage);
                          }
                          else{
                            context.pop();
                          }
                        }
                        else{
                          context.pop();
                          toastMessage("All fields are required", context);
                        }
                      }catch(e){
                        context.pop();
                        toastMessage(e.toString(), context);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
