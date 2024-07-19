import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
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
  final Rx<OrderSummary?> orderSummary = Rx<OrderSummary?>(null);
  final Rx<OrderData?> recentOrderData = Rx<OrderData?>(null);
  final Rx<OrderData?> recentOrderDelivery = Rx<OrderData?>(null);
  final Rx<List<ProductData>> topProducts = Rx<List<ProductData>>([]);
  final Rx<String> errorMessage = Rx<String>("");
  final Rx<bool> loading = Rx<bool>(true);
  final Rx<bool> paginationLoading = Rx<bool>(false);
  final Rx<List<FaqData>> listFaqData = Rx<List<FaqData>>([]);
  final Rx<ConfigData?> configModel = Rx<ConfigData?>(null);

  @override
  onReady() {
    super.onReady();
    start();
  }

  Future start({updateLoader = false}) async {
    return Future.wait([getOrderSummary(),getTopProducts()]);
  }

  Future<void> getOrderSummary({int limit = 10, int offset = 0})async{
    OrderSummaryModel? orderSummaryModel;
    errorMessage.value = "";
    try{
      var response  =  await _http.getRequest("${AppUrl.orders}/summary/today");
      orderSummaryModel = OrderSummaryModel.fromJson(response);
      if(orderSummaryModel.status?.toUpperCase() == AppResponseCodes.success){
        orderSummary.value = orderSummaryModel.data;
      }else{
        errorMessage.value = orderSummaryModel.message!;
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    refreshData();
  }
  Future<void> getRecentOrder({int limit = 10, int offset = 0})async{
    errorMessage.value = "";
    try{
      var response  =  await _http.getRequest("${AppUrl.orders}/recent");
      if(response["status"].toUpperCase() == AppResponseCodes.success){
        recentOrderData.value = OrderData.fromJson(response["data"]);
      }else{
        errorMessage.value = response["message"]!;
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    refreshData();
  }
  Future<void> getTopProducts({int limit = 10, int offset = 0})async{
    ProductModel? productModel;
    errorMessage.value = "";
    try{
      var response  =  await _http.getRequest("${AppUrl.products}/top");
      productModel = ProductModel.fromJson(response);
      if(productModel.status!.toUpperCase() == AppResponseCodes.success){
        topProducts.value.addAll(productModel.data!);
      }else{
        errorMessage.value = productModel.message!;
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    refreshData();
  }
  Future<void> getRecentDelivery({int limit = 10, int offset = 0})async{
    OrdersModel? ordersModel;
    errorMessage.value = "";
    try{
      var response  =  await _http.getRequest("${AppUrl.orders}/list?status=delivering&limit=1");
      ordersModel = OrdersModel.fromJson(response);
      if(ordersModel.status?.toUpperCase() == AppResponseCodes.success){
        recentOrderDelivery.value = ordersModel.data!.isNotEmpty ? ordersModel.data!.first : null;
      }else{
        errorMessage.value = ordersModel.message!;
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    refreshData();
  }
  offOnlineStatus(BuildContext context,{bool? available})async{
    final AuthenticationController authenticationController = AuthenticationController();
    final response = await authenticationController.update(context,{
      "available": available ?? false
    }, );
  }
  void onRefresh()async{
    paginationLoading.value = true;
    paginationLoading.refresh();
    orderSummary.value = null;
    loading.value = true;
    recentOrderData.value = null;
    recentOrderDelivery.value = null;
    topProducts.value = [];
    await start();
    refreshData();
    refreshController.loadComplete();
  }
  refreshData(){
    orderSummary.refresh();
    errorMessage.refresh();
    recentOrderData.refresh();
    topProducts.refresh();
    loading.value = false;
    loading.refresh();
    paginationLoading.value = false;
    paginationLoading.refresh();
  }



}