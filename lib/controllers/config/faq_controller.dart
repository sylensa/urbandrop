import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/cubit_state/faq_state.dart';
import 'package:urbandrop/cubit_state/order_summary_state.dart';
import 'package:urbandrop/models/faq_model.dart';
import 'package:urbandrop/models/order_summary_model.dart';



class FaqController extends Cubit<FaqState>{
  FaqController() : super(FaqInitial());
  final userPreferences = UserPreferences();
  final HttpClientWrapper _http = HttpClientWrapper();
  List<FaqData> listFaqData = [];
  getFaq() async {
    if(listFaqData.isEmpty){
      emit(FaqInitial());
      try {
        var response = await _http.getRequest(AppUrl.faq);
        FaqModel faqModel = FaqModel.fromJson(response);
        if (faqModel.status == AppResponseCodes.success) {
          listFaqData.addAll(faqModel.data ?? []);
          emit(FaqLoaded(listFaqData: listFaqData));
        }else{
          emit(FaqEmpty());
        }

      } catch (e) {
        emit(FaqEmpty());
      }
    }

  }



}