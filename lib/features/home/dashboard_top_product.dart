import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrop/controllers/dashboard/top_product_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/cubit_state/top_product_state.dart';
import 'package:urbandrop/features/widget/product_widget.dart';

class DashboardTopProduct extends StatefulWidget {
  const DashboardTopProduct({super.key});

  @override
  State<DashboardTopProduct> createState() => _DashboardTopProductState();
}

class _DashboardTopProductState extends State<DashboardTopProduct> {
  late TopProductController topProductController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topProductController = context.read<TopProductController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      topProductController.getTopProducts();
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopProductController,TopProductState>(builder: (context,state){
      return  Column(
        children: [
          Row(
            children: [
              sText("Popular products",weight: FontWeight.w500,size: 15,color: Colors.black)
            ],
          ),
          const SizedBox(height: 20,),
          if(state is TopProductLoaded)
          SizedBox(
            height: 200,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.topProducts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return Row(
                    children: [
                      ProductWidget(productData: state.topProducts[index],),
                      const SizedBox(width: 10,),
                    ],
                  );

                }),
          ),
          const SizedBox(height: 20,),
        ],
      );
    });
  }
}
