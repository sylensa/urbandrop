import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:urbandrop/controllers/orders/orders_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/models/orders_model.dart';

class RecentOrder extends StatefulWidget {
 final  OrderData? recentOrder;
  const RecentOrder({super.key, required this.recentOrder});

  @override
  State<RecentOrder> createState() => _RecentOrderState();
}

class _RecentOrderState extends State<RecentOrder> {
  @override
  Widget build(BuildContext context) {
    final state = Get.put(OrdersController());
    return  Container(

      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color:  Colors.black,width: 0.2,),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(borderRadius:BorderRadius.circular(10),child: Image.network("${widget.recentOrder?.items?.first.product_image}",width: 114,height: 127,fit: BoxFit.cover,)),
          const SizedBox(width: 10,),
          SizedBox(
            height: 127,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: appWidth(context) * 0.5,child: sText("Order: #${widget.recentOrder?.id}",size: 12,weight: FontWeight.w900,maxLines: 1)),
                Row(
                  children: [
                    sText("No. of items: ",size: 12,weight: FontWeight.w400),
                    sText("${widget.recentOrder?.items?.length}",size: 12,weight: FontWeight.w600),
                  ],
                ),
                Row(
                  children: [
                    sText("Price: ",size: 12,weight: FontWeight.w400),
                    sText("£${formattedAmount(amount: widget.recentOrder?.total.toString())}p",size: 12,weight: FontWeight.w600),
                  ],
                ),
                sText(formatDateTime(widget.recentOrder!.createdAt!.isNotEmpty ? DateTime.parse("${widget.recentOrder?.createdAt}") : DateTime.now()),size: 12,weight: FontWeight.w400),
                Container(
                  height: 0.5,
                  width: 180,
                  color: const Color(0XFF183A37),
                ),
                widget. recentOrder?.status == OrderStatus.pending ?
                Row(
                  children: [
                    mainButton(
                        width: 90,
                        height: 30,
                        radius: 30,
                        outlineColor: Colors.transparent,
                        shadowStrength: 0,
                        backgroundColor: primaryColor,
                        content:  sText("Accept",color: Colors.white,weight: FontWeight.w600,size: 12),
                        onPressed:(){
                          widget.recentOrder?.status = OrderStatus.accepted;
                          setState(() {});
                          state.changeOrderPendingState(widget.recentOrder!);
                        }),
                    const SizedBox(width: 10,),
                    mainButton(
                        width: 90,
                        height: 30,
                        radius: 30,
                        outlineColor: appMainRedColor,
                        shadowStrength: 0,
                        backgroundColor: Colors.white,
                        content:  sText("Decline",color: appMainRedColor,weight: FontWeight.w600,size: 12),
                        onPressed:(){
                          widget. recentOrder?.status = OrderStatus.declined;
                          setState(() {});
                          state.changeOrderPendingState(widget.recentOrder!);
                        }),
                  ],
                ) :
                widget. recentOrder?.status == OrderStatus.accepted ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("assets/images/notify.png",width: 6,color: const Color(0XFFF5955F),),
                        const SizedBox(width: 5,),
                        sText("Order accepted",color: Colors.black,weight: FontWeight.w600,size: 10),
                      ],
                    ),
                    const SizedBox(width: 10,),

                    GestureDetector(
                      onTap: (){
                        widget.recentOrder?.status = OrderStatus.delivering;
                        setState(() {});
                        state.changeOrderPendingState(widget.recentOrder!);
                      },
                      child: sText("Out for delivery",color: primaryColor,weight: FontWeight.w600,size: 10),
                    )

                  ],
                ) :
                widget.recentOrder?.status == OrderStatus.delivering ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/notify.png",width: 6,color: const Color(0XFF68CCEB),),
                        const SizedBox(width: 5,),
                        sText("Out for delivery",color: Colors.black,weight: FontWeight.w600,size: 10),
                      ],
                    ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        widget. recentOrder?.status = OrderStatus.completed;
                        setState(() {});
                        state.changeOrderPendingState(widget.recentOrder!);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.check,color: primaryColor,size: 12,),
                          sText("Mark as delivered",color: primaryColor,weight: FontWeight.w600,size: 10),
                        ],
                      ),
                    )
                  ],
                ) :
                widget. recentOrder?.status == OrderStatus.completed ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/notify.png",width: 6,color: primaryColor,),
                        const SizedBox(width: 5,),
                        sText("Order delivered",color: Colors.black,weight: FontWeight.w600,size: 10),
                      ],
                    )

                  ],
                ) :
                widget. recentOrder?.status == OrderStatus.declined ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/notify.png",width: 6,color: appMainRedColor,),
                        const SizedBox(width: 5,),
                        sText("Order declined",color: Colors.black,weight: FontWeight.w600,size: 10),
                      ],
                    ),
                  ],
                ) :
                widget. recentOrder?.status == OrderStatus.cancelled ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/notify.png",width: 6,color: appMainRedColor,),
                        const SizedBox(width: 5,),
                        sText("Order cancelled",color: primaryColor,weight: FontWeight.w600,size: 10),
                      ],
                    ),
                  ],
                ) :
                const SizedBox.shrink(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
