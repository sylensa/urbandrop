import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrop/controllers/dashboard/recent_order_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/cubit_state/recent_order_state.dart';
import 'package:urbandrop/features/widget/recent_order_widget.dart';

class DashboardRecentOrder extends StatefulWidget {
  const DashboardRecentOrder({super.key});

  @override
  State<DashboardRecentOrder> createState() => _DashboardRecentOrderState();
}

class _DashboardRecentOrderState extends State<DashboardRecentOrder> {
  late RecentOrderController recentOrderController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recentOrderController = context.read<RecentOrderController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      recentOrderController.getRecentOrder();
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentOrderController,RecentOrderState>(builder: (context,state){
      return Column(
        children: [
          if(state is RecentOrderLoaded)
          Column(
            children: [
              Row(
                children: [
                  sText("Recent order",weight: FontWeight.w500,size: 15,color: Colors.black)
                ],
              ),
              const SizedBox(height: 20,),
              RecentOrder(recentOrder: state.recentOrderData ,),
              const SizedBox(height: 20,),
            ],
          )
        ],
      );
    });
  }
}
