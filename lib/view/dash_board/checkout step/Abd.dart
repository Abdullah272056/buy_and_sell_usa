class Abd {
  int? sellerId;
  double? shippingCharge;
  List<Product>? product;

  Abd({this.sellerId, this.shippingCharge, this.product});

  Abd.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    shippingCharge = json['shipping_charge'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seller_id'] = this.sellerId;
    data['shipping_charge'] = this.shippingCharge;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? productId;
  int? qty;
  String? colorId;
  Null? sizeId;

  Product({this.productId, this.qty, this.colorId, this.sizeId});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    qty = json['qty'];
    colorId = json['color_id'];
    sizeId = json['size_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['color_id'] = this.colorId;
    data['size_id'] = this.sizeId;
    return data;
  }
}