
import 'package:urbandrop/models/faq_model.dart';
import 'package:urbandrop/models/order_summary_model.dart';

abstract class FaqState {}

class FaqInitial extends FaqState {}

class FaqLoading extends FaqState {}
class FaqEmpty extends FaqState {}

class FaqLoaded extends FaqState {
 List<FaqData> listFaqData = [];
  FaqLoaded({required this.listFaqData});
}




