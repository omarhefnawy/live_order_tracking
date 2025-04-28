import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_traking/core/contsants/colorConstant.dart';
import 'package:order_traking/features/orders/add_order/prsentation/order_bloc/add_order_bloc.dart';
import 'package:order_traking/features/orders/add_order/prsentation/order_bloc/add_order_states.dart';
import 'package:order_traking/features/orders/ordaratiy/widgets/order_tile.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<AddOrderCubit>(context).getUserOrders();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: BlocBuilder<AddOrderCubit, AddOrderStates>(
        builder: (context, state) {
          if(state is GetOrderLoading)
            {
              return Center(child: CircularProgressIndicator());
            }
          else if(state is GetOrderFail)
            {
              return Center(child: Text("Error getting the data ${state.error}"));
            }
          else if(state is GetOrderSuccess)
            {
           final orders= state.model;
           if(orders.isEmpty)
             {
                return Center(child: Text("No orders available"));
             }
           return ListView.builder(
             itemCount: orders.length,
               itemBuilder: (context, index) {
               final order=orders[index];
               return OrderTile(order: order);
               },
            );
            }
          else
            {
              return Center(child: Text("NOT handeled Error"),);
            }

        },
      ),
    );
  }
}
