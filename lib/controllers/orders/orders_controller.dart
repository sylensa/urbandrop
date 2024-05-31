import 'dart:async';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/models/orders_model.dart';

class OrdersController extends GetxController{
  final HttpClientWrapper _http = HttpClientWrapper();
  final RefreshController refreshController =  RefreshController(initialRefresh: false);
  Timer? _debounce;
  final Rx<List<OrderData>> listOrders = Rx<List<OrderData>>([]);
  final Rx<List<OrderData>> listPendingOrders = Rx<List<OrderData>>([]);
  final Rx<List<OrderData>> listConfirmOrders = Rx<List<OrderData>>([]);
  final Rx<List<OrderData>> listInProgressOrders = Rx<List<OrderData>>([]);
  final Rx<List<OrderData>> listCompletedOrders = Rx<List<OrderData>>([]);
  final Rx<List<OrderData>> listDeclineOrders = Rx<List<OrderData>>([]);
  final Rx<List<OrderData>> listCancelledOrders = Rx<List<OrderData>>([]);
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

  Future<void> getOrders({int limit = 10, int offset = 0, bool onLoading = false})async{
    OrdersModel? ordersModel;
    errorMessage.value = "";
    try{
      var response  =  await _http.getRequest("${AppUrl.orders}/list?limit=$limit&offset=$offset");
      ordersModel = OrdersModel.fromJson(response);
      if(ordersModel.status?.toUpperCase() == AppResponseCodes.success){
        if(!onLoading){
          listOrders.value.clear();
          unFilteredListOrders.value.clear();
        }
        listOrders.value.addAll(ordersModel.data!);
        unFilteredListOrders.value.addAll(ordersModel.data!);
        loadAllOrderStatus(listOrders.value,onLoading: onLoading);
      }else{
        errorMessage.value = ordersModel.message!;
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    refreshData();
  }

  loadPendingOrders(List<OrderData> orders,{bool onLoading = false}){
    List<OrderData> pending = orders.where((element) => element.status == OrderStatus.pending).toList();
    if(!onLoading){
      listPendingOrders.value.clear();
    }
    listPendingOrders.value.isNotEmpty ? listPendingOrders.value.insertAll(0, pending) : listPendingOrders.value.addAll(pending);
    listPendingOrders.refresh();
  }
  loadConfirmOrders(List<OrderData> orders,{bool onLoading = false}){
    List<OrderData> confirm = orders.where((element) => element.status == OrderStatus.accepted).toList();
    if(!onLoading){
      listConfirmOrders.value.clear();
    }
    listConfirmOrders.value.isNotEmpty ? listConfirmOrders.value.insertAll(0, confirm) : listConfirmOrders.value.addAll(confirm);
    listConfirmOrders.refresh();
  }
  loadInProgressOrders(List<OrderData> orders,{bool onLoading = false}){
    List<OrderData> progress = orders.where((element) => element.status == OrderStatus.delivering).toList();
    if(!onLoading){
      listInProgressOrders.value.clear();
    }
    listInProgressOrders.value.isNotEmpty ? listInProgressOrders.value.insertAll(0, progress) : listInProgressOrders.value.addAll(progress);
    listInProgressOrders.refresh();
  }
  loadCompletedOrders(List<OrderData> orders,{bool onLoading = false}){
    List<OrderData> completed = orders.where((element) => element.status == OrderStatus.completed).toList();
    if(!onLoading){
      listCompletedOrders.value.clear();
    }
    listCompletedOrders.value.isNotEmpty ? listCompletedOrders.value.insertAll(0, completed) : listCompletedOrders.value.addAll(completed);
    listCompletedOrders.refresh();
  }
  loadDeclineOrders(List<OrderData> orders,{bool onLoading = false}){
    List<OrderData> decline = orders.where((element) => element.status == OrderStatus.declined).toList();
    if(!onLoading){
      listDeclineOrders.value.clear();
    }
    listDeclineOrders.value.isNotEmpty ? listCompletedOrders.value.insertAll(0, decline) : listDeclineOrders.value.addAll(decline);
    listDeclineOrders.refresh();
  }
  loadCancelledOrders(List<OrderData> orders,{bool onLoading = false}){
    List<OrderData> cancel = orders.where((element) => element.status == OrderStatus.cancelled).toList();
    if(!onLoading){
      listCancelledOrders.value.clear();
    }
    listCancelledOrders.value.isNotEmpty ? listCancelledOrders.value.insertAll(0, cancel) : listCancelledOrders.value.addAll(cancel);
    listCancelledOrders.refresh();
  }

  loadAllOrderStatus(List<OrderData> orders,{bool onLoading = false}){
    loadPendingOrders(listOrders.value,onLoading: onLoading);
    loadConfirmOrders(listOrders.value,onLoading: onLoading);
    loadInProgressOrders(listOrders.value,onLoading: onLoading);
    loadCompletedOrders(listOrders.value,onLoading: onLoading);
    loadDeclineOrders(listOrders.value,onLoading: onLoading);
    loadCancelledOrders(listOrders.value,onLoading: onLoading);

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

    onSearchChanged(String value,String orderStatus){
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 0), (){
      if(value.isNotEmpty){
        listOrders.value.clear();
        listOrders.value = unFilteredListOrders.value.where((element) => element.status!.toLowerCase().contains(value.toLowerCase()) || formatDateTime(element.completedAt!.isNotEmpty ? DateTime.parse("${element.completedAt}") : DateTime.now()).toLowerCase().contains(value.toLowerCase())
            || formatDateTime(element.createdAt!.isNotEmpty ? DateTime.parse("${element.createdAt}") : DateTime.now()).toLowerCase().contains(value.toLowerCase())   || element.id!.toLowerCase().contains(value.toLowerCase())
        ).toList();
      }else{
        listOrders.value.addAll(unFilteredListOrders.value);
      }
      listOrders.refresh();
      if(orderStatus == OrderStatus.pending){
        loadPendingOrders(listOrders.value,onLoading: false);
      }else if(orderStatus == OrderStatus.declined){
        loadDeclineOrders(listOrders.value,onLoading: false);
      }else if(orderStatus == OrderStatus.cancelled){
        loadCancelledOrders(listOrders.value,onLoading: false);
      }else if(orderStatus == OrderStatus.completed){
        loadCompletedOrders(listOrders.value,onLoading: false);
      }else if(orderStatus == OrderStatus.delivering){
        loadInProgressOrders(listOrders.value,onLoading: false);
      }else if(orderStatus == OrderStatus.accepted){
        loadConfirmOrders(listOrders.value,onLoading: false);
      }

    });
    refreshData();
  }

  filterOrders(String orderStatus,String date){
    if(orderStatus.isNotEmpty  || date.isNotEmpty){
      listOrders.value.clear();
      listOrders.value = unFilteredListOrders.value.where((element) => element.status!.toLowerCase().contains(orderStatus.toLowerCase()) || formatDateTime(element.completedAt!.isNotEmpty ? DateTime.parse("${element.completedAt}") : DateTime.now()).toLowerCase().contains(date.toLowerCase())
          || formatDateTime(element.createdAt!.isNotEmpty ? DateTime.parse("${element.createdAt}") : DateTime.now()).toLowerCase().contains(date.toLowerCase())
      ).toList();
    }else{
      listOrders.value.addAll(unFilteredListOrders.value);
    }
    if(orderStatus == OrderStatus.pending){
      loadPendingOrders(listOrders.value,onLoading: false);
    }else if(orderStatus == OrderStatus.declined){
      loadDeclineOrders(listOrders.value,onLoading: false);
    }else if(orderStatus == OrderStatus.cancelled){
      loadCancelledOrders(listOrders.value,onLoading: false);
    }else if(orderStatus == OrderStatus.completed){
      loadCompletedOrders(listOrders.value,onLoading: false);
    }else if(orderStatus == OrderStatus.delivering){
      loadInProgressOrders(listOrders.value,onLoading: false);
    }else if(orderStatus == OrderStatus.accepted){
      loadConfirmOrders(listOrders.value,onLoading: false);
    }
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