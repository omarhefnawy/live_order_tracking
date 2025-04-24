import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:order_traking/features/auth/presentation/widgets/custom_text_buttom.dart';
import 'package:order_traking/features/orders/add_order/data/model/add_order_model.dart';
import 'package:order_traking/features/orders/add_order/prsentation/order_bloc/add_order_bloc.dart';
import 'package:order_traking/features/orders/add_order/prsentation/order_bloc/add_order_states.dart';
import 'package:order_traking/features/orders/add_order/prsentation/screens/order_destination.dart';

import '../../../../auth/presentation/widgets/custom_text_field.dart';
import '../../../../auth/presentation/widgets/validators.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  final TextEditingController _orderId = TextEditingController();
  final TextEditingController _orderName = TextEditingController();
  final TextEditingController _orderArrivalData = TextEditingController();
  LatLng? orderLating;
  LatLng? UserLating;
  String destinationInfo = "";
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _orderId.dispose();
    _orderName.dispose();
    _orderArrivalData.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOrderCubit, AddOrderStates>(
      listener: (context, state) {
        if(state is AddingOrderFail)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error ?? 'فشل إضافة الطلب. حاول مرة أخرى',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }
        else if (state is AddingOrderSuccess)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('order added successfuly',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
            Navigator.pushNamed(context, "home");
          }
      },
      builder: (context, state) {
        final order_cubit = BlocProvider.of<AddOrderCubit>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                child: Form(
                  key: _formKey,
                  child: SafeArea(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Title
                          const Text(
                            'A D D O R D E R',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Subtitle
                          const Text(
                            'Enter your details below to add your order',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 32),
                          // Order ID CustomTextField
                          CustomTextField(
                            validator: (p0) {
                              return Validators.ordinaryValidator(p0);
                            },
                            labelText: 'Your OrderId',
                            controller: _orderId,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          // Order Name CustomTextField
                          CustomTextField(
                            validator: (p0) {
                              return Validators.ordinaryValidator(p0);
                            },
                            labelText: 'order name',
                            controller: _orderName,
                          ),
                          const SizedBox(height: 16),
                          // Order  arrival data
                          CustomTextField(
                            readOnly: true,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              ).then((date) {
                                if (date != null) {
                                  String dateTime = DateFormat(
                                    "yyy,MM,dd",
                                  ).format(date);
                                  _orderArrivalData.text = dateTime;
                                }
                              });
                            },
                            validator: (p0) {
                              return Validators.ordinaryValidator(p0);
                            },
                            labelText: 'order arrival data',
                            controller: _orderArrivalData,
                          ),
                          const SizedBox(height: 16),
                          // add Location Info
                          CustomElevatedButton(
                            text: "Add your location ",
                            onPressed: () async {
                              LatLng? lating = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDestination(),
                                ),
                              );
                              if (lating != null) {
                                orderLating = lating;
                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                      lating.latitude,
                                      lating.longitude,
                                    );
                                destinationInfo =
                                    placemarks[0].country! +
                                    " " +
                                    placemarks[0].street!;
                                setState(() {});
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          destinationInfo.isNotEmpty
                              ? Text(destinationInfo)
                              : SizedBox.shrink(),
                          //add details of the place
                          const SizedBox(height: 20),

                          // Add Order Button (CustomElevatedButton)
                          CustomElevatedButton(
                            text:
                                state is AddingOrder
                                    ? "Adding...."
                                    : 'add order',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final orderId = _orderId.text.trim();
                                final orderName = _orderName.text.trim();
                                final orderData = _orderArrivalData.text.trim();
                                final userId =
                                    FirebaseAuth.instance.currentUser!.uid;
                                AddOrderModel model = AddOrderModel(
                                  orderId: orderId,
                                  orderName: orderName,
                                  orderLat: orderLating!.latitude,
                                  orderLong: orderLating!.longitude,
                                  orderArrivalDate: orderData,
                                  orderStatus: "not Started yet",
                                  orderUserId: userId,
                                  userLat: 0.0,
                                  userLang: 0.0,
                                );
                                order_cubit.addOrder(model);
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
