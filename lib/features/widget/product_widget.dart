import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/features/widget/flutter_switch.dart';
import 'package:urbandrop/models/product_model.dart';

class ProductWidget extends StatefulWidget {
  final ProductData? productData;
  const ProductWidget({super.key, required this.productData});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(color:  Colors.black,width: 0.2,),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15) ),
                  child: Image.asset("assets/images/food_1.png",width: 186,height: 110,fit: BoxFit.cover,)),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height:5 ,),
                    sText("Green Plantain",size: 12,weight: FontWeight.w400),
                    const SizedBox(height:5 ,),
                    sText("£7.50p / kg",size: 12,weight: FontWeight.w900),
                    const SizedBox(height:10,),
                    Row(
                      children: [
                        sText("Out of stock",size: 12,weight: FontWeight.w400),
                        const SizedBox(width:10,),
                        OnAndOffSwitch(
                          padding: 2,
                          height: 15,
                          width: 30,
                          toggleSize: 15,
                          toggleColor: Colors.white,
                          activeColor: const Color(0XFFF74242),
                          onToggle: (val) {
                          },
                          value: true,
                        ),
                      ],
                    ),

                  ],
                ),
              )
            ],
          ),
          Positioned(
            right: 5,
            top: 5,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0XFFF74242)
              ),
              child: Image.asset("assets/images/pencil.png",width: 13,),
            ),
          )
        ],
      ),
    );
  }
}
