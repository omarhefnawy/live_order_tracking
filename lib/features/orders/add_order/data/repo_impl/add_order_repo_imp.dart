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
  // get my orders
  @override
  Future<List<AddOrderModel>> getMyOrder(String uid) async{
    try
    {
      final list= await firestore.collection("orders").where("orderUserId",isEqualTo: uid).get();
      List<AddOrderModel> orders=[];
      for(var doc in list.docs)
        {
          orders.add( AddOrderModel.fromJson(doc.data())) ;
        }
      return orders;

    }
    catch(e)
    {
      throw Exception("Failed get your orders");
    }
  }
  @override
  Future<void> updateOrderLocation(String orderId, double userLat, double userLong, String status) async{
    // TODO: implement updateOrderLocation
   try
       {
         await firestore.collection("orders").where("orderId",isEqualTo:orderId ).get().then((onValue){
           onValue.docs.first.reference.update({"userLat":userLat,"userLang":userLong,"orderStatus":status});
         });
       }
       catch(e)
    {
      throw Exception("error updating ${e.toString()}");
    }
  }
  @override
  Future<void> updateStatusIfDelivered(String orderId, String status) async{
    // TODO: implement updateStatusIfDelivered
    try
    {
      await firestore.collection("orders").where("orderId",isEqualTo:orderId ).get().then((onValue){
        onValue.docs.first.reference.update({"orderStatus":status});
      });
    }
    catch(e)
    {
      throw Exception("error updating ${e.toString()}");
    }
  }
}