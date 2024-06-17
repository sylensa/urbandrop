import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/routes.dart';

class PromotionsPage extends StatefulWidget {
  const PromotionsPage({super.key});

  @override
  State<PromotionsPage> createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                mainButton(
                    width: 120,
                    height: 30,
                    radius: 30,
                    outlineColor: Colors.transparent,
                    shadowStrength: 0,
                    backgroundColor: primaryColor,
                    content: Row(
                      children: [
                        sText("Add item",color: Colors.white,weight: FontWeight.w600,size: 12),
                        const SizedBox(width: 5,),
                        Image.asset("assets/images/add.png",width: 15,)
                      ],
                    )
                    , onPressed:(){
                  context.push(Routing.addPromotionsPage);
                }),
              ],
            ),
            const SizedBox(height: 40,),
            Expanded(
              child: ListView(
                children:  [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          decoration: BoxDecoration(
                              color: const Color(0XFF5CB35E),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(
                                          color: const Color(0XFF183A37).withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: sText("Christmas Week discounts",size: 10,weight: FontWeight.w600,color: Colors.white)
                                  ),
                                  const SizedBox(height: 10,),
                                  sText("20% OFF",size: 30,color: const Color(0XFF183A37),weight: FontWeight.w900),
                                  const SizedBox(height: 10,),
                                  sText("All dairy products",color: Colors.white,size: 12,weight: FontWeight.w600)
                                ],
                              ),
                              Image.asset("assets/images/ellipse.png",width: 84,)

                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          right:40,
                          child: Image.asset("assets/images/delete_promo.png",width: 27,)
                      ),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          decoration: BoxDecoration(
                              color: const Color(0XFF5CB35E),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(
                                          color: const Color(0XFF183A37).withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: sText("Christmas Week discounts",size: 10,weight: FontWeight.w600,color: Colors.white)
                                  ),
                                  const SizedBox(height: 10,),
                                  sText("20% OFF",size: 30,color: const Color(0XFF183A37),weight: FontWeight.w900),
                                  const SizedBox(height: 10,),
                                  sText("All dairy products",color: Colors.white,size: 12,weight: FontWeight.w600)
                                ],
                              ),
                              Image.asset("assets/images/ellipse.png",width: 84,)

                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          right:40,
                          child: Image.asset("assets/images/delete_promo.png",width: 27,)
                      ),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          decoration: BoxDecoration(
                              color: const Color(0XFF5CB35E),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(
                                          color: const Color(0XFF183A37).withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: sText("Christmas Week discounts",size: 10,weight: FontWeight.w600,color: Colors.white)
                                  ),
                                  const SizedBox(height: 10,),
                                  sText("20% OFF",size: 30,color: const Color(0XFF183A37),weight: FontWeight.w900),
                                  const SizedBox(height: 10,),
                                  sText("All dairy products",color: Colors.white,size: 12,weight: FontWeight.w600)
                                ],
                              ),
                              Image.asset("assets/images/ellipse.png",width: 84,)

                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          right:40,
                          child: Image.asset("assets/images/delete_promo.png",width: 27,)
                      ),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          decoration: BoxDecoration(
                              color: const Color(0XFF5CB35E),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(
                                          color: const Color(0XFF183A37).withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: sText("Christmas Week discounts",size: 10,weight: FontWeight.w600,color: Colors.white)
                                  ),
                                  const SizedBox(height: 10,),
                                  sText("20% OFF",size: 30,color: const Color(0XFF183A37),weight: FontWeight.w900),
                                  const SizedBox(height: 10,),
                                  sText("All dairy products",color: Colors.white,size: 12,weight: FontWeight.w600)
                                ],
                              ),
                              Image.asset("assets/images/ellipse.png",width: 84,)

                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          right:40,
                          child: Image.asset("assets/images/delete_promo.png",width: 27,)
                      ),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          decoration: BoxDecoration(
                              color: const Color(0XFF5CB35E),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(
                                          color: const Color(0XFF183A37).withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: sText("Christmas Week discounts",size: 10,weight: FontWeight.w600,color: Colors.white)
                                  ),
                                  const SizedBox(height: 10,),
                                  sText("20% OFF",size: 30,color: const Color(0XFF183A37),weight: FontWeight.w900),
                                  const SizedBox(height: 10,),
                                  sText("All dairy products",color: Colors.white,size: 12,weight: FontWeight.w600)
                                ],
                              ),
                              Image.asset("assets/images/ellipse.png",width: 84,)

                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          right:40,
                          child: Image.asset("assets/images/delete_promo.png",width: 27,)
                      ),

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
