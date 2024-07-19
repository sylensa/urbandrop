import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/controllers/dashboard/order_summary_controller.dart';
import 'package:urbandrop/controllers/dashboard/recent_delivery_controller.dart';
import 'package:urbandrop/controllers/dashboard/recent_order_controller.dart';
import 'package:urbandrop/controllers/dashboard/top_product_controller.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/models/config_model.dart';
import 'package:urbandrop/models/faq_model.dart';
import 'package:urbandrop/models/order_summary_model.dart';
import 'package:urbandrop/models/orders_model.dart';
import 'package:urbandrop/models/product_model.dart';

class DashboardController extends GetxController{
  final HttpClientWrapper _http = HttpClientWrapper();
  final RefreshController refreshController =  RefreshController(initialRefresh: false);
  Timer? _debounce;
  late OrderSummaryController orderSummaryController;
  late RecentDeliveryController recentDeliveryController;
  late RecentOrderController recentOrderController;
  late TopProductController topProductController;

  @override
  onReady() {
    super.onReady();
    start();
  }

  Future start({updateLoader = false}) async {
    return Future.wait([]);
  }


  offOnlineStatus(BuildContext context,{bool? available})async{
    final AuthenticationController authenticationController = AuthenticationController();
    final response = await authenticationController.update(context,{
      "available": available ?? false
    }, );
  }
  void onRefresh(BuildContext context)async{
    topProductController = context.read<TopProductController>();
    orderSummaryController = context.read<OrderSummaryController>();
    recentDeliveryController = context.read<RecentDeliveryController>();
    recentOrderController = context.read<RecentOrderController>();
    topProductController.topProducts.clear();
    orderSummaryController.orderSummary == null;
    recentDeliveryController.recentOrderDelivery == null;
    recentOrderController.recentOrderData == null;
    await topProductController.getTopProducts();
    await orderSummaryController.getOrderSummary();
    await recentDeliveryController.getRecentDelivery();
    await recentOrderController.getRecentOrder();
  }




}