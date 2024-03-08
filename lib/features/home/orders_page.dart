import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urbandrop/features/widget/recent_order_widget.dart';
import 'package:urbandrop/features/widget/tab_bar_slider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 70,left: 0,right: 0,bottom: 20),
      child: TabBarSlider(
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
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 10,
              itemBuilder: (context, index){
            return const Column(
              children: [
                RecentOrder(),
                SizedBox(height: 20,)
              ],
            );
          }),
        )
      ],
    );
  }
}
