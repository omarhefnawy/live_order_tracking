import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_traking/features/orders/add_order/data/model/add_order_model.dart';
import 'package:order_traking/features/orders/add_order/domain/repo/add_order_repo.dart';
import 'package:order_traking/features/orders/add_order/prsentation/order_bloc/add_order_states.dart';

class AddOrderCubit extends Cubit<AddOrderStates> {
 final AddOrderRepo repo;
 AddOrderCubit(this.repo) : super(AddingOrderInitial());
 Future<void> addOrder(AddOrderModel model)
 async{
   emit(AddingOrder());
   try{
     await repo.addOrder(model);
     emit(AddingOrderSuccess());
   }
   catch(e)
   {
     emit(AddingOrderFail("Failed to add to the order${e.toString()}"));
   }
 }
 // getting order by id
String uid= FirebaseAuth.instance.currentUser!.uid;
  Future<void> getUserOrders()
  async{
    emit(GetOrderLoading());
    try{
    final model=  await repo.getMyOrder(uid);
      emit(GetOrderSuccess(model));
    }
    catch (e)
    {
      emit(GetOrderFail('error getting Data ${e.toString()}'));
    }
  }
// update user lat long and status on the way
  Future<void> updateUserLatLong(String orderId,double userLat,double userLong,String status)
 async {
    emit(AddingOrder());
   try{
   await repo.updateOrderLocation(orderId, userLat, userLong, status);
   }
   catch (e)
   {
     throw Exception("error updating userlatlong ${e.toString()}");
   }
  }
  //update to delevered if the distance is 100 m
// update user lat long and status on the way
  Future<void> updateStatusToDelevered(String orderId,String status)
  async {
    emit(AddingOrder());
    try{
     await  repo.updateStatusIfDelivered(orderId, status);
     emit(OrderDeleveredSuccess());
    }
    catch (e)
    {
      throw Exception("error while calc distance ${e.toString()}");
    }
  }
}