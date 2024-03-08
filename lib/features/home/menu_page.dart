import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/product_widget.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 70,left: 20,right: 20),
      child: Column(
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
                  , onPressed:(){}),
            ],
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal:00,vertical: 20),
              itemCount: 10,
              gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
                  mainAxisSpacing: 20,
                  crossAxisSpacing:10

              ),
                itemBuilder:(context, index){
                  return const Row(
                    children: [
                      Expanded(child: ProductWidget())
                    ],
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
