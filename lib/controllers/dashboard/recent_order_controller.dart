import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/cubit_state/order_summary_state.dart';
import 'package:urbandrop/cubit_state/recent_order_state.dart';
import 'package:urbandrop/models/order_summary_model.dart';
import 'package:urbandrop/models/orders_model.dart';



class RecentOrderController extends Cubit<RecentOrderState>{
  RecentOrderController() : super(RecentOrderInitial());
  final userPreferences = UserPreferences();
  final HttpClientWrapper _http = HttpClientWrapper();
  int position = 0;
  int page = 1;
  bool loading = false;
  bool initiallyExpanded = false;
  OrderData? recentOrderData;
  String listOrder = 'recent';
  String selectedListOrder = 'recent';
  Future<void> getRecentOrder({bool initial = true})async{
    if(initial){
      recentOrderData = null;
      emit(RecentOrderInitial());
    }
    try{
      var response  =  await _http.getRequest("${AppUrl.orders}/recent");
      if(response["status"].toUpperCase() == AppResponseCodes.success){
        recentOrderData = OrderData.fromJson(response["data"]);
        emit(RecentOrderLoaded(recentOrderData: recentOrderData));
      }else{
        emit(RecentOrderEmpty());
      }
    }catch(e){
      emit(RecentOrderEmpty());
    }
  }



}