import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:recase/recase.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/controllers/config/config_controller.dart';
import 'package:urbandrop/controllers/dashboard/dashboard_controller.dart';
import 'package:urbandrop/controllers/products/product_controllers.dart';
import 'package:urbandrop/controllers/promotions/promotions_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/models/promotions_model.dart';

class AddPromotionsPage extends StatefulWidget {
  final PromotionsData? promotionsData;
  const AddPromotionsPage({super.key, this.promotionsData});

  @override
  State<AddPromotionsPage> createState() => _AddPromotionsPageState();
}

class _AddPromotionsPageState extends State<AddPromotionsPage> {
  final List<String> productList = [];
  final List<String> promotionCategories = [];
  final List<String> promotionTypes = [
    'Percentage Off',
    'Amount Off'
  ];
  List<String> productName = [];
  List<String> productId = [];
  List<String> productCategories = [];
  String? promotionCategory;
  String? productCategory;
  String? promotionDescription;
  bool? onChange;
  String? promotionCategoryId;
  String? productCategoryId;
  String? promotionType;
  String? promotionTypeId;
  DateTime? startDate;
  DateTime? endDate;
  File? mediaPath;
  TextEditingController promotionNameController = TextEditingController();
  TextEditingController promotionOfferController = TextEditingController();
  TextEditingController minimumController = TextEditingController();
  late ConfigController configController;
  late ProductsController productsController;

  validateField(){
    if(promotionNameController.text.isNotEmpty && endDate != null && startDate != null && promotionOfferController.text.isNotEmpty && promotionCategory != null && promotionType != null && productName != null && (mediaPath != null || widget.promotionsData != null) ){
      return true;
    }
    return false;
  }

  filterProductByCategory({bool filterCategory = false}){
    print("filterCategory:$filterCategory");

    final stateProduct = Get.put(ProductsController());
    final stateDashboard = Get.put(DashboardController());
    if(filterCategory){
      configController.configModel!.productCategories!.forEach((element) {
        if(element.categoryName == productCategory ){
          print("element.id:${element.id}");
          productCategoryId = element.id;
        }
      });
    }
    productList.clear();
    if(productCategoryId != null){
      productsController.listProducts = productsController.unFilteredListProducts.where((element) => element.categoryId == productCategoryId).toList();
    productsController.listProducts.forEach((element) {
        productList.add(element.productName!);
      });
      print("productList:${productList}");
    }else{
      productsController.unFilteredListProducts.forEach((element) {
        productList.add(element.productName!);
      });
    }

    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configController = context.read<ConfigController>();
    productsController = context.read<ProductsController>();

    log("widget.promotionsData!.imageUrl:${widget.promotionsData?.toJson()}");
    Future.delayed(const Duration(seconds: 1),()async{
      productsController.listProducts.clear();
      productsController.listProducts.addAll(productsController.unFilteredListProducts);
      if(configController.configModel == null){
        await configController.getUserConfig();
        setState(() {

        });
      }
      if( productsController.listProducts.isEmpty){
        await productsController.getProducts(limit: 100000000000000);
        setState(() {

        });
      }

      if(widget.promotionsData != null){
        promotionType = "${properCase(widget.promotionsData!.promoType!)} Off";
        promotionNameController.text = widget.promotionsData!.promoName!;
        minimumController.text= widget.promotionsData!.minimum_sale!;
        promotionOfferController.text = widget.promotionsData!.promoValue!.toString();
        startDate = widget.promotionsData!.promoStart;
        endDate = widget.promotionsData!.promoExpiry;
      }

      configController.configModel!.promotionCategories!.forEach((element) {
        promotionCategories.add(element.name!);
        print("promo element.name:${element.name}");
        if(element.id == widget.promotionsData?.promoCategory ){
          promotionCategory = element.name;
          promotionCategoryId = element.id;
          print("promo element.id:${promotionCategoryId}");
        }
      });

      configController.configModel!.productCategories!.forEach((element) {
        productCategories.add(element.categoryName!);
        log("productCategories:$productCategories");
        if(widget.promotionsData != null){
          if(widget.promotionsData!.promo_product_categories!.isNotEmpty){
            if(element.id == widget.promotionsData?.promo_product_categories!.first ){
              productCategory = element.categoryName;
              productCategoryId = element.id;
            }
          }
        }

      });

      productsController.unFilteredListProducts.forEach((element) {
        if(widget.promotionsData != null){
          for(int i =0;  i < widget.promotionsData!.promoProducts!.length; i++){
            if(element.id == widget.promotionsData!.promoProducts![i] ){
              productName.add(element.productName!) ;
              productId.add(element.id!);
              print("productName:${productName}");
            }
          }
          filterProductByCategory(filterCategory: false);
        }else{
          productList.add(element.productName!);
        }
      });
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final state = Get.put(PromotionsController());
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Promotions",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
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
                  height: mediaPath != null ||  widget.promotionsData != null ? 250 : 150,
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
                      widget.promotionsData != null && widget.promotionsData?.imageUrl != null ?
                      Image.network(widget.promotionsData!.imageUrl!,width: appWidth(context),height: 210) :
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
              Expanded(
                child: ListView(
                  children: [
                    ClipRRect(
                      borderRadius:  BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0XFF1F546033))
                        ),
                        child: CustomDropdown<String>.search(
                          hintText: 'Promotion Category',
                          initialItem: promotionCategory,

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
                          items: promotionCategories,
                          onChanged: (value) {
                            setState(() {
                              promotionCategory = value;
                              print("promotionCategory:$promotionCategory");
                            });
                            // log('changing value to: $value');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    if(promotionCategory?.contains("Minimum") == true)
                    Column(
                      children: [
                        CustomTextField(
                          controller: minimumController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          placeholder: "Enter $promotionCategory".sentenceCase,
                          onChange: (value){

                          },
                        ),
                        const SizedBox(height: 20,),
                      ],
                    ),

                    ClipRRect(
                      borderRadius:  BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0XFF1F546033))
                        ),
                        child: CustomDropdown<String>.search(
                          hintText: 'Promotion types',
                          initialItem: promotionType,

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
                          items: promotionTypes,
                          onChanged: (value) {
                            setState(() {
                              promotionType = value;
                            });
                            log('changing value to: $value');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    CustomTextField(
                      controller: promotionNameController,
                      placeholder: "Promotion Name",
                      onChange: (value){

                      },
                    ),
                    const SizedBox(height: 20,),
                    CustomTextField(
                      controller: promotionOfferController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      placeholder: "Promotion Offer",
                      onChange: (value){

                      },
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
                          hintText: 'Product category',
                          initialItem: productCategory,

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
                          items: productCategories,
                          onChanged: (value) {
                            setState(() {
                              productCategory = value;
                                filterProductByCategory(filterCategory: true);
                            });
                            log('changing value to: $value');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    ClipRRect(
                      borderRadius:  BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0XFF1F546033))
                        ),
                        child: CustomDropdown<String>.multiSelectSearch(
                          hintText: 'Promotion Products',
                          initialItems: productName,
                          headerListBuilder: (context, selectedItem,v) {
                            return sText(
                              selectedItem.toString(),
                              color:   Colors.black,
                              size: 16,
                              weight:  FontWeight.w500,

                            );
                          },
                          listItemBuilder: (context, selectedItem,v,f) {
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
                          items: productList,
                          onListChanged: (value) {
                            setState(() {
                              productName = value;
                            });
                            log('changing value to: $value');
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height:20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: sText("Start date",size: 12,weight: FontWeight.w600,color:  const Color(0xFF879EA4)),
                        ),
                        const SizedBox(height: 20,),
                        TimePickerSpinnerPopUp(
                          mode: CupertinoDatePickerMode.dateAndTime,
                          minTime: DateTime.now() ,
                          initTime: DateTime.now(),

                          barrierColor: Colors.black12, //Barrier Color when pop up show
                          minuteInterval: 1,
                          padding : const EdgeInsets.fromLTRB(12, 10, 12, 10),
                          cancelText : 'Cancel',
                          confirmText : 'OK',
                          pressType: PressType.singlePress,
                          timeFormat: 'd MMM. yyyy; h:mm a',
                          // Customize your time widget
                          timeWidgetBuilder: (dateTime) {
                            return Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: const Color(0XFF1F546033)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  sText(startDate != null ? formatDateTime(startDate!) : "Pick start date" ,color: const Color(0xFF879EA4)),
                                  const Icon(Icons.keyboard_arrow_down,color: Color(0XFF879EA4),)
                                ],
                              ),
                            );
                          },
                          onChange: (dateTime) {
                            print("dateTime:$dateTime");
                            setState(() {
                              startDate = dateTime;
                            });
                            // Implement your logic with select dateTime
                          },
                        ),
                      ],
                    ),

                    if(startDate != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height:20,),
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: sText("End date",size: 12,weight: FontWeight.w600,color:  const Color(0xFF879EA4)),
                        ),
                        const SizedBox(height: 20,),
                        TimePickerSpinnerPopUp(
                          mode: CupertinoDatePickerMode.dateAndTime,
                          initTime: startDate!.add(const Duration(hours: 1)),
                          minTime: startDate!.add(const Duration(hours: 1)) ,
                          barrierColor: Colors.black12, //Barrier Color when pop up show
                          minuteInterval: 1,
                          padding : const EdgeInsets.fromLTRB(12, 10, 12, 10),
                          cancelText : 'Cancel',
                          confirmText : 'OK',
                          pressType: PressType.singlePress,
                          timeFormat: 'd MMM. yyyy; h:mm a',
                          // Customize your time widget
                          timeWidgetBuilder: (dateTime) {
                            return Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: const Color(0XFF1F546033)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  sText(endDate != null ? formatDateTime(endDate!) : "Pick end date",color: const Color(0xFF879EA4)),
                                  const Icon(Icons.keyboard_arrow_down,color: Color(0XFF879EA4),)
                                ],
                              ),
                            );
                          },
                          onChange: (dateTime) {
                            print("dateTime:$dateTime");
                            setState(() {
                              endDate = dateTime;
                            });
                            // Implement your logic with select dateTime
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40,),
                    mainButton(
                        width: appWidth(context),
                        height: 50,
                        radius: 30,
                        outlineColor: Colors.transparent,
                        shadowStrength: 0,
                        backgroundColor: validateField() ? primaryColor : Colors.grey,
                        content:  sText(widget.promotionsData == null ? "Create Promotions" : "Update Promotions",color: Colors.white,weight: FontWeight.w600,size: 18),
                        onPressed:()async{
                          final stateProduct = Get.put(ProductsController());
                          final stateDashboard = Get.put(DashboardController());
                          if( validateField() ){
                            if(promotionCategory?.contains("Minimum") == true){
                              if(minimumController.text.isEmpty){
                                toastMessage("Enter $promotionCategory".sentenceCase, context);
                                return;
                              }
                            }
                            configController.configModel!.promotionCategories!.forEach((element) {
                              if(element.name == promotionCategory ){
                                promotionCategory= element.name;
                                promotionCategoryId = element.id;
                                promotionDescription = element.description;
                              }
                            });
                            configController.configModel!.productCategories!.forEach((element) {
                              if(element.name == productCategory ){
                                productCategory= element.name;
                                productCategoryId = element.id;
                              }
                            });
                            productId.clear();
                            productsController.listProducts.forEach((element) {
                              for(int i =0;  i < productName.length; i++){
                                if(element.productName == productName[i] ){
                                  productId.add(element.id!);
                                }
                              }
                            });

                            await state.uploadPromotion(context, {
                              "promo_category":"$promotionCategoryId",
                              "promo_name":promotionNameController.text,
                              "promo_description":"$promotionDescription",
                              "promo_product_categories":jsonEncode([productCategoryId]),
                              "promo_value":promotionOfferController.text,
                              "promo_type":promotionType!.split(" ").first.toLowerCase(),
                              "promo_products":jsonEncode(productId),
                              "promo_start":"$startDate",
                              "promo_expiry":"$endDate",
                              "minimum_sale":minimumController.text,
                            }, mediaPath, widget.promotionsData);
                          }else{
                            toastSuccessMessage("All fields are required", context);
                          }

                        }),
                     SizedBox(height: appHeight(context),),
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
