import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/cubit_state/order_summary_state.dart';
import 'package:urbandrop/models/order_summary_model.dart';



class OrderSummaryController extends Cubit<OrderSummaryState>{
  OrderSummaryController() : super(OrderSummaryInitial());
  final userPreferences = UserPreferences();
  final HttpClientWrapper _http = HttpClientWrapper();
  int position = 0;
  int page = 1;
  bool loading = false;
  bool initiallyExpanded = false;

  String listOrder = 'recent';
  String selectedListOrder = 'recent';
  OrderSummary? orderSummary;
  Future<void> getOrderSummary({bool initial = true})async{
    OrderSummaryModel? orderSummaryModel;
    if(orderSummary == null){
      orderSummary = null;
      emit(OrderSummaryInitial());
      try{
        var response  =  await _http.getRequest("${AppUrl.orders}/summary/today");
        orderSummaryModel = OrderSummaryModel.fromJson(response);
        if(orderSummaryModel.status?.toUpperCase() == AppResponseCodes.success){
          orderSummary = orderSummaryModel.data;
          emit(OrderSummaryLoaded(orderSummary: orderSummary));
        }else{
          emit(OrderSummaryEmpty());
        }
      }catch(e){
        emit(OrderSummaryEmpty());
      }
    }

  }



}