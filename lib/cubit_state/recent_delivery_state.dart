
import 'package:urbandrop/models/order_summary_model.dart';
import 'package:urbandrop/models/orders_model.dart';
import 'package:urbandrop/models/product_model.dart';

abstract class RecentDeliveryState {}

class RecentDeliveryInitial extends RecentDeliveryState {}

class RecentDeliveryLoading extends RecentDeliveryState {}
class RecentDeliveryEmpty extends RecentDeliveryState {}

class RecentDeliveryLoaded extends RecentDeliveryState {
  OrderData? recentOrderDelivery;
  RecentDeliveryLoaded({required this.recentOrderDelivery});
}




