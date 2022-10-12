import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String? pname;
  int? pid;
  int? pcost;
  int? pavailability;
  String? pdetails;
  String? pcategory;
  String? pquantity;
  String? imageUrl =
      "http://cdn.shopify.com/s/files/1/0600/6236/7914/products/new-mystery-box-GIF.gif?v=1651111549";

  ProductModel(
      {this.pname,
      this.pid,
      this.pcost,
      this.pavailability,
      this.pdetails,
      this.pcategory,
      this.pquantity});

  ProductModel.fromJson(Map<String, dynamic> json) {
    pname = json['p_name'];
    pid = json['p_id'];
    pcost = json['p_cost'];
    pavailability = json['p_availability'];
    pdetails = json['p_details'];
    pcategory = json['p_category'];
    pquantity = json['p_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['p_name'] = pname;
    data['p_id'] = pid;
    data['p_cost'] = pcost;
    data['p_availability'] = pavailability;
    data['p_details'] = pdetails;
    data['p_category'] = pcategory;
    data['p_quantity'] = pquantity;
    return data;
  }
}
