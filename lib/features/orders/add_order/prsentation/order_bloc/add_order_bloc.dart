import 'package:bloc/bloc.dart';
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
}