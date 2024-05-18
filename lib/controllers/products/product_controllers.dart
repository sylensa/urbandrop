import 'dart:async';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/models/product_model.dart';

class ProductsController extends GetxController{
  final HttpClientWrapper _http = HttpClientWrapper();
  final RefreshController refreshController =  RefreshController(initialRefresh: false);
  Timer? _debounce;
  final Rx<List<ProductData>> listProducts = Rx<List<ProductData>>([]);
  final Rx<List<ProductData>> unFilteredListProducts = Rx<List<ProductData>>([]);
  final Rx<String> errorMessage = Rx<String>("");
  final Rx<bool> loading = Rx<bool>(true);
  final Rx<bool> paginationLoading = Rx<bool>(false);

  // function called once the controller is instantiated
  @override
  onReady() {
    super.onReady();
    // start all controller defaults
    start();
  }

  // function to call these getAbsencesData(),getMembersData() concurrently
  Future start({updateLoader = false}) async {
    return Future.wait([getProducts()]);
  }

  // function to fetch orders information through an api
  Future<void> getProducts({int limit = 10, int offset = 0})async{
    ProductModel? productModel;
    errorMessage.value = "";
    try{
      var response  =  await _http.getRequest("${AppUrl.products}/list?limit=$limit&offset=$offset");
      productModel = ProductModel.fromJson(response);
      if(productModel.status?.toUpperCase() == AppResponseCodes.success){
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



  // function to refresh the list view
  void onRefresh()async{
    paginationLoading.value = true;
    paginationLoading.refresh();
    listProducts.value.clear();
    unFilteredListProducts.value.clear();
    await getProducts(limit: 10,offset: 0);
    // data refresh and th UI is rebuild
    refreshData();
    refreshController.loadComplete();
  }
  // function to handle pagination while scrolling
  void onLoading()async{
    paginationLoading.value = true;
    paginationLoading.refresh();
    await getProducts(limit: 10,offset:  listProducts.value.length);
    refreshData();
    refreshController.refreshCompleted();
  }

  onSearchChanged(String value){
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 0), (){
      if(value.isNotEmpty){

      }else{
        // if the value is empty then i append the previous list called unFilteredListProducts
        listProducts.value.addAll(unFilteredListProducts.value);
      }
    });
    // data refresh and th UI is rebuild
    refreshData();
  }

  // filter absences by type and date
  filterProducts(String type,String date){
    if(type.isNotEmpty  || date.isNotEmpty){

    }else{
      // when the filter is cleared then the list is reset
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