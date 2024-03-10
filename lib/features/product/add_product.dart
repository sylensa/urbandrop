import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Add Product",size: 15,weight: FontWeight.w600),
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
                    placeholder: "Product Name",
                    onChange: (value){

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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0XFF1F546033)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        sText("Select category",color: Color(0xFF879EA4)),
                        const Icon(Icons.keyboard_arrow_down,color: Color(0XFF879EA4),)
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    placeholder: "Quantity (optional)",
                    onChange: (value){

                    },
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    child: Row(
                      children: [
                        mainButton(
                            width: 70,
                            height: 30,
                            radius: 30,
                            outlineColor: Colors.transparent,
                            shadowStrength: 0,
                            backgroundColor: primaryColor,
                            content:  sText("KG",color: Colors.white,weight: FontWeight.w600,size: 12),
                            onPressed:(){
                        }),
                        SizedBox(width: 20,),
                        mainButton(
                            width: 70,
                            height: 30,
                            radius: 30,
                            outlineColor: Colors.transparent,
                            shadowStrength: 0,
                            backgroundColor: primaryColor,
                            content:  sText("ml",color: Colors.white,weight: FontWeight.w600,size: 12),
                            onPressed:(){
                            }),
                        SizedBox(width: 20,),
                        mainButton(
                            width: 70,
                            height: 30,
                            radius: 30,
                            outlineColor: Colors.transparent,
                            shadowStrength: 0,
                            backgroundColor: primaryColor,
                            content:  sText("litre",color: Colors.white,weight: FontWeight.w600,size: 12),
                            onPressed:(){
                            }),
                        SizedBox(width: 20,),
                        mainButton(
                            width: 70,
                            height: 30,
                            radius: 30,
                            outlineColor: Colors.transparent,
                            shadowStrength: 0,
                            backgroundColor: primaryColor,
                            content:  sText("gm",color: Colors.white,weight: FontWeight.w600,size: 12),
                            onPressed:(){
                            }),
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
                      content:  sText("Ad product",color: Colors.white,weight: FontWeight.w600,size: 18),
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
