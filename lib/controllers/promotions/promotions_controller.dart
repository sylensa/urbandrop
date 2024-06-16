import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Routing;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/helper/hide.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/models/promotions_model.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/models/user.dart';

class PromotionsController extends GetxController{
  final HttpClientWrapper _http = HttpClientWrapper();
  final RefreshController refreshController =  RefreshController(initialRefresh: false);
  Timer? _debounce;
  final Rx<List<PromotionsData>> listPromotions = Rx<List<PromotionsData>>([]);
  final Rx<PromotionsData?> promotions = Rx<PromotionsData?>(null);
  final Rx<String> errorMessage = Rx<String>("");
  final Rx<bool> loading = Rx<bool>(true);
  final Rx<bool> paginationLoading = Rx<bool>(false);
  final userPreferences = UserPreferences();

  @override
  onReady() {
    super.onReady();
    start();
  }

  Future start({updateLoader = false}) async {
    return Future.wait([getPromotions(),]);
  }

  Future<void> getPromotions({int limit = 10, int offset = 0})async{
    PromotionsModel? promotionsModel;
    errorMessage.value = "";
    try{
      var response  =  await _http.getRequest("${AppUrl.promotions}}");
      promotionsModel = PromotionsModel.fromJson(response);
      if(promotionsModel.status?.toUpperCase() == AppResponseCodes.success){
        listPromotions.value.addAll(promotionsModel.data ?? []);
      }else{
        errorMessage.value = promotionsModel.message!;
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    refreshData();
  }
  Future<void> getPromotion({String? promotionId})async{
    errorMessage.value = "";
    try{
      var response  =  await _http.getRequest("${AppUrl.promotions}/$promotionId");
      if(response["status"].toUpperCase() == AppResponseCodes.success){
        promotions.value = PromotionsData.fromJson(response["data"]);
      }else{
        errorMessage.value = response["message"];
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    refreshData();
  }
  deletePromotion({String? promotionId})async{
    errorMessage.value = "";
    try{
      var response  =  await _http.deleteRequest("${AppUrl.promotions}/$promotionId");
      if(response["status"].toUpperCase() == AppResponseCodes.success){
        return true;
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    return false;
  }
  uploadPromotion(BuildContext context, Map<String, String> body,File? mediaPath,PromotionsData? promotionsData) async {
    showLoaderDialog(context);
    try{
      var headers = {
        "Content-Type": "multipart/form-data",
        'Authorization': 'Bearer ${await userPreferences.getUserToken()}',
        'x-api-key': MERCHANT_API_KEY,
        'x-client' : 'mobile'
      };
      var request;
      if(promotionsData != null){
        request = http.MultipartRequest('put', Uri.parse("${AppUrl.promotions}/${promotionsData.id}"),);
      }else{
        request = http.MultipartRequest('post', Uri.parse(AppUrl.promotions),);
      }

      print("body: $body");
      print("mediaPath: $mediaPath");
      request.fields.addAll(body);
      request.headers.addAll(headers);
      if(mediaPath  != null){
        var ext = mediaPath.path.split('.').last;
        request.files.add(
          http.MultipartFile("image", mediaPath.readAsBytes().asStream(),mediaPath.lengthSync(),
              filename: mediaPath.path.split("/").last, contentType: MediaType('image', ext)),
        );
      }
      log("request: ${request.fields}");
      log("request filles: ${request.files}");
      var res = await request.send();
      var responseData = await res.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print('responseString: $responseString');
      Map responseMap = json.decode(responseString);
      print('responseMap: $responseMap');
      if(responseMap["status"] == AppResponseCodes.success){
        PromotionsData?  promotion = PromotionsData.fromJson(responseMap["data"]);
        List<PromotionsData> listPromotionsData = [];
        listPromotionsData.add(promotion);
        if(promotionsData == null){
          if(listPromotions.value.isNotEmpty){
            listPromotions.value.insertAll(0, listPromotionsData);
          }else{
            listPromotions.value.addAll(listPromotionsData);
          }
        }else{
          if(listPromotions.value.contains(promotionsData)){
            listPromotions.value.remove(promotionsData);
            listPromotions.value.insertAll(0,listPromotionsData);
          }

        }


        listPromotions.refresh();
        toastSuccessMessage(responseMap["message"], context);
        context.pop();
      } else  if(responseMap["status"] == AppResponseCodes.invalidToken){
        var bodys = {
          "id": userInstance!.id,
          "refresh_token" : userInstance!.refreshToken
        };
        var res = await _http.postRequest(AppUrl.refreshToken, bodys);
        print("res object:$res");
        if(res["status"] == AppResponseCodes.success){
          UserModel user = UserModel.fromJson(res['data']);
          await userPreferences.setUser(res['data']);
          await userPreferences.setToken(user.token!);
          await  uploadPromotion(context,body,mediaPath,promotionsData);
        }else{
          context.pop();
          toastMessage("${res["message"]}", context);
        }
      }
      else{
        print('StatusCode: ${res.statusCode}');
        toastMessage("${responseMap["message"]}", context);
        context.pop();
      }
    }catch(e){
      print("object:${ e.toString()}");
      toastMessage(e.toString(),context);
      context.pop();
    }
  }

  void onRefresh()async{
    paginationLoading.value = true;
    paginationLoading.refresh();
    listPromotions.value = [];
    loading.value = true;
    await start();
    refreshData();
    refreshController.loadComplete();
  }
  refreshData(){
    listPromotions.refresh();
    errorMessage.refresh();
    loading.value = false;
    loading.refresh();
    paginationLoading.value = false;
    paginationLoading.refresh();
  }



}