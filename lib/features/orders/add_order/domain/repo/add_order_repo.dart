import 'package:order_traking/features/orders/add_order/data/model/add_order_model.dart';

abstract class AddOrderRepo{
  Future<void> addOrder(AddOrderModel model);
  Future<List<AddOrderModel>> getMyOrder(String uid);
  Future<void> updateOrderLocation(String orderId,double userLat , double userLong , String status);
  Future<void> updateStatusIfDelivered(String orderId,String status);
}
