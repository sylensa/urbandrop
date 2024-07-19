import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' hide Routing;
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:urbandrop/controllers/products/product_controllers.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/cubit_state/product_state.dart';
import 'package:urbandrop/features/widget/product_widget.dart';
import 'package:urbandrop/features/widget/smart_refresh.dart';
import 'package:urbandrop/routes.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late ProductsController productsController;
  final RefreshController refreshController =  RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productsController = context.read<ProductsController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      await productsController.getProducts();
      setState(() {

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsController,ProductState>(builder: (context,state){
      return Container(
        padding: const EdgeInsets.only(top: 70,left: 20,right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                mainButton(
                    width: 120,
                    height: 30,
                    radius: 30,
                    outlineColor: Colors.transparent,
                    shadowStrength: 0,
                    backgroundColor: primaryColor,
                    content: Row(
                      children: [
                        sText("Add item",color: Colors.white,weight: FontWeight.w600,size: 12),
                        const SizedBox(width: 5,),
                        Image.asset("assets/images/add.png",width: 15,)
                      ],
                    )
                    , onPressed:(){
                  context.push(Routing.addProduct,extra: null);
                }),
              ],
            ),
            const SizedBox(height: 20,),
            if(state is ProductInitial)
            Expanded(child: Center(child: progressCircular(),)),
            if(state is ProductLoaded)
            Expanded(
              child: SmartRefresh(

                onLoading: productsController.onLoading,
                onRefresh: productsController.onRefresh,
                child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal:00,vertical: 20),
                    itemCount: state.listProducts.length,
                    gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 200,
                        mainAxisSpacing: 20,
                        crossAxisSpacing:10

                    ),
                    itemBuilder:(context, index){
                      return  Row(
                        children: [
                          Expanded(child: ProductWidget(productData: state.listProducts[index],fromMenu: true,))
                        ],
                      );
                    }
                ),
              )

              ,
            ) ,
            if(state is ProductEmpty)
            Expanded(child: Center(child: sText("No products" ),)),

          ],
        ),
      );
    });
  }
}
