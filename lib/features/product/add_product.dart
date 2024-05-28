import 'dart:developer';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/controllers/dashboard/dashboard_controller.dart';
import 'package:urbandrop/controllers/products/product_controllers.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/models/product_model.dart';

class AddProduct extends StatefulWidget {
  final ProductData? productData;
  const AddProduct({super.key, this.productData});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final List<String> _list = [
    'Developer',
    'Designer',
    'Consultant',
    'Student',
  ];
  final List<String> weightList = [
    'KG',
    'ml',
    'litre',
    'gm',
  ];
  File? mediaPath;
  AuthenticationController authenticationController = AuthenticationController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String? category;
  String? weight;
  validateField(){
    if(productNameController.text.isNotEmpty && productDescriptionController.text.isNotEmpty && category != null && amountController.text.isNotEmpty && quantityController.text.isNotEmpty && (mediaPath != null || widget.productData != null) && weight != null){
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.productData != null){
      productNameController.text ="${widget.productData?.productName}";
      productDescriptionController.text ="${widget.productData?.productDescription}";
      amountController.text ="${widget.productData?.price}";
      quantityController.text ="${widget.productData?.stock}";
      weight = widget.productData?.unit ;
    }


  }
  @override
  Widget build(BuildContext context) {
    final state = Get.put(ProductsController());
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText(widget.productData == null ?"Add Product" : "Edit Product",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: ()async{
                  mediaPath = await authenticationController.attachFils();
                  setState(() {

                  });
                },
                child: Container(
                  width: appWidth(context),
                  height: 250,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0XFF879EA4).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      mediaPath != null ?
                      displayLocalImageDevice(mediaPath!.path,radius: 0,height:210,width: appWidth(context)) :
                      widget.productData != null ? 
                      displayImage(widget.productData!.imageUrl,radius: 0,width: 40,height: 40) :
                     Column(
                       children: [
                         Image.asset("assets/images/upload_product.png",width: 40,height: 40,),
                         sText("Tap to add a new image",size: 9,weight: FontWeight.w400)
                       ],
                     )

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.grey[300],
                            height: 1,
                          ),
                        ),
                        sText(" OR ",color: Colors.grey[400]!,size: 12),
                        Expanded(
                          child: Container(
                            color: Colors.grey[300],
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    sText("Tap here to select image",color: primaryColor,size: 12,weight: FontWeight.w600),
                    const SizedBox(height: 20,),
                    CustomTextField(
                      controller: productNameController,
                      placeholder: "Product Name",
                      onChange: (value){
                        setState(() {

                        });

                      },
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: sText("0 / 80 characters",color: const Color(0XFF879EA4),size: 12),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 200,
                      child: CustomDescriptionField(
                        placeholder: "Write description",
                        maxLines: 5,
                        controller: productDescriptionController,
                        onChange: (value){
                          setState(() {

                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: sText("0/150",color: const Color(0XFF879EA4),size: 12),
                    ),
                    const SizedBox(height: 20,),
                    ClipRRect(
                      borderRadius:  BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: const Color(0XFF1F546033))
                        ),
                        child: CustomDropdown<String>(
                          hintText: 'Select category',
                          headerBuilder: (context, selectedItem) {
                            return sText(
                              selectedItem.toString(),
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
                                  spreadRadius: 9),
                              const BoxShadow(
                                  blurRadius: 1,
                                  color: Colors.white,
                                  offset: Offset(0, 0.0),
                                  spreadRadius: 9)
                            ],
                          ),

                          items: _list,
                          onChanged: (value) {
                            setState(() {
                              category = value;
                            });
                            log('changing value to: $value');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    CustomTextAmountField(
                      placeholder: "00.00 p",
                      controller: amountController,
                      onChange: (value){
                        setState(() {

                        });
                      },
                    ),
                    const SizedBox(height: 20,),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: quantityController,
                      placeholder: "Quantity (optional)",
                      onChange: (value){
                        setState(() {

                        });
                      },
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 50,
                      child: ListView.builder(
                        itemCount: weightList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index){
                          return Row(
                            children: [
                              mainButton(
                                  width: 70,
                                  height: 30,
                                  radius: 30,
                                  outlineColor:weightList[index].toLowerCase() == weight?.toLowerCase() ? Colors.transparent : primaryColor,
                                  shadowStrength: 0,
                                  backgroundColor:weightList[index].toLowerCase() == weight?.toLowerCase() ?  primaryColor : Colors.white,
                                  content:  sText(weightList[index],color: weightList[index].toLowerCase() == weight?.toLowerCase() ? Colors.white : primaryColor,weight: FontWeight.w600,size: 12),
                                  onPressed:(){
                                    setState(() {
                                      weight = weightList[index];
                                    });
                                  }),
                              const SizedBox(width: 20,),

                            ],
                          );

                      }),
                    ),
                    const SizedBox(height: 40,),
                    mainButton(
                        width: appWidth(context),
                        height: 50,
                        radius: 30,
                        outlineColor: Colors.transparent,
                        shadowStrength: 0,
                        backgroundColor:validateField() ? primaryColor : Colors.grey[400]!,
                        content:  sText(widget.productData == null ? "Ad product" : "Save",color: Colors.white,weight: FontWeight.w600,size: 18),
                        onPressed:(){
                          if(validateField()){
                            Map<String, String> body = {
                              "product_name":productNameController.text,
                              "product_description": productDescriptionController.text,
                              // "category_id":"$category",
                              "category_id":"123456789",
                              "price":amountController.text,
                              "stock":quantityController.text,
                              "unit":"$weight",
                            };
                            var response = state.uploadProduct(context, body, mediaPath,widget.productData);

                          }else{
                            toastSuccessMessage("All fields are required", context);
                          }

                        }),
                    const SizedBox(height: 20,),
                    if(widget.productData != null)
                    mainButton(
                        width: appWidth(context),
                        height: 50,
                        radius: 30,
                        outlineColor: Colors.transparent,
                        shadowStrength: 0,
                        backgroundColor:primaryRedColor,
                        content:  sText( "Delete",color: Colors.white,weight: FontWeight.w600,size: 18),
                        onPressed:(){
                          final response = state.deleteProduct(widget.productData!.id!,context);
                          if(response){
                            context.pop();
                          }
                        }),
                    const SizedBox(height: 40,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
