import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/cubit_state/order_summary_state.dart';
import 'package:urbandrop/cubit_state/recent_delivery_state.dart';
import 'package:urbandrop/cubit_state/recent_order_state.dart';
import 'package:urbandrop/cubit_state/top_product_state.dart';
import 'package:urbandrop/models/order_summary_model.dart';
import 'package:urbandrop/models/orders_model.dart';
import 'package:urbandrop/models/product_model.dart';



class RecentDeliveryController extends Cubit<RecentDeliveryState>{
  RecentDeliveryController() : super(RecentDeliveryInitial());
  final userPreferences = UserPreferences();
  final HttpClientWrapper _http = HttpClientWrapper();
  int position = 0;
  int page = 1;
  bool loading = false;
  bool initiallyExpanded = false;
  OrderData? recentOrderDelivery;
  Future<void> getRecentDelivery({bool initial = true})async{
    if(recentOrderDelivery == null){
      recentOrderDelivery = null;
      emit(RecentDeliveryInitial());
      OrdersModel? ordersModel;
      try{
        var response  =  await _http.getRequest("${AppUrl.orders}/list?status=delivering&limit=1");
        ordersModel = OrdersModel.fromJson(response);
        if(ordersModel.status?.toUpperCase() == AppResponseCodes.success){
          recentOrderDelivery = ordersModel.data!.isNotEmpty ? ordersModel.data!.first : null;
          if(recentOrderDelivery != null){
            emit(RecentDeliveryLoaded(recentOrderDelivery: recentOrderDelivery));
          }else{
            emit(RecentDeliveryEmpty());
          }
        }else{
          emit(RecentDeliveryEmpty());
        }
      }catch(e){
        emit(RecentDeliveryEmpty());
      }
    }

  }



}