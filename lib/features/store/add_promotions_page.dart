import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbandrop/controllers/products/product_controllers.dart';
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
  List<String> _productList = [];
  List<String> _promotionList = [];
  String? productName;
  String? promotionType;
  String? promotionId;
  String? productId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final stateProduct = Get.put(ProductsController());

    stateProduct.listProducts.value.forEach((element) {
      _productList.add(element.productName!);
      if(element.id == widget.promotionsData?.id ){
        promotionType = element.productName;
        promotionId = element.id;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Promotions",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: appWidth(context),
              height: 150,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: const Color(0XFF879EA4).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/upload_product.png",width: 40,height: 40,),
                  sText("Tap to add a new image",size: 9,weight: FontWeight.w400)

                ],
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
                        items: _productList,
                        onChanged: (value) {
                          setState(() {
                            promotionType = value;
                          });
                          log('changing value to: $value');
                        },
                      ),
                    ),
                  ),
                  CustomTextField(
                    placeholder: "Promotion Name",
                    onChange: (value){

                    },
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    placeholder: "Promotion Offer",
                    onChange: (value){

                    },
                  ),

                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0XFF1F546033)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        sText("Promotion Products (e.g. all fresh products)",color: const Color(0xFF879EA4)),
                        const Icon(Icons.keyboard_arrow_down,color: Color(0XFF879EA4),)
                      ],
                    ),
                  ),
                  const SizedBox(height: 40,),
                  mainButton(
                      width: appWidth(context),
                      height: 50,
                      radius: 30,
                      outlineColor: Colors.transparent,
                      shadowStrength: 0,
                      backgroundColor: primaryColor,
                      content:  sText("Create Promotions",color: Colors.white,weight: FontWeight.w600,size: 18),
                      onPressed:(){
                      }),
                  const SizedBox(height: 40,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
