import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Routing;
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/orders/orders_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/recent_order_widget.dart';
import 'package:urbandrop/features/widget/smart_refresh.dart';
import 'package:urbandrop/features/widget/tab_bar_slider.dart';
import 'package:urbandrop/models/orders_model.dart';
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
    const Tab(
      text: "Declined",
    ),
    const Tab(
      text: "Cancelled",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final state = Get.put(OrdersController());

    return Container(
      padding: const EdgeInsets.only(top: 70,left: 0,right: 0,bottom: 20),
      child: Obx(() => TabBarSlider(
        myTabs:myTabs,
        child:  [
          OrdersWidgetPage(orders: state.listOrders.value,orderStatus: "All",),
          OrdersWidgetPage(orders: state.listPendingOrders.value,orderStatus: OrderStatus.pending,),
          OrdersWidgetPage(orders: state.listConfirmOrders.value,orderStatus: OrderStatus.accepted,),
          OrdersWidgetPage(orders: state.listInProgressOrders.value,orderStatus: OrderStatus.delivering,),
          OrdersWidgetPage(orders: state.listCompletedOrders.value,orderStatus: OrderStatus.completed,),
          OrdersWidgetPage(orders: state.listDeclineOrders.value,orderStatus: OrderStatus.declined,),
          OrdersWidgetPage(orders: state.listCancelledOrders.value,orderStatus: OrderStatus.cancelled,),


        ],
      )),
    );
  }
}


class OrdersWidgetPage extends StatefulWidget {
 final List<OrderData> orders;
 final String orderStatus;
  const OrdersWidgetPage({super.key,required this.orders, required this.orderStatus});

  @override
  State<OrdersWidgetPage> createState() => _OrdersWidgetPageState();
}

class _OrdersWidgetPageState extends State<OrdersWidgetPage> {
  final state = Get.put(OrdersController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomTextSearchField(
            placeholder: "Search",
            onChange: (value){
              setState(() {
                state.onSearchChanged(value,widget.orderStatus);
              });
            },
            orderStatus: widget.orderStatus,
          ),
        ),
        const SizedBox(height: 20,),
        Obx(() =>  state.loading.value ?
        Expanded(child: Center(child: progressCircular(),)) :
        widget.orders.isNotEmpty ?
        Expanded(
          child: SmartRefresh(
            onLoading: state.onLoading,
            onRefresh: state.onRefresh,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                itemCount:  widget.orders.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: (){
                      context.go(Routing.orderDetailsPage,extra:  widget.orders[index]);
                    },
                    child: Column(
                      children: [
                        RecentOrder(recentOrder:  widget.orders[index],),
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
