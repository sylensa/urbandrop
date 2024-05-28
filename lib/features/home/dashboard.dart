import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbandrop/controllers/dashboard/dashboard_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                      onToggle: (val) {
                      },
                      value: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Obx(() =>  state.loading.value ?
        Expanded(child: Center(child: progressCircular(),)) :
        !state.loading.value ?
        Expanded(
          child: SmartRefresh(
            onLoading:(){},
            onRefresh: state.onRefresh,
            child:  ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 10,),
                Row(
                  children: [
                    sText("Daily Summary",weight: FontWeight.w500,size: 15,color: Colors.black)
                  ],
                ),
                const SizedBox(height: 20,),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: DailySummary(backgroundColor: const Color(0xFF5CB35E).withOpacity(0.3),amount: "${state.orderSummary.value?.count}",)),
                    const SizedBox(width: 10,),
                    Expanded(child: DailySummary(backgroundColor: const Color(0xFF5CB35E),textColor: Colors.white,title: "received",amount: "£ ${state.orderSummary.value?.revenue}",image: "received.png",)),
                    const SizedBox(width: 10,),
                    Expanded(child: DailySummary(backgroundColor: const Color(0xFF183A37),textColor: Colors.white,title: "deliveries",amount: "${state.orderSummary.value?.deliveries}",image: "deliveries.png",))
                  ],
                )),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    sText("Recent delivery",weight: FontWeight.w500,size: 15,color: Colors.black)
                  ],
                ),
                const SizedBox(height: 20,),
                Obx(() => RecentDDeliveryWidget(recentDelivery: state.recentOrderDelivery.value,)),
                const SizedBox(height: 20,),

                Obx(() => Column(
                  children: [
                    if(state.recentOrderData.value != null)
                      Column(
                        children: [
                          Row(
                            children: [
                              sText("Recent order",weight: FontWeight.w500,size: 15,color: Colors.black)
                            ],
                          ),
                          const SizedBox(height: 20,),
                          RecentOrder(recentOrder: state.recentOrderData.value ,),
                          const SizedBox(height: 20,),
                        ],
                      )
                  ],
                )),
                Row(
                  children: [
                    sText("Popular products",weight: FontWeight.w500,size: 15,color: Colors.black)
                  ],
                ),
                const SizedBox(height: 20,),
                Obx(() =>   SizedBox(
                  height: 200,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                      itemCount: state.topProducts.value.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return Row(
                          children: [
                            ProductWidget(productData: state.topProducts.value[index],),
                            const SizedBox(width: 10,),
                          ],
                        );

                      }),
                )),

                const SizedBox(height: 20,),
              ],
            ),
          )

          ,
        ) :
        Expanded(child: Center(child: sText( state.errorMessage.value.isEmpty ? "Check your internet and try again" :  state.errorMessage.value),))),

      ],
    );
  }
}
