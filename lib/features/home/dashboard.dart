import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/daily_summary_widget.dart';
import 'package:urbandrop/features/widget/flutter_switch.dart';
import 'package:urbandrop/features/widget/product_widget.dart';
import 'package:urbandrop/features/widget/recent_order_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 80),
          width: appWidth(context),
          color: primaryColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sText("Welcome,",size: 15,weight: FontWeight.w400,color: Colors.white),
                    sText("Super Mart",size: 25,weight: FontWeight.w600,color: Colors.white),

                  ],
                ),
                Row(
                  children: [
                    sText("Open",size: 15,weight: FontWeight.w500,color: Colors.white),
                    const SizedBox(width: 10,),
                    OnAndOffSwitch(
                      padding: 3,
                      height: 25,
                      width: 55,
                      onToggle: (val) {
                      },
                      value: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 10,),
              Row(
                children: [
                  sText("Daily Summary",weight: FontWeight.w500,size: 15,color: Colors.black)
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: DailySummary(backgroundColor: const Color(0xFF5CB35E).withOpacity(0.3),)),
                  const SizedBox(width: 10,),
                  Expanded(child: DailySummary(backgroundColor: const Color(0xFF5CB35E),textColor: Colors.white,title: "received",amount: "£ 10,000.60p",image: "received.png",)),
                  const SizedBox(width: 10,),
                  Expanded(child: DailySummary(backgroundColor: const Color(0xFF183A37),textColor: Colors.white,title: "deliveries",amount: "100",image: "deliveries.png",))
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  sText("Recent delivery",weight: FontWeight.w500,size: 15,color: Colors.black)
                ],
              ),
              const SizedBox(height: 20,),
              Container(
                width: appWidth(context),
                padding: const EdgeInsets.only(left: 20,right: 20,top: 0),
                decoration: BoxDecoration(
                    color: const Color(0XFFFFB400),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20,),

                            sText("Order: #02387",size: 16,weight: FontWeight.w900),
                            const SizedBox(height: 5,),
                            sText("Out for delivery",size: 11,color: const Color(0XFF183A37)),
                            const SizedBox(height: 10,),
                            mainButton(
                                width: 120,
                                height: 40,
                                radius: 30,
                                outlineColor: Colors.transparent,
                                shadowStrength: 0,
                                backgroundColor: primaryColor,
                                content: sText("View details",color: Colors.white,weight: FontWeight.w600,size: 12)
                                , onPressed:(){}),
                            const SizedBox(height: 20,),
                          ],
                        ),


                      ],
                    ),
                    Positioned(
                      right: 10,
                      child:   Image.asset("assets/images/delivery_service.png",height: 140,width: 157,),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  sText("Recent order",weight: FontWeight.w500,size: 15,color: Colors.black)
                ],
              ),
              const SizedBox(height: 20,),
              const RecentOrder(),
              const SizedBox(height: 20,),
              Row(
                children: [
                  sText("Popular products",weight: FontWeight.w500,size: 15,color: Colors.black)
                ],
              ),
              const SizedBox(height: 20,),
              const Row(
                children: [
                  Expanded(
                    child: ProductWidget(),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child:ProductWidget(),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ],
    );
  }
}
