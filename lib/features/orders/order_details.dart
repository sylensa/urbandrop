import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:urbandrop/controllers/orders/orders_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/models/orders_model.dart';

class OrderDetailsPage extends StatefulWidget {
  OrderData? orderData;
   OrderDetailsPage({super.key, required this.orderData});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  int orderStatus = 1;
  late OrdersController ordersController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ordersController = context.read<OrdersController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
    });
  }
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
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: widget.orderData!.items!.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context,index){
                         return  Row(
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(left: 20),
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(10),
                                 child: Image.network("${widget.orderData!.items![index].product_image}",width: 168,),
                               ),
                             ),
                           ],
                         );
                    }),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: appWidth(context)/2,
                          child: sText("Order: #${widget.orderData?.id}",size: 20,weight: FontWeight.w900,color: primaryColor,maxLines: 1),
                        ),
                        sText("£${formattedAmount(amount: widget.orderData?.total.toString())}p",size: 20,weight: FontWeight.w900),
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
                        sText("${widget.orderData?.items?.length}",size: 12,weight: FontWeight.w600),
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
                        sText(formatDateTime(widget.orderData!.createdAt!.isNotEmpty ? DateTime.parse("${widget.orderData?.createdAt}") : DateTime.now()),size: 12,weight: FontWeight.w400)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0XFF879EA4),width: 0.2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        for(int index = 0; index < widget.orderData!.items!.length; index++)
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network("${widget.orderData!.items![index].product_image}",width: 36,),
                                  ),
                                  const SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      sText("${widget.orderData!.items![index].product_name}",size: 12,weight: FontWeight.w600),
                                      const SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          sText("Qty:",size: 12,weight: FontWeight.w400),
                                          sText(" ${widget.orderData!.items![index].quantity}",size: 12,weight: FontWeight.w600),
                                        ],
                                      ),

                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  sText("£${formattedAmount(amount: widget.orderData!.items![index].price.toString())}p",size: 14,weight: FontWeight.w900)
                                ],
                              ),
                            ),
                             Container(
                               color:  Color(0XFF879EA4),
                               height: 0.2,
                               width: appWidth(context),
                             )
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            widget.orderData?.status == OrderStatus.pending ?
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: mainButton(
                        width: appWidth(context),
                        height: 40,
                        radius: 30,
                        outlineColor: Colors.transparent,
                        shadowStrength: 0,
                        backgroundColor: primaryColor,
                        content:  sText("Accept",color: Colors.white,weight: FontWeight.w600,size: 18),
                        onPressed:(){
                          widget.orderData?.status = OrderStatus.accepted;
                          setState(() {});
                          ordersController.changeOrderPendingState(widget.orderData!);
                        }),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: mainButton(
                        width: appWidth(context),
                        height: 40,
                        radius: 30,
                        outlineColor: appMainRedColor,
                        shadowStrength: 0,
                        backgroundColor: Colors.white,
                        content:  sText("Decline",color: appMainRedColor,weight: FontWeight.w600,size: 18),
                        onPressed:(){
                          widget.orderData?.status = OrderStatus.declined;
                          ordersController.changeOrderPendingState(widget.orderData!);
                          setState(() {});
                        }),
                  ),
                ],
              ),
            ) :
             widget.orderData?.status == OrderStatus.accepted ?
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
                      height: 40,
                      radius: 30,
                      outlineColor: Colors.transparent,
                      shadowStrength: 0,
                      backgroundColor: primaryColor,
                      content:  sText("Out for delivery",color: Colors.white,weight: FontWeight.w600,size: 18),
                      onPressed:(){
                        orderStatus = 3;
                        widget.orderData?.status = OrderStatus.delivering;
                        setState(() {});
                        ordersController.changeOrderPendingState(widget.orderData!);
                      }),


                ],
              ),
            ) :
             widget.orderData?.status == OrderStatus.delivering ?
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
                      height: 40,
                      radius: 30,
                      outlineColor: Colors.transparent,
                      shadowStrength: 0,
                      backgroundColor: primaryColor,
                      content:  sText("Order Delivered",color: Colors.white,weight: FontWeight.w600,size: 18),
                      onPressed:(){
                        widget.orderData?.status = OrderStatus.completed;
                        setState(() {});
                        ordersController.changeOrderPendingState(widget.orderData!);
                      }),


                ],
              ),
            ) :
             widget.orderData?.status == OrderStatus.completed ?
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
                        setState(() {});
                      }),
                  SizedBox(height: 10,),



                ],
              ),
            ) :
             widget.orderData?.status == OrderStatus.declined ?
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
                          sText("Order declined",color: Colors.white,weight: FontWeight.w600,size: 12),
                        ],
                      ),
                      onPressed:(){
                        setState(() {});
                      }),
                  SizedBox(height: 10,),



                ],
              ),
            ) :
             widget.orderData?.status == OrderStatus.cancelled ?
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
                           sText("Order cancelled",color: Colors.white,weight: FontWeight.w600,size: 12),
                         ],
                       ),
                       onPressed:(){
                         setState(() {});
                       }),
                   SizedBox(height: 10,),



                 ],
               ),
             ) :
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
