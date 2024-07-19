import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:urbandrop/controllers/dashboard/dashboard_controller.dart';
import 'package:urbandrop/controllers/dashboard/top_product_controller.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/helper/hide.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/cubit_state/product_state.dart';
import 'package:urbandrop/models/product_model.dart';
import 'package:urbandrop/models/user.dart';

class ProductsController extends Cubit<ProductState>{
  ProductsController() : super(ProductInitial());
  final HttpClientWrapper _http = HttpClientWrapper();
  Timer? _debounce;
  List<ProductData> listProducts = [];
  List<ProductData>  unFilteredListProducts = [];
  final userPreferences = UserPreferences();
  late TopProductController topProductController;
  int offset = 1;

  Future<void> getProducts({int limit = 10, bool refreshing = true})async{
    ProductModel? productModel;
    if(refreshing){
      listProducts.clear();
      unFilteredListProducts.clear();
      offset = 1;
      emit(ProductInitial());

    }
    try{
      var response  =  await _http.getRequest("${AppUrl.products}/list?limit=$limit&page=$offset");
      productModel = ProductModel.fromJson(response);
      if(productModel.status?.toUpperCase() == AppResponseCodes.success){
        listProducts.addAll(productModel.data!);
        unFilteredListProducts.addAll(productModel.data!);
      }
      if(listProducts.isNotEmpty){
        emit(ProductLoaded(listProducts: listProducts));
      }else{
        emit(ProductEmpty());
      }
      
    }catch(e){
      emit(ProductEmpty());
    }
  }

  deleteProduct(String productId, BuildContext context)async{
    showLoaderDialog(context);
   try{
     final response = await _http.deleteRequest("${AppUrl.products}/$productId");
     if(response["status"].toUpperCase() == AppResponseCodes.success){
       removeProductFromList(productId,context);
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
   catch(e){}
   return false;
  }

  removeProductFromList(String productId,BuildContext context){
    topProductController = context.read<TopProductController>();

    for(int i =0; i < listProducts.length; i++){
      if(listProducts[i].id == productId){
        listProducts.removeAt(i);
      }
    }
    for(int i =0; i < topProductController.topProducts.length; i++){
      if(topProductController.topProducts[i].id == productId){
        topProductController.topProducts.removeAt(i);
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
          if(listProducts.isNotEmpty){
            listProducts.insertAll(0, listProduct);
            topProductController.topProducts.insertAll(0, listProduct);
          }else{
            listProducts.addAll(listProduct);
            topProductController.topProducts.addAll(listProduct);
          }
        }else{
          if(listProducts.contains(product)){
            listProducts.remove(product);
            listProducts.insertAll(0,listProduct);
          }
          if(topProductController.topProducts.contains(product)){
            topProductController.topProducts.remove(product);
            topProductController.topProducts.insertAll(0,listProduct);
          }
        }


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
    listProducts.clear();
    unFilteredListProducts.clear();
    offset = 1;
    await getProducts(limit: 10,refreshing: true);
  }
  void onLoading()async{
    offset++;
    await getProducts(limit: 10,refreshing: false);
  }

  onSearchChanged(String value){
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 0), (){
      if(value.isNotEmpty){

      }else{
        listProducts.addAll(unFilteredListProducts);
      }
    });
    
  }

  filterProducts(String type,String date){
    if(type.isNotEmpty  || date.isNotEmpty){

    }else{
      listProducts.addAll(unFilteredListProducts);
    }
    
  }






}