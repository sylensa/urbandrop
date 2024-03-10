import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/product_widget.dart';
import 'package:urbandrop/features/widget/tab_bar_slider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Tab> myTabs = <Tab> [
    const Tab(
      text: "All",
    ),
    const Tab(
      text: "Orders",
    ),
    const Tab(
      text: "Shop",
    ),
    const Tab(
      text: "Deliveries",
    ),
    const Tab(
      text: "Payment",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 70,left: 0,right: 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                mainButton(
                    width: 120,
                    height: 30,
                    radius: 30,
                    outlineColor: appMainRedColor,
                    shadowStrength: 0,
                    backgroundColor: Colors.white,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sText("Clear all",color: appMainRedColor,weight: FontWeight.w600,size: 12),
                        const SizedBox(width: 5,),
                        Image.asset("assets/images/close.png",width: 15,)
                      ],
                    )
                    , onPressed:(){}),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: TabBarSlider(
              myTabs:myTabs,
              child:  const [
                NotificationWidgetPage(),
                NotificationWidgetPage(),
                NotificationWidgetPage(),
                NotificationWidgetPage(),
                NotificationWidgetPage(),

              ],
            ),
          )
        ],
      ),
    );
  }
}


class NotificationWidgetPage extends StatefulWidget {
  const NotificationWidgetPage({super.key});

  @override
  State<NotificationWidgetPage> createState() => _NotificationWidgetPagState();
}

class _NotificationWidgetPagState extends State<NotificationWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10,
              itemBuilder: (context,index){
                return const NotificationWidget();

          }),
        ),
      ],
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("assets/images/orders_noti.png",width: 28,),
              const SizedBox(width: 10,),
              const Expanded(
                child: Text.rich(
                  TextSpan(
                      text: "New Order Received! ",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                      children: [
                        TextSpan(
                          text: " A customer has placed an order for Jollof Rice and Suya. Please review and confirm.",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black
                          ),
                        ),
                      ]
                  ),

                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Image.asset("assets/images/notify.png",width: 10,),

            ],

          ),
          Divider()
        ],
      ),
    );
  }
}
