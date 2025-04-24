import 'package:order_traking/features/orders/add_order/data/model/add_order_model.dart';

abstract class AddOrderRepo{
  Future<void> addOrder(AddOrderModel model);
}
