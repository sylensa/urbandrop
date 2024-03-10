import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  int orderStatus = 1;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Order Details",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset("assets/images/product_1.png",width: 168,),
                  ),
                  const SizedBox(width: 10,),
                  Image.asset("assets/images/product_2.png",width: 168,),
                  const SizedBox(width: 10,),
                  Image.asset("assets/images/product_1.png",width: 168,),
                  const SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset("assets/images/product_2.png",width: 168,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  sText("Order: #01234567",size: 20,weight: FontWeight.w900,color: primaryColor),
                  sText("£54.97p",size: 20,weight: FontWeight.w900),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  sText("No. of items:",size: 12,weight: FontWeight.w400,),
                  const SizedBox(width: 10,),
                  sText("5",size: 12,weight: FontWeight.w600),
                ],
              ),
            ),

            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  sText("Date:",size: 12,weight: FontWeight.w400,),
                  const SizedBox(width: 10,),
                  sText(" 3rd Jan. 2024; 4:35pm",size: 12,weight: FontWeight.w400),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0XFF879EA4),width: 0.2),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                    itemBuilder: (context,index){

                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Row(
                          children: [
                            Image.asset("assets/images/product_2.png",width: 36,),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                sText("Banku & Okro soup",size: 12,weight: FontWeight.w600),
                                const SizedBox(height: 5,),
                                Row(
                                  children: [
                                    sText("Qty:",size: 12,weight: FontWeight.w400),
                                    sText(" 5",size: 12,weight: FontWeight.w600),
                                  ],
                                ),

                              ],
                            ),
                            Expanded(child: Container()),
                            sText("£10",size: 14,weight: FontWeight.w900)
                          ],
                        ),
                      ),
                     const Divider(color:  Color(0XFF879EA4),thickness: 0.2,)
                    ],
                  );
                }),
              ),
            ),
            orderStatus == 1 ?
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: mainButton(
                        width: appWidth(context),
                        height: 50,
                        radius: 30,
                        outlineColor: Colors.transparent,
                        shadowStrength: 0,
                        backgroundColor: primaryColor,
                        content:  sText("Accept",color: Colors.white,weight: FontWeight.w600,size: 18),
                        onPressed:(){
                          orderStatus = 2;
                          setState(() {});
                        }),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: mainButton(
                        width: appWidth(context),
                        height: 50,
                        radius: 30,
                        outlineColor: appMainRedColor,
                        shadowStrength: 0,
                        backgroundColor: Colors.white,
                        content:  sText("Decline",color: appMainRedColor,weight: FontWeight.w600,size: 18),
                        onPressed:(){
                          orderStatus = 5;
                          setState(() {});
                        }),
                  ),
                ],
              ),
            ) :
            orderStatus == 2 ?
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mainButton(
                      width: 150,
                      height: 30,
                      radius: 5,
                      outlineColor: Colors.transparent,
                      shadowStrength: 0,
                      backgroundColor: primaryColor.withOpacity(0.3),
                      content:  Row(
                        children: [
                          Image.asset("assets/images/notify.png",width: 6,),
                          const SizedBox(width: 10,),
                          sText("Order accepted",color: Colors.white,weight: FontWeight.w600,size: 12),
                        ],
                      ),
                      onPressed:(){
                      }),
                  const SizedBox(height: 20,),
                  mainButton(
                      width: appWidth(context),
                      height: 50,
                      radius: 30,
                      outlineColor: Colors.transparent,
                      shadowStrength: 0,
                      backgroundColor: primaryColor,
                      content:  sText("Out for delivery",color: Colors.white,weight: FontWeight.w600,size: 18),
                      onPressed:(){
                        orderStatus = 3;
                        setState(() {});
                      }),


                ],
              ),
            ) :
            orderStatus == 3 ?
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mainButton(
                      width: 150,
                      height: 30,
                      radius: 5,
                      outlineColor: Colors.transparent,
                      shadowStrength: 0,
                      backgroundColor: Color(0XFF68CCEB).withOpacity(0.3),
                      content:  Row(
                        children: [
                          Image.asset("assets/images/notify.png",width: 6,color: Color(0XFF68CCEB),),
                          const SizedBox(width: 10,),
                          sText("Out for delivery",color: Colors.white,weight: FontWeight.w600,size: 12),
                        ],
                      ),
                      onPressed:(){
                      }),
                  const SizedBox(height: 20,),
                  mainButton(
                      width: appWidth(context),
                      height: 50,
                      radius: 30,
                      outlineColor: Colors.transparent,
                      shadowStrength: 0,
                      backgroundColor: primaryColor,
                      content:  sText("Order Delivered",color: Colors.white,weight: FontWeight.w600,size: 18),
                      onPressed:(){
                        orderStatus = 4;
                        setState(() {});
                      }),


                ],
              ),
            ) :
            orderStatus == 4 ?
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  mainButton(
                      width: 150,
                      height: 30,
                      radius: 5,
                      outlineColor: Colors.transparent,
                      shadowStrength: 0,
                      backgroundColor: Color(0XFF183A37).withOpacity(0.3),
                      content:  Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/notify.png",width: 6,color: Color(0XFF183A37),),
                          const SizedBox(width: 10,),
                          sText("Order delivered",color: Colors.white,weight: FontWeight.w600,size: 12),
                        ],
                      ),
                      onPressed:(){
                        orderStatus = 1;
                        setState(() {});
                      }),
                  SizedBox(height: 10,),



                ],
              ),
            ) :
            orderStatus == 5 ?
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mainButton(
                      width: 150,
                      height: 30,
                      radius: 5,
                      outlineColor: Colors.transparent,
                      shadowStrength: 0,
                      backgroundColor: appMainRedColor.withOpacity(0.3),
                      content:  Row(
                        children: [
                          Image.asset("assets/images/notify.png",width: 6,color: appMainRedColor,),
                          const SizedBox(width: 10,),
                          sText("Order canceled",color: Colors.white,weight: FontWeight.w600,size: 12),
                        ],
                      ),
                      onPressed:(){
                        orderStatus = 1;
                        setState(() {});
                      }),
                  SizedBox(height: 10,),



                ],
              ),
            ) :
                const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
