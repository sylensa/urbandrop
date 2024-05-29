import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/models/orders_model.dart';
import 'package:urbandrop/routes.dart';

class RecentDDeliveryWidget extends StatefulWidget {
 final OrderData? recentDelivery;
  const RecentDDeliveryWidget({super.key, required this.recentDelivery});

  @override
  State<RecentDDeliveryWidget> createState() => _RecentDDeliveryWidgetState();
}

class _RecentDDeliveryWidgetState extends State<RecentDDeliveryWidget> {
  @override
  Widget build(BuildContext context) {

    return  Container(
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

                  sText("Order:${widget.recentDelivery != null ? widget.recentDelivery?.id : "N/A" }",size: 16,weight: FontWeight.w900),
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
                      , onPressed:(){
                        if(widget.recentDelivery != null){
                          context.go(Routing.orderDetailsPage,extra: widget.recentDelivery);
                        }
                  }),
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
    );
  }
}
