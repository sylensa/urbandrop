import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';

class DailySummary extends StatelessWidget {
  final String amount;
  final String title;
  final String image;
  final Color textColor;
  final Color backgroundColor;
   DailySummary({super.key, this.amount = "105", this.title= "orders", this.image = "active_orders.png", this.backgroundColor = const Color(0xFF5CB35E), this.textColor = const Color(0XFF183A37)});

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 107,
      width: 107,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color:   Colors.white.withOpacity(0.3),
                shape: BoxShape.circle
            ),
            child: Image.asset("assets/images/$image",width: 25,),
          ),
          const SizedBox(height: 5,),
          sText(amount,size: 13,weight: FontWeight.w900,color: textColor),
          sText(title,size: 12,weight: FontWeight.w400,color: textColor),
        ],
      ),
    );
  }
}
