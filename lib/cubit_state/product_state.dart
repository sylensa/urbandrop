
import 'package:urbandrop/models/order_summary_model.dart';
import 'package:urbandrop/models/orders_model.dart';
import 'package:urbandrop/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}
class ProductEmpty extends ProductState {}

class ProductLoaded extends ProductState {
  List<ProductData> listProducts = [];
  ProductLoaded({required this.listProducts});
}




