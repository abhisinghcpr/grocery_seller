class OrderModel {
  final String categoryId;
  final String categoryName;
  final dynamic createdAt;
  final String customerAddress;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String deliveryTime;
  final String fullPrice;
  final bool isSale;
  final String productDescription;
  final String productId;
  final List productImages;
  final String productName;
  final int productQuantity;
  final double productTotalPrice;
  final String salePrice;
  final bool status;
  final String customerEmail;
  final dynamic updatedAt;

  OrderModel({
    required this.customerEmail,
    required this.categoryId,
    required this.categoryName,
    required this.createdAt,
    required this.customerAddress,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryTime,
    required this.fullPrice,
    required this.isSale,
    required this.productDescription,
    required this.productId,
    required this.productImages,
    required this.productName,
    required this.productQuantity,
    required this.productTotalPrice,
    required this.salePrice,
    required this.status,
    required this.updatedAt,
  });

// Convert the object to a map
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'createdAt': createdAt,
      'customerAddress': customerAddress,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deliveryTime': deliveryTime,
      'fullPrice': fullPrice,
      'isSale': isSale,
      'productDescription': productDescription,
      'productId': productId,
      'productImages': productImages,
      'productName': productName,
      'productQuantity': productQuantity,
      'productTotalPrice': productTotalPrice,
      'salePrice': salePrice,
      'status': status,
      'customerEmail': customerEmail,
      'updatedAt': updatedAt,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      createdAt: json['createdAt'],
      customerAddress: json['customerAddress'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      deliveryTime: json['deliveryTime'],
      fullPrice: json['fullPrice'],
      isSale: json['isSale'],
      productDescription: json['productDescription'],
      productId: json['productId'],
      productImages: json['productImages'],
      productName: json['productName'],
      productQuantity: json['productQuantity'],
      productTotalPrice: json['productTotalPrice'],
      salePrice: json['salePrice'],
      status: json['status'],
      customerEmail: json['customerEmail'],
      updatedAt: json['updatedAt'],
    );
  }
}
