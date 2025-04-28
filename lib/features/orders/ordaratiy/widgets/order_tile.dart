import 'package:flutter/material.dart';
import 'package:order_traking/features/locations/locations_screen/location_screen.dart';
import 'package:order_traking/features/orders/add_order/data/model/add_order_model.dart';
class OrderTile extends StatelessWidget {
  final AddOrderModel order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          order.orderName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("الوصول: ${order.orderArrivalDate}"),
            Text("الحالة: ${order.orderStatus}"),
          ],
        ),
        trailing: Icon(Icons.local_shipping),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen(model: order),));
        },
      ),
    );
  }
}
