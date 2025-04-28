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
    super.initState();
    BlocProvider.of<AddOrderCubit>(context).getUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: BlocBuilder<AddOrderCubit, AddOrderStates>(
        builder: (context, state) {
          if (state is GetOrderLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is GetOrderFail) {
            return Center(
              child: Text(
                "Error getting the data: ${state.error}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }
          else if (state is GetOrderSuccess) {
            final orders = state.model;

            if (orders.isEmpty) {
              return const Center(
                child: Text(
                  "No orders available",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderTile(order: order);
              },
            );
          }
          else {
            return const Center(
              child: Text(
                "Unhandled Error",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }
        },
      ),
    );
  }
}
