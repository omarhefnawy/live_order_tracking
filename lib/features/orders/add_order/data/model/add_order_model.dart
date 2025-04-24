class AddOrderModel {
  final String orderId;
  final String orderName;
  final double orderLat;
  final double orderLong;
  final String orderArrivalDate;
  final String orderStatus;
  final String orderUserId;
  final double userLat;
  final double userLang;

  AddOrderModel({
    required this.orderId,
    required this.orderName,
    required this.orderLat,
    required this.orderLong,
    required this.orderArrivalDate,
    required this.orderStatus,
    required this.orderUserId,
    required this.userLat,
    required this.userLang,
  });

  factory AddOrderModel.fromJson(Map<String, dynamic> json) {
    return AddOrderModel(
      orderId: json['orderId'],
      orderName: json['orderName'],
      orderLat: json['orderLat'],
      orderLong: json['orderLong'],
      orderArrivalDate: json['orderArrivalDate'],
      orderStatus: json['orderStatus'],
      orderUserId: json['orderUserId'],
      userLat: json['userLat'],
      userLang: json['userLang'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orderName': orderName,
      'orderLat': orderLat,
      'orderLong': orderLong,
      'orderArrivalDate': orderArrivalDate,
      'orderStatus': orderStatus,
      'orderUserId': orderUserId,
      'userLat': userLat,
      'userLang': userLang,
    };
  }

  AddOrderModel copyWith({
    String? orderId,
    String? orderName,
    double? orderLat,
    double? orderLong,
    String? orderArrivalDate,
    String? orderStatus,
    String? orderUserId,
    double? userLat,
    double? userLang,
  }) {
    return AddOrderModel(
      orderId: orderId ?? this.orderId,
      orderName: orderName ?? this.orderName,
      orderLat: orderLat ?? this.orderLat,
      orderLong: orderLong ?? this.orderLong,
      orderArrivalDate: orderArrivalDate ?? this.orderArrivalDate,
      orderStatus: orderStatus ?? this.orderStatus,
      orderUserId: orderUserId ?? this.orderUserId,
      userLat: userLat ?? this.userLat,
      userLang: userLang ?? this.userLang,
    );
  }
}
