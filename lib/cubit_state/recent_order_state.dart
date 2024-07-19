
import 'package:urbandrop/models/order_summary_model.dart';
import 'package:urbandrop/models/orders_model.dart';

abstract class RecentOrderState {}

class RecentOrderInitial extends RecentOrderState {}

class RecentOrderLoading extends RecentOrderState {}
class RecentOrderEmpty extends RecentOrderState {}

class RecentOrderLoaded extends RecentOrderState {
 OrderData? recentOrderData;
  RecentOrderLoaded({this.recentOrderData});
}




