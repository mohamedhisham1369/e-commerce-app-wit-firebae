class OrderModel {
  String? cardNumber;
  String? cvv;
  String? address;
  String? expireData;
  List<Map<String, dynamic>> productlist = [];
  Map<String, dynamic>? userlist;

  OrderModel({
    this.cardNumber,
    this.cvv,
    this.address,
    this.expireData,
    required this.productlist,
    this.userlist,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    cardNumber = json['cardnumber'];
    cvv = json['cvv'];
    address = json['address'];
    expireData = json['expiredata'];
    if (json['productlist'] != null) {
      productlist = List<Map<String, dynamic>>.from(json['productlist']);
    }
    userlist = json['userlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardnumber'] = this.cardNumber;
    data['cvv'] = this.cvv;
    data['address'] = this.address;
    data['expiredata'] = this.expireData;
    data['productlist'] = this.productlist;
    data['userlist'] = this.userlist;
    return data;
  }
}
