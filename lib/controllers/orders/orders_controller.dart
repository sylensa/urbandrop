import 'dart:async';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/models/orders_model.dart';

class OrdersController extends GetxController{
  final HttpClientWrapper _http = HttpClientWrapper();
  final RefreshController refreshController =  RefreshController(initialRefresh: false);
  Timer? _debounce;
  final Rx<List<OrderData>> listOrders = Rx<List<OrderData>>([]);
  final Rx<List<OrderData>> unFilteredListOrders = Rx<List<OrderData>>([]);
  final Rx<String> errorMessage = Rx<String>("");
  final Rx<bool> loading = Rx<bool>(true);
  final Rx<bool> paginationLoading = Rx<bool>(false);

  @override
  onReady() {
    super.onReady();
    start();
  }

  Future start({updateLoader = false}) async {
    return Future.wait([getOrders()]);
  }

  Future<void> getOrders({int limit = 10, int offset = 0})async{
    OrdersModel? ordersModel;
    errorMessage.value = "";
    try{
      var response  =  await _http.getRequest("${AppUrl.orders}/list?limit=$limit&offset=$offset");
      ordersModel = OrdersModel.fromJson(response);
      if(ordersModel.status?.toUpperCase() == AppResponseCodes.success){
        listOrders.value.addAll(ordersModel.data!);
        unFilteredListOrders.value.addAll(ordersModel.data!);
      }else{
        errorMessage.value = ordersModel.message!;
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    refreshData();
  }
  deleteOrders({String? orderId})async{
    OrdersModel? ordersModel;
    errorMessage.value = "";
    try{
      var response  =  await _http.deleteRequest("${AppUrl.orders}/$orderId");
      ordersModel = OrdersModel.fromJson(response);
      if(ordersModel.status?.toUpperCase() == AppResponseCodes.success){
        removeOrdersFromList(orderId!);
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    refreshData();
  }
  updateOrders({String? orderId})async{
    OrdersModel? ordersModel;
    errorMessage.value = "";
    try{
      var response  =  await _http.deleteRequest("${AppUrl.orders}/$orderId");
      ordersModel = OrdersModel.fromJson(response);
      if(ordersModel.status?.toUpperCase() == AppResponseCodes.success){

      }else{
        errorMessage.value = ordersModel.message!;
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    refreshData();
  }
  getOrder({String? orderId})async{
    OrdersModel? ordersModel;
    errorMessage.value = "";
    try{
      var response  =  await _http.getRequest("${AppUrl.orders}/$orderId");
      ordersModel = OrdersModel.fromJson(response);
      if(ordersModel.status?.toUpperCase() == AppResponseCodes.success){

      }else{
        errorMessage.value = ordersModel.message!;
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    refreshData();
  }
  removeOrdersFromList(String orderId){
    for(int i =0; i < listOrders.value.length; i++){
      if(listOrders.value[i].id == orderId){
        listOrders.value.removeAt(i);
        listOrders.refresh();
      }
    }
    for(int i =0; i < unFilteredListOrders.value.length; i++){
      if(unFilteredListOrders.value[i].id == orderId){
        unFilteredListOrders.value.removeAt(i);
        unFilteredListOrders.refresh();
      }
    }

  }


  void onRefresh()async{
    paginationLoading.value = true;
    paginationLoading.refresh();
    listOrders.value.clear();
    unFilteredListOrders.value.clear();
    await getOrders(limit: 10,offset: 0);
    // data refresh and th UI is rebuild
    refreshData();
    refreshController.loadComplete();
  }
  // function to handle pagination while scrolling
  void onLoading()async{
    paginationLoading.value = true;
    paginationLoading.refresh();
    await getOrders(limit: 10,offset:  listOrders.value.length);
    refreshData();
    refreshController.refreshCompleted();
  }

  onSearchChanged(String value){
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 0), (){
      if(value.isNotEmpty){
        // if the value is not empty, then i check if the value contains in the various variables
        listOrders.value.clear();
        listOrders.value = unFilteredListOrders.value.where((element) => element.status!.toLowerCase().contains(value.toLowerCase()) || element.completedAt!.toLowerCase().contains(value.toLowerCase())
            || element.createdAt!.toLowerCase().contains(value.toLowerCase())   || element.id!.toLowerCase().contains(value.toLowerCase())
        ).toList();
      }else{
        // if the value is empty then i append the previous list called unFilteredListOrders
        listOrders.value.addAll(unFilteredListOrders.value);
      }
    });
    // data refresh and th UI is rebuild
    refreshData();
  }

  // filter absences by type and date
  filterOrders(String type,String date){
    if(type.isNotEmpty  || date.isNotEmpty){
      listOrders.value.clear();
      // comparing the filtered values when at least one is not empty
      listOrders.value = unFilteredListOrders.value.where((element) => element.status!.toLowerCase().contains(type.toLowerCase()) || element.createdAt!.toLowerCase().contains(date.toLowerCase())
          || element.completedAt!.toLowerCase().contains(date.toLowerCase())
      ).toList();
    }else{
      // when the filter is cleared then the list is reset
      listOrders.value.addAll(unFilteredListOrders.value);
    }
// data refresh and th UI is rebuild
    refreshData();
  }


  // refreshing and rebuild the UI when there is a change in data
  refreshData(){
    listOrders.refresh();
    errorMessage.refresh();
    unFilteredListOrders.refresh();
    loading.value = false;
    loading.refresh();
    paginationLoading.value = false;
    paginationLoading.refresh();
  }



}