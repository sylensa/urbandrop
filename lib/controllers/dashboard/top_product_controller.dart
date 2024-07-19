import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/cubit_state/order_summary_state.dart';
import 'package:urbandrop/cubit_state/recent_order_state.dart';
import 'package:urbandrop/cubit_state/top_product_state.dart';
import 'package:urbandrop/models/order_summary_model.dart';
import 'package:urbandrop/models/orders_model.dart';
import 'package:urbandrop/models/product_model.dart';



class TopProductController extends Cubit<TopProductState>{
  TopProductController() : super(TopProductInitial());
  final userPreferences = UserPreferences();
  final HttpClientWrapper _http = HttpClientWrapper();
  int position = 0;
  int page = 1;
  bool loading = false;
  bool initiallyExpanded = false;
  List<ProductData> topProducts = [];

  Future<void> getTopProducts({bool initial = true})async{
    if(topProducts.isEmpty){
      topProducts.clear();
      emit(TopProductInitial());
      ProductModel? productModel;
      try{
        var response  =  await _http.getRequest("${AppUrl.products}/top");
        productModel = ProductModel.fromJson(response);
        if(productModel.status!.toUpperCase() == AppResponseCodes.success){
          topProducts = productModel.data!;
          emit(TopProductLoaded(topProducts: topProducts));
        }else{
          emit(TopProductEmpty());
        }
      }catch(e){
        emit(TopProductEmpty());
      }
    }

  }



}