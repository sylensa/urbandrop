import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';

class RecentOrder extends StatefulWidget {
  const RecentOrder({super.key});

  @override
  State<RecentOrder> createState() => _RecentOrderState();
}

class _RecentOrderState extends State<RecentOrder> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color:  Colors.black,width: 0.2,),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset("assets/images/food.png",width: 114,height: 127,),
          const SizedBox(width: 10,),
          SizedBox(
            height: 127,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sText("Order: #01234567",size: 12,weight: FontWeight.w900),
                // const SizedBox(height:5 ,),
                Row(
                  children: [
                    sText("No. of items: ",size: 12,weight: FontWeight.w400),
                    sText("5",size: 12,weight: FontWeight.w600),
                  ],
                ),
                // const SizedBox(height:5 ,),
                Row(
                  children: [
                    sText("Price: ",size: 12,weight: FontWeight.w400),
                    sText("£14.50p",size: 12,weight: FontWeight.w600),
                  ],
                ),
                // const SizedBox(height:5 ,),
                sText("3rd Jan. 2024; 4:35pm",size: 12,weight: FontWeight.w400),
                // const SizedBox(height:10 ,),
                Row(
                  children: [
                    mainButton(
                        width: 95,
                        height: 30,
                        radius: 30,
                        outlineColor: Colors.transparent,
                        shadowStrength: 0,
                        backgroundColor: primaryColor,
                        content: sText("Accept",color: Colors.white,weight: FontWeight.w600,size: 12)
                        , onPressed:(){}),
                    const SizedBox(width: 10,),
                    outlineButton(
                        width: 95,
                        height: 30,
                        radius: 30,
                        outlineColor: const Color(0XFFF74242),
                        shadowStrength: 0,
                        backgroundColor: Colors.white,
                        content: sText("Decline",color:  const Color(0XFFF74242),weight: FontWeight.w600,size: 12)
                        , onPressed:(){}),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
