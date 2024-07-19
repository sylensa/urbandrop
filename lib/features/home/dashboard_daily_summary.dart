import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrop/controllers/dashboard/order_summary_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/cubit_state/order_summary_state.dart';
import 'package:urbandrop/features/widget/daily_summary_widget.dart';

class DashboardDailySummary extends StatefulWidget {
  const DashboardDailySummary({super.key});

  @override
  State<DashboardDailySummary> createState() => _DashboardDailySummaryState();
}

class _DashboardDailySummaryState extends State<DashboardDailySummary> {
  late OrderSummaryController orderSummaryController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderSummaryController = context.read<OrderSummaryController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      orderSummaryController.getOrderSummary();
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderSummaryController,OrderSummaryState>(builder: (context,state){
      return Column(
        children: [
          const SizedBox(height: 10,),
          Row(
            children: [
              sText("Daily Summary",weight: FontWeight.w500,size: 15,color: Colors.black)
            ],
          ),
          const SizedBox(height: 20,),
          if(state is OrderSummaryLoaded)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: DailySummary(backgroundColor: const Color(0xFF5CB35E).withOpacity(0.3),amount: "${state.orderSummary?.count}",)),
              const SizedBox(width: 10,),
              Expanded(child: DailySummary(backgroundColor: const Color(0xFF5CB35E),textColor: Colors.white,title: "received",amount: "£ ${state.orderSummary?.revenue}",image: "received.png",)),
              const SizedBox(width: 10,),
              Expanded(child: DailySummary(backgroundColor: const Color(0xFF183A37),textColor: Colors.white,title: "deliveries",amount: "${state.orderSummary?.deliveries}",image: "deliveries.png",))
            ],
          ),
          const SizedBox(height: 20,),
        ],
      );
    });
  }
}
