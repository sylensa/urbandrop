import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Routing;
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/orders/orders_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/recent_order_widget.dart';
import 'package:urbandrop/features/widget/smart_refresh.dart';
import 'package:urbandrop/features/widget/tab_bar_slider.dart';
import 'package:urbandrop/routes.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Tab> myTabs = <Tab> [
    const Tab(
      text: "All",
    ),
    const Tab(
      text: "Pending",
    ),
    const Tab(
      text: "Confirm",
    ),
    const Tab(
      text: "In Progress",
    ),
    const Tab(
      text: "Completed",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 70,left: 0,right: 0,bottom: 20),
      child: TabBarSlider(
        myTabs:myTabs,
        child: const [
          OrdersWidgetPage(),
          OrdersWidgetPage(),
          OrdersWidgetPage(),
          OrdersWidgetPage(),
          OrdersWidgetPage(),


        ],
      ),
    );
  }
}


class OrdersWidgetPage extends StatefulWidget {
  const OrdersWidgetPage({super.key});

  @override
  State<OrdersWidgetPage> createState() => _OrdersWidgetPageState();
}

class _OrdersWidgetPageState extends State<OrdersWidgetPage> {
  @override
  Widget build(BuildContext context) {
    final state = Get.put(OrdersController());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomTextSearchField(
            placeholder: "Search",
            onChange: (value){
              setState(() {
              });
            },
          ),
        ),
        const SizedBox(height: 20,),
        Obx(() =>  state.loading.value ?
        Expanded(child: Center(child: progressCircular(),)) :
        state.listOrders.value.isNotEmpty ?
        Expanded(
          child: SmartRefresh(
            onLoading: state.onLoading,
            onRefresh: state.onRefresh,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                itemCount: state.listOrders.value.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: (){
                      context.go(Routing.orderDetailsPage,extra: state.listOrders.value[index]);
                    },
                    child: Column(
                      children: [
                        RecentOrder(recentOrder: state.listOrders.value[index],),
                        const SizedBox(height: 10,)
                      ],
                    ),
                  );

                }),
          )

          ,
        ) :
        Expanded(child: Center(child: sText( state.errorMessage.value.isEmpty ? "No orders" :  state.errorMessage.value),))),

      ],
    );
  }
}
