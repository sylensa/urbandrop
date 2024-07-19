
import 'package:urbandrop/models/order_summary_model.dart';

abstract class OrderSummaryState {}

class OrderSummaryInitial extends OrderSummaryState {}

class OrderSummaryLoading extends OrderSummaryState {}
class OrderSummaryEmpty extends OrderSummaryState {}

class OrderSummaryLoaded extends OrderSummaryState {
  OrderSummary? orderSummary;
  OrderSummaryLoaded({this.orderSummary});
}




