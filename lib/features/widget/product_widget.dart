import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Routing;
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/products/product_controllers.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/features/widget/flutter_switch.dart';
import 'package:urbandrop/models/product_model.dart';
import 'package:urbandrop/routes.dart';

class ProductWidget extends StatefulWidget {
  final ProductData? productData;
  final bool? fromMenu;
  const ProductWidget({super.key, required this.productData, this.fromMenu = false});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final state = Get.put(ProductsController());
    print("${widget.productData?.imageUrl}");
    return GestureDetector(
      onTap: (){
        context.push(Routing.addProduct,extra: widget.productData);
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          border: Border.all(color:  Colors.black,width: 0.2,),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15) ),
                    child: Image.network("${widget.productData?.imageUrl}",width: 186,height: 110, fit: BoxFit.cover,)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height:5 ,),
                      sText(properCase("${widget.productData?.productName}"),size: 12,weight: FontWeight.w400,maxLines: 1),
                      const SizedBox(height:5 ,),
                      sText("£${formattedAmount(amount: "${widget.productData?.price}")}p / ${widget.productData?.unit}",size: 12,weight: FontWeight.w900),
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
                            activeColor:  const Color(0XFFF74242),
                            inactiveColor: Colors.grey,
                            onToggle: (val)async {
                              setState(() {
                                widget.productData!.available = !widget.productData!.available!;
                              });
                                await state.outOfStock(widget.productData!.id!);
                            },
                            value: widget.productData!.available!,
                          ),
                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),
            if(widget.fromMenu == true)
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
      ),
    );
  }
}
