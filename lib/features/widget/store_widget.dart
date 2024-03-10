import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';

class StoreWidget extends StatelessWidget {
  final Function() onTap;
  final String image;
  final String content;
  final Widget icon;
  const StoreWidget({super.key, required this.onTap, this.image = "info.png", this.content = "Shop information", this.icon = const Icon(Icons.arrow_forward_ios,color: primaryColor,)});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),

            decoration: BoxDecoration(
                color: const Color(0XFF5CB35E).withOpacity(0.3),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Image.asset("assets/images/$image",width: 20,height: 20,),
          ),
          const SizedBox(width: 20,),
          Expanded(child: sText(content,size: 15,weight: FontWeight.w500)),
           icon
        ],
      ),
    );
  }
}
