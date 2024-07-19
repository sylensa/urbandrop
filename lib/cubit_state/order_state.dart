
import 'package:urbandrop/models/order_summary_model.dart';
import 'package:urbandrop/models/orders_model.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}
class OrderEmpty extends OrderState {}

class OrderLoaded extends OrderState {
 List<OrderData> listOrders = [];
 List<OrderData> listPendingOrders = [];
 List<OrderData> listConfirmOrders = [];
 List<OrderData> listInProgressOrders = [];
 List<OrderData> listCompletedOrders = [];
 List<OrderData> listDeclineOrders = [];
 List<OrderData> listCancelledOrders = [];
 List<OrderData> unFilteredListOrders = [];
  OrderLoaded({required this.listOrders,required this.listPendingOrders,required this.listConfirmOrders,required this.listInProgressOrders,
  required this.listCompletedOrders,required this.listDeclineOrders,required this.listCancelledOrders,required this.unFilteredListOrders});
}




