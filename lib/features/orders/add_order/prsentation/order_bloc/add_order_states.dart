import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_traking/features/orders/add_order/data/model/add_order_model.dart';

abstract class AddOrderStates{}
class AddingOrderInitial extends AddOrderStates{}
class AddingOrder extends AddOrderStates {}
class AddingOrderSuccess extends AddOrderStates {
}

class AddingOrderFail extends AddOrderStates {
  final String error;

  AddingOrderFail(this.error);

}
class GetOrderLoading extends AddOrderStates {}
class GetOrderSuccess extends AddOrderStates {
 final List<AddOrderModel> model;
 GetOrderSuccess(this.model);

}

class GetOrderFail extends AddOrderStates {
  final String error;

  GetOrderFail(this.error);

}
class OrderDeleveredSuccess extends AddOrderStates {}
