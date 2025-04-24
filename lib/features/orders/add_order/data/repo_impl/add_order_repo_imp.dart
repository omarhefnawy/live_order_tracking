import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_traking/features/orders/add_order/data/model/add_order_model.dart';
import 'package:order_traking/features/orders/add_order/domain/repo/add_order_repo.dart';

class AddOrderRepoImp implements AddOrderRepo{
  final  FirebaseFirestore  firestore;

  AddOrderRepoImp(this.firestore);
  @override
  Future<void> addOrder(AddOrderModel model) async{
    // TODO: implement addOrder
    try
        {
          await firestore.collection("orders").doc(model.orderId).set(model.toJson());
        }
        catch(e)
    {
      throw Exception("Failed adding to firebase");
    }
  }
}