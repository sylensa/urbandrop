import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/controllers/config/config_controller.dart';
import 'package:urbandrop/controllers/dashboard/dashboard_controller.dart';
import 'package:urbandrop/controllers/products/product_controllers.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/models/config_model.dart';
import 'package:urbandrop/models/product_model.dart';

class AddProduct extends StatefulWidget {
  final ProductData? productData;
  const AddProduct({super.key, this.productData});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final List<String> weightList = [
    'kg',
    'ml',
    'litre',
    'gm',
    'box',
    'unit',
  ];
  File? mediaPath;
  AuthenticationController authenticationController = AuthenticationController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  String? category;
  String? categoryId;
  String? weight;
  late ConfigController configController;

  List<String> _list = [];
  validateField(){
    if(productNameController.text.isNotEmpty && productDescriptionController.text.isNotEmpty && category != null && amountController.text.isNotEmpty  && (mediaPath != null || widget.productData != null) && weight != null){
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configController = context.read<ConfigController>();

    final stateDashboard = Get.put(DashboardController());
    if(widget.productData != null){
      productNameController.text ="${widget.productData?.productName}";
      productDescriptionController.text ="${widget.productData?.productDescription}";
      amountController.text ="${widget.productData?.price}";
      quantityController.text ="${widget.productData?.quantity ?? ''}";
      stockController.text ="${widget.productData?.stock ?? ''}";
      weight = widget.productData?.unit ;

    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      await configController.getUserConfig();
      configController.configModel!.productCategories!.forEach((element) {
        _list.add(element.categoryName!);
        if(element.id == widget.productData?.categoryId ){
          category = element.categoryName;
          categoryId = element.id;
        }
      });
      setState(() {

      });
    });


  }
  @override
  Widget build(BuildContext context) {
    final state = Get.put(ProductsController());
    final stateDashboard = Get.put(DashboardController());

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
              Expanded(
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: ()async{
                        mediaPath = await authenticationController.attachFils();
                        setState(() {

                        });
                      },
                      child: Container(
                        width: appWidth(context),
                        height: mediaPath != null ||  widget.productData != null ? 250 : 150,
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
                            Image.network(widget.productData!.imageUrl!,width: appWidth(context),height: 210) :
                            Column(
                              children: [
                                Image.asset("assets/images/upload_product.png",width: 40,height: 40,),
                                sText("Product Image",size: 9,weight: FontWeight.w400)
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
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
                    GestureDetector(
                      onTap:()async{
                        mediaPath = await authenticationController.attachFils();
                        setState(() {

                        });
                      },
                      child: sText("Tap here to select image",color: primaryColor,size: 12,weight: FontWeight.w600,align: TextAlign.center),
                    ),
                    const SizedBox(height: 20,),
                    CustomTextField(
                      controller: productNameController,
                      placeholder: "Product Name",
                      maxLength: 80,
                      onChange: (value){
                        setState(() {

                        });

                      },
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: sText("${productNameController.text.length} / 80 characters",color: const Color(0XFF879EA4),size: 12),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 200,
                      child: CustomDescriptionField(
                        placeholder: "Write description",
                        maxLength: 150,
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
                      child: sText("${productDescriptionController.text.length}/150",color: const Color(0XFF879EA4),size: 12),
                    ),
                    const SizedBox(height: 20,),
                    ClipRRect(
                      borderRadius:  BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: const Color(0XFF1F546033))
                        ),
                        child: CustomDropdown<String>.search(
                          hintText: 'Select category',
                          initialItem: category,

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
                              selectedItem,
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

                    CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: quantityController,
                      placeholder: "Quantity",
                      onChange: (value){
                        setState(() {

                        });
                      },
                    ),

                    const SizedBox(height: 20,),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: stockController,
                      placeholder: "Stock",
                      onChange: (value){
                        setState(() {

                        });
                      },
                    ),


                    const SizedBox(height: 20,),
                    SizedBox(
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
                    const SizedBox(height: 20,),
                    CustomTextAmountField(
                      placeholder: "00.00 p",
                      controller: amountController,

                      onChange: (value){
                        setState(() {

                        });
                      },
                      suffix:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: sText("${quantityController.text}/$weight",color: Color(0xFF879EA4)),
                      ),
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
                            configController.configModel!.productCategories!.forEach((element) {
                              if(element.categoryName == category ){
                                category = element.categoryName;
                                categoryId = element.id;
                              }
                            });
                            Map<String, String> body = {
                              "product_name":productNameController.text,
                              "product_description": productDescriptionController.text,
                              "category_id":"$categoryId",
                              "price":amountController.text,
                              "stock":stockController.text,
                              "quantity":quantityController.text,
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
