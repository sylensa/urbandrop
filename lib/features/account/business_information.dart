import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Routing;
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/controllers/dashboard/dashboard_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/social_login_widgets.dart';
import 'package:urbandrop/models/config_model.dart';
import 'package:urbandrop/routes.dart';

class BusinessInformationPage extends StatefulWidget {
  const BusinessInformationPage({super.key});

  @override
  State<BusinessInformationPage> createState() => _BusinessInformationPageState();
}

class _BusinessInformationPageState extends State<BusinessInformationPage> {
  AuthenticationController authenticationController = AuthenticationController();
  TextEditingController businessName = TextEditingController();
  TextEditingController businessAddress = TextEditingController();
  TextEditingController businessCity = TextEditingController();
  TextEditingController businessPostcode = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    businessName.text = userInstance?.businessName ?? "";
    authenticationController.businessName = userInstance?.businessName ?? "";
    businessAddress.text = userInstance?.address ?? "";
    authenticationController.businessAddress = userInstance?.address ?? "";
    businessCity.text = userInstance?.city ?? "";
    authenticationController.businessCity = userInstance?.city ?? "";
    businessPostcode.text = userInstance?.postCode ?? "";
    authenticationController.businessPostCode = userInstance?.postCode ?? "";

  }
  @override
  Widget build(BuildContext context) {
    final stateDashboard = Get.put(DashboardController());

    return  Scaffold(
      key: scaffoldKey,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                padding: const EdgeInsets.only(top: 0),
                width: appWidth(context),
                color: primaryColor,
              ),
              Positioned(
                top: 70,
                child: Image.asset("assets/images/white_image.png",color: Colors.white,width: appWidth(context),height: 270,fit: BoxFit.fitHeight,),
              ),
              Positioned(
                top: 10,
                child: Image.asset("assets/images/background_1.png",width: appWidth(context),height: 300,fit: BoxFit.fitHeight,),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                sText("Business information",size: 20,weight: FontWeight.w700),
                const SizedBox(height: 10,),
                sText("Nearly there! Tell us the name of your business. This name will be displayed on your profile.",size: 14),
                const SizedBox(height: 20,),
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
                ClipRRect(
                  borderRadius:  BorderRadius.circular(30),
                  child: CustomDropdown<TCategory>(
                    hintText: 'Business type',
                      initialItem:   authenticationController.businessType,
                      headerBuilder: (context, selectedItem) {
                        return sText(
                          selectedItem.categoryName.toString(),
                          color:   Colors.black,
                          size: 16,
                          weight:  FontWeight.w500,

                        );
                      },
                    hintBuilder: (context, selectedItem) {
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
                      closedBorder: Border.all(color: const Color(0XFF1F546033)),
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

                    items: stateDashboard.configModel.value!.merchantCategories,
                    onChanged: (value) {
                      setState(() {
                        authenticationController.businessType = value;
                      });
                      log('changing value to: $value');
                    },
                  ),
                ),

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
                        controller: businessCity,
                        placeholder: "City/Town",
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
                        controller:  businessPostcode,
                        placeholder: "Postcode",
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
                    content: sText("Continue",color: Colors.white,size: 18,weight: FontWeight.w600),
                    backgroundColor: authenticationController.validateBusinessInformation() ? primaryColor : Colors.grey[400]!,
                    shadowStrength: 0,
                    height: 50,
                    radius: 30,
                    onPressed: ()async{
                     try{
                       if(authenticationController.validateBusinessInformation()){
                         showLoaderDialog(context);
                         var response = await authenticationController.update(context, {
                           "address":authenticationController.businessAddress,
                           "city":authenticationController.businessCity,
                           "post_code":authenticationController.businessPostCode,
                           "business_name":authenticationController.businessName,
                           // "merchant_category":authenticationController.businessType,
                           "merchant_category":"123456789",
                         });
                         if(response){
                           context.pop();
                           toastSuccessMessage("Updated successfully", context);
                           context.push(Routing.businessDescriptionPage);
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
    );
  }
}
