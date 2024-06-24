import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/controllers/dashboard/dashboard_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/social_login_widgets.dart';
import 'package:urbandrop/models/config_model.dart';
import 'package:urbandrop/routes.dart';

class UpdateBusinessInformationPage extends StatefulWidget {
  const UpdateBusinessInformationPage({super.key});

  @override
  State<UpdateBusinessInformationPage> createState() => _UpdateBusinessInformationPageState();
}

class _UpdateBusinessInformationPageState extends State<UpdateBusinessInformationPage> {
  AuthenticationController authenticationController = AuthenticationController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController businessName = TextEditingController();
  TextEditingController businessAddress = TextEditingController();
  TextEditingController businessCity = TextEditingController();
  TextEditingController businessPostcode = TextEditingController();
  TextEditingController businessDescription = TextEditingController();
  List<String> _list = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final stateDashboard = Get.put(DashboardController());
    Future.delayed(const Duration(seconds: 1),()async{
      if(stateDashboard.configModel.value == null){
        await AuthenticationController().getUserConfig();
        setState(() {

        });
      }
      businessName.text = userInstance?.businessName ?? "";
      authenticationController.businessName = userInstance?.businessName ?? "";
      businessAddress.text = userInstance?.address ?? "";
      authenticationController.businessAddress = userInstance?.address ?? "";
      businessCity.text = userInstance?.city ?? "";
      authenticationController.businessCity = userInstance?.city ?? "";
      businessPostcode.text = userInstance?.postCode ?? "";
      authenticationController.businessPostCode = userInstance?.postCode ?? "";
      businessDescription.text = userInstance?.businessDescription ?? "";
      authenticationController.businessDescription = userInstance?.businessDescription ?? "";
      stateDashboard.configModel.value!.merchantCategories!.forEach((element) {
        _list.add(element.categoryName!);
        if(element.id == userInstance?.merchantCategory || element.categoryName == userInstance?.merchantCategory ){
          authenticationController.businessType = element.categoryName;
          authenticationController.businessTypeId = element.id;
        }
      });
    });


  }
  @override
  Widget build(BuildContext context) {
    final stateDashboard = Get.put(DashboardController());

    return  Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        title: sText("Shop information",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  CustomTextField(
                    controller: businessName,
                    placeholder: "Business name",
                    onChange: (value){
                      setState(() {
                        authenticationController.businessName = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(30),
                      border: Border.all(color: const Color(0XFF1F546033)),

                    ),
                    child: ClipRRect(
                      borderRadius:  BorderRadius.circular(30),
                      child: CustomDropdown<String>.search(
                        hintText: 'Business type',
                        initialItem:   authenticationController.businessType,
                        headerBuilder: (context, selectedItem,v) {
                          return sText(
                            selectedItem.toString(),
                            color:   Colors.black,
                            size: 16,
                            weight:  FontWeight.w500,

                          );
                        },
                        hintBuilder: (context, selectedItem,v) {
                          return sText(
                            selectedItem.toString(),
                            color:  const Color(0xFF879EA4),
                            size: 16,
                            weight:  FontWeight.w400,

                          );
                        },

                        closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                        canCloseOutsideBounds: true,
                        decoration: CustomDropdownDecoration(
                          closedFillColor: Colors.white,
                          closedBorderRadius: BorderRadius.circular(30),
                          // closedBorder: Border.all(color: const Color(0XFF1F546033)),
                          closedShadow:[
                            const BoxShadow(
                                blurRadius: 1,
                                color: Colors.white,
                                offset: Offset(0, 0.0),
                                spreadRadius: 1),
                            const BoxShadow(
                                blurRadius: 1,
                                color: Colors.white,
                                offset: Offset(0, 0.0),
                                spreadRadius: 1)
                          ],
                        ),

                        items: _list,
                        onChanged: (value) {
                          setState(() {
                            authenticationController.businessType = value;
                          });
                          log('changing value to: $value');
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 200,
                    child: CustomDescriptionField(
                      placeholder: "Write description",
                      maxLines: 5,
                      maxLength: 150,
                      controller: businessDescription,
                      onChange: (value){
                        setState(() {
                          authenticationController.businessDescription = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  sText("${businessDescription.text.length}/150",color: const Color(0XFF879EA4),size: 12),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    controller: businessAddress,
                    placeholder: "Address",
                    onChange: (value){
                      setState(() {
                        authenticationController.businessAddress = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomTextField(
                          placeholder: "City/Town",
                          controller: businessCity,
                          onChange: (value){
                            setState(() {
                              authenticationController.businessCity = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        flex: 2,
                        child: CustomTextField(
                          placeholder: "Postcode",
                          controller: businessPostcode,
                          onChange: (value){
                            setState(() {
                              authenticationController.businessPostCode = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  mainButton(
                      content: sText("Save",color: Colors.white,size: 18,weight: FontWeight.w600),
                      backgroundColor: authenticationController.validateBusinessInformation() && authenticationController.businessDescription.isNotEmpty  ? primaryColor : Colors.grey[400]!,
                      shadowStrength: 0,
                      height: 50,
                      radius: 30,
                      onPressed: ()async{
                        try{
                          if(authenticationController.validateBusinessInformation() && authenticationController.businessDescription.isNotEmpty){
                            stateDashboard.configModel.value!.merchantCategories!.forEach((element) {
                              if(element.id == userInstance?.merchantCategory || element.categoryName == userInstance?.merchantCategory ){
                                authenticationController.businessType = element.categoryName;
                                authenticationController.businessTypeId = element.id;
                              }
                            });
                            showLoaderDialog(context);
                            var response = await  authenticationController.update(context,  {
                              "address":authenticationController.businessAddress,
                              "city":authenticationController.businessCity,
                              "post_code":authenticationController.businessPostCode,
                              "business_name":authenticationController.businessName,
                              "merchant_category":authenticationController.businessTypeId,
                              "business_description":authenticationController.businessDescription,
                            });
                            if(response){
                              context.pop();
                              context.pop();
                              toastSuccessMessage("Updated successfully", context);
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
