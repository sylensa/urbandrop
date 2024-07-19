import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:urbandrop/controllers/dashboard/dashboard_controller.dart';
import 'package:urbandrop/controllers/dashboard/order_summary_controller.dart';
import 'package:urbandrop/controllers/dashboard/recent_delivery_controller.dart';
import 'package:urbandrop/controllers/dashboard/recent_order_controller.dart';
import 'package:urbandrop/controllers/dashboard/top_product_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/home/dashboard_daily_summary.dart';
import 'package:urbandrop/features/home/dashboard_recent_delivery.dart';
import 'package:urbandrop/features/home/dashboard_recent_order.dart';
import 'package:urbandrop/features/home/dashboard_top_product.dart';
import 'package:urbandrop/features/widget/daily_summary_widget.dart';
import 'package:urbandrop/features/widget/flutter_switch.dart';
import 'package:urbandrop/features/widget/product_widget.dart';
import 'package:urbandrop/features/widget/recent_delivery.dart';
import 'package:urbandrop/features/widget/recent_order_widget.dart';
import 'package:urbandrop/features/widget/smart_refresh.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late OrderSummaryController orderSummaryController;
  late RecentDeliveryController recentDeliveryController;
  late RecentOrderController recentOrderController;
  late TopProductController topProductController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topProductController = context.read<TopProductController>();
    orderSummaryController = context.read<OrderSummaryController>();
    recentDeliveryController = context.read<RecentDeliveryController>();
    recentOrderController = context.read<RecentOrderController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      topProductController.topProducts.clear();
      orderSummaryController.orderSummary == null;
      recentDeliveryController.recentOrderDelivery == null;
      recentOrderController.recentOrderData == null;
      topProductController.getTopProducts();
      orderSummaryController.getOrderSummary();
      recentDeliveryController.getRecentDelivery();
      recentOrderController.getRecentOrder();
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final state = Get.put(DashboardController());
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
                    SizedBox(width:appWidth(context) * 0.6,child: sText(properCase("${userInstance?.businessName}"),size: 20,weight: FontWeight.w600,color: Colors.white,maxLines: 1)),

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
                      inactiveColor: Colors.white,
                      activeColor: primaryRedColor,
                      toggleColor:userInstance!.available == true ? Colors.white : primaryColor ,

                      onToggle: (val) async{
                        setState(() {
                          userInstance?.available = val;
                        });
                        await state.offOnlineStatus(context,available: userInstance?.available);
                      },
                      value: userInstance!.available == true ? true : false,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: SmartRefresh(
            onLoading:(){},
            onRefresh: state.onRefresh,
            child:  ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                DashboardDailySummary(),
                DashboardRecentDelivery(),
                DashboardRecentOrder(),
                DashboardTopProduct()
              ],
            ),
          )

          ,
        )
      ],
    );
  }
}
