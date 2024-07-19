import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrop/controllers/dashboard/recent_delivery_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/cubit_state/recent_delivery_state.dart';
import 'package:urbandrop/features/widget/recent_delivery.dart';

class DashboardRecentDelivery extends StatefulWidget {
  const DashboardRecentDelivery({super.key});

  @override
  State<DashboardRecentDelivery> createState() => _DashboardRecentDeliveryState();
}

class _DashboardRecentDeliveryState extends State<DashboardRecentDelivery> {
  late RecentDeliveryController recentDeliveryController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recentDeliveryController = context.read<RecentDeliveryController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      recentDeliveryController.getRecentDelivery();
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentDeliveryController,RecentDeliveryState>(builder: (context,state){
      return Column(
        children: [
          Row(
            children: [
              sText("Recent delivery",weight: FontWeight.w500,size: 15,color: Colors.black)
            ],
          ),
          const SizedBox(height: 20,),
          if(state is RecentDeliveryLoaded)
          RecentDDeliveryWidget(recentDelivery: state.recentOrderDelivery,),
          const SizedBox(height: 20,),

        ],
      );
    });
  }
}
