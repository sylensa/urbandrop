import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:urbandrop/controllers/dashboard/dashboard_controller.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/helper/hide.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/models/product_model.dart';
import 'package:urbandrop/models/user.dart';

class ProductsController extends GetxController{
  final HttpClientWrapper _http = HttpClientWrapper();
  final RefreshController refreshController =  RefreshController(initialRefresh: false);
  Timer? _debounce;
  final Rx<List<ProductData>> listProducts = Rx<List<ProductData>>([]);
  final Rx<List<ProductData>> unFilteredListProducts = Rx<List<ProductData>>([]);
  final Rx<String> errorMessage = Rx<String>("");
  final Rx<bool> loading = Rx<bool>(true);
  final Rx<bool> paginationLoading = Rx<bool>(false);
  final userPreferences = UserPreferences();
  final stateDashboard = Get.put(DashboardController());
  // function called once the controller is instantiated
  @override
  onReady() {
    super.onReady();
    // start all controller defaults
    start();
  }


  Future start({updateLoader = false}) async {
    return Future.wait([getProducts()]);
  }

  Future<void> getProducts({int limit = 10, int offset = 0, bool refreshing = true})async{
    ProductModel? productModel;
    listProducts.value.clear();
    errorMessage.value = "";
    try{
      var response  =  await _http.getRequest("${AppUrl.products}/list?limit=$limit&offset=$offset");
      productModel = ProductModel.fromJson(response);
      if(productModel.status?.toUpperCase() == AppResponseCodes.success){
        if(refreshing){
          listProducts.value.clear();
          unFilteredListProducts.value.clear();
        }
        listProducts.value.addAll(productModel.data!);
        unFilteredListProducts.value.addAll(productModel.data!);
      }else{
        errorMessage.value = productModel.message!;
      }
    }catch(e){
      errorMessage.value = e.toString();
    }
    refreshData();
  }

  deleteProduct(String productId, BuildContext context)async{
    showLoaderDialog(context);
   try{
     final response = await _http.deleteRequest("${AppUrl.products}/$productId");
     if(response["status"].toUpperCase() == AppResponseCodes.success){
       removeProductFromList(productId);
       toastSuccessMessage(response["message"], context);
       context.pop();
       return true;
     }
   }
   catch(e){
     toastMessage(e.toString(), context);
   }
    context.pop();
   return false;
  }
  outOfStock(String productId,)async{

   try{
     final response = await _http.putRequest("${AppUrl.productStock}/$productId",{});
     if(response["status"].toUpperCase() == AppResponseCodes.success){
       return true;
     }
   }
   catch(e){
   }
   return false;
  }

  removeProductFromList(String productId){

    for(int i =0; i < listProducts.value.length; i++){
      if(listProducts.value[i].id == productId){
        listProducts.value.removeAt(i);
        listProducts.refresh();
      }
    }
    for(int i =0; i < stateDashboard.topProducts.value.length; i++){
      if(stateDashboard.topProducts.value[i].id == productId){
        stateDashboard.topProducts.value.removeAt(i);
        stateDashboard.topProducts.refresh();
      }
    }

  }

  uploadProduct(BuildContext context, Map<String, String> body,File? mediaPath,ProductData? product) async {
    showLoaderDialog(context);
    try{
      var headers = {
        "Content-Type": "multipart/form-data",
        'Authorization': 'Bearer ${await userPreferences.getUserToken()}',
        'x-api-key': MERCHANT_API_KEY,
        'x-client' : 'mobile'
      };
      var request;
      if(product != null){
        request = http.MultipartRequest('put', Uri.parse("${AppUrl.products}/${product.id}"),);
      }else{
        request = http.MultipartRequest('post', Uri.parse(AppUrl.products),);
      }

      print("body: $body");
      print("mediaPath: $mediaPath");
      // if(mediaPath != null){
      //   final directory = await getApplicationDocumentsDirectory();
      //   if (Platform.isIOS) {
      //     mediaPath = File('${directory.path}/${mediaPath.path.split("/").last}');
      //     if(!mediaPath.existsSync()){
      //       mediaPath  =  await mediaPath.create(recursive: true);
      //     }
      //   }
      //   else if (Platform.isAndroid) {
      //     if(!mediaPath.existsSync()){
      //       mediaPath  =  await mediaPath.create(recursive: true);
      //     }
      //   }
      //   print("mediaPath2: $mediaPath");
      // }

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
        ProductData  productData = ProductData.fromJson(responseMap["data"]);
        List<ProductData> listProduct = [];
        listProduct.add(productData);
        if(product == null){
          if(listProducts.value.isNotEmpty){
            listProducts.value.insertAll(0, listProduct);
            stateDashboard.topProducts.value.insertAll(0, listProduct);
          }else{
            listProducts.value.addAll(listProduct);
            stateDashboard.topProducts.value.addAll(listProduct);
          }
        }else{
          if(listProducts.value.contains(product)){
            listProducts.value.remove(product);
            listProducts.value.insertAll(0,listProduct);
          }
          if(stateDashboard.topProducts.value.contains(product)){
            stateDashboard.topProducts.value.remove(product);
            stateDashboard.topProducts.value.insertAll(0,listProduct);
          }
        }


        listProducts.refresh();
        stateDashboard.topProducts.refresh();
        toastSuccessMessage(responseMap["message"], context);
        context.pop();
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
          await  uploadProduct(context,body,mediaPath,product);
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
    loading.value = true;
    paginationLoading.refresh();
    listProducts.value.clear();
    unFilteredListProducts.value.clear();
    await getProducts(limit: 10,offset: 0);
    refreshData();
    refreshController.loadComplete();
  }
  void onLoading()async{
    paginationLoading.value = true;
    paginationLoading.refresh();
    await getProducts(limit: 10,offset:  listProducts.value.length,refreshing: false);
    refreshData();
    refreshController.refreshCompleted();
  }

  onSearchChanged(String value){
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 0), (){
      if(value.isNotEmpty){

      }else{
        listProducts.value.addAll(unFilteredListProducts.value);
      }
    });
    refreshData();
  }

  filterProducts(String type,String date){
    if(type.isNotEmpty  || date.isNotEmpty){

    }else{
      listProducts.value.addAll(unFilteredListProducts.value);
    }
    refreshData();
  }


  refreshData(){
    listProducts.refresh();
    errorMessage.refresh();
    unFilteredListProducts.refresh();
    loading.value = false;
    loading.refresh();
    paginationLoading.value = false;
    paginationLoading.refresh();
  }



}