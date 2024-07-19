
import 'package:urbandrop/models/order_summary_model.dart';
import 'package:urbandrop/models/orders_model.dart';
import 'package:urbandrop/models/product_model.dart';

abstract class TopProductState {}

class TopProductInitial extends TopProductState {}

class TopProductLoading extends TopProductState {}
class TopProductEmpty extends TopProductState {}

class TopProductLoaded extends TopProductState {
 List<ProductData> topProducts = [];
  TopProductLoaded({required this.topProducts});
}




