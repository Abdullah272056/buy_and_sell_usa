// To parse this JSON data, do
//
//     final productDetailsDataModelClass = productDetailsDataModelClassFromJson(jsonString);

import 'dart:convert';

List<dynamic> productDetailsDataModelClassFromJson(String str) => List<dynamic>.from(json.decode(str).map((x) => x));

String productDetailsDataModelClassToJson(List<dynamic> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

class ProductDetailsDataModelClassClass {
  ProductDetailsDataModelClassClass({
    this.product,
    this.reviews,
  });

  Product? product;
  List<dynamic>? reviews;

  factory ProductDetailsDataModelClassClass.fromJson(Map<String, dynamic> json) => ProductDetailsDataModelClassClass(
    product: Product.fromJson(json["product"]),
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "reviews": List<dynamic>.from(reviews!.map((x) => x)),
  };
}

class Product {
  Product({
    this.id,
    this.categoryId,
    this.subCategoryId,
    this.innerCategoryId,
    this.sellerId,
    this.productName,
    this.price,
    this.stock,
    this.discountPercent,
    this.taxPercent,
    this.coverImage,
    this.shortDescription,
    this.fullDescription,
    this.sizeMeasurement,
    this.sku,
    this.commission,
    this.commissionType,
    this.width,
    this.height,
    this.depth,
    this.weight,
    this.isHidden,
    this.grocery,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.category,
    this.subCategory,
    this.innerCategory,
    this.colors,
    this.sizes,
    this.images,
    this.sizeCharts,
    this.seller,
  });

  String ? id;
  String ?categoryId;
  String ?subCategoryId;
  String ?innerCategoryId;
  String ?sellerId;
  String? productName;
  String? price;
  String ?stock;
  String ?discountPercent;
  String? taxPercent;
  String? coverImage;
  String ?shortDescription;
  String ?fullDescription;
  String? sizeMeasurement;
  String ?sku;
  String ?commission;
  dynamic ?commissionType;
  String? width;
  String ?height;
  String? depth;
  double ?weight;
  String ?isHidden;
  String? grocery;
  String ?status;
  DateTime? createdAt;
  DateTime ?updatedAt;
  Slug? slug;
  Category? category;
  InnerCategoryClass ?subCategory;
  InnerCategoryClass ?innerCategory;
  List<ColorElement>? colors;
  List<Size>? sizes;
  List<Image> ?images;
  List<SizeChart> ?sizeCharts;
  Seller? seller;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    innerCategoryId: json["inner_category_id"],
    sellerId: json["seller_id"],
    productName: json["product_name"],
    price: json["price"],
    stock: json["stock"],
    discountPercent: json["discount_percent"],
    taxPercent: json["tax_percent"],
    coverImage: json["cover_image"],
    shortDescription: json["short_description"],
    fullDescription: json["full_description"],
    sizeMeasurement: json["size_measurement"],
    sku: json["sku"],
    commission: json["commission"],
    commissionType: json["commission_type"],
    width: json["width"],
    height: json["height"],
    depth: json["depth"],
    weight: json["weight"].toDouble(),
    isHidden: json["is_hidden"],
    grocery: json["grocery"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    slug: Slug.fromJson(json["slug"]),
    category: Category.fromJson(json["category"]),
    subCategory: InnerCategoryClass.fromJson(json["sub_category"]),
    innerCategory: InnerCategoryClass.fromJson(json["inner_category"]),
    colors: List<ColorElement>.from(json["colors"].map((x) => ColorElement.fromJson(x))),
    sizes: List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    sizeCharts: List<SizeChart>.from(json["size_charts"].map((x) => SizeChart.fromJson(x))),
    seller: Seller.fromJson(json["seller"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "inner_category_id": innerCategoryId,
    "seller_id": sellerId,
    "product_name": productName,
    "price": price,
    "stock": stock,
    "discount_percent": discountPercent,
    "tax_percent": taxPercent,
    "cover_image": coverImage,
    "short_description": shortDescription,
    "full_description": fullDescription,
    "size_measurement": sizeMeasurement,
    "sku": sku,
    "commission": commission,
    "commission_type": commissionType,
    "width": width,
    "height": height,
    "depth": depth,
    "weight": weight,
    "is_hidden": isHidden,
    "grocery": grocery,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "slug": slug?.toJson(),
    "category": category?.toJson(),
    "sub_category": subCategory?.toJson(),
    "inner_category": innerCategory?.toJson(),
    "colors": List<dynamic>.from(colors!.map((x) => x.toJson())),
    "sizes": List<dynamic>.from(sizes!.map((x) => x.toJson())),
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
    "size_charts": List<dynamic>.from(sizeCharts!.map((x) => x.toJson())),
    "seller": seller!.toJson(),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.position,
    this.icon,
    this.showProductBySubcategoryInHome,
    this.onlyExpressShipping,
    this.hideCategoryFromHome,
    this.showFilter,
    this.createdAt,
    this.updatedAt,
  });

  String ?id;
  String ?name;
  String ?position;
  String ?icon;
  String? showProductBySubcategoryInHome;
  String? onlyExpressShipping;
  String ?hideCategoryFromHome;
  String? showFilter;
  DateTime ?createdAt;
  DateTime? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    position: json["position"],
    icon: json["icon"],
    showProductBySubcategoryInHome: json["show_product_by_subcategory_in_home"],
    onlyExpressShipping: json["only_express_shipping"],
    hideCategoryFromHome: json["hide_category_from_home"],
    showFilter: json["show_filter"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "position": position,
    "icon": icon,
    "show_product_by_subcategory_in_home": showProductBySubcategoryInHome,
    "only_express_shipping": onlyExpressShipping,
    "hide_category_from_home": hideCategoryFromHome,
    "show_filter": showFilter,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class ColorElement {
  ColorElement({
    this.id,
    this.productId,
    this.colorId,
    this.createdAt,
    this.updatedAt,
    this.color,
  });

  String ?id;
  String? productId;
  String ?colorId;
  DateTime? createdAt;
  DateTime ?updatedAt;
  SizeClass ?color;

  factory ColorElement.fromJson(Map<String, dynamic> json) => ColorElement(
    id: json["id"],
    productId: json["product_id"],
    colorId: json["color_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    color: SizeClass.fromJson(json["color"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "color_id": colorId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "color": color!.toJson(),
  };
}

class SizeClass {
  SizeClass({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  String ?id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SizeClass.fromJson(Map<String, dynamic> json) => SizeClass(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class Image {
  Image({
    this.id,
    this.productId,
    this.colorId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  String ?id;
  String? productId;
  String? colorId;
  String? image;
  DateTime ?createdAt;
  DateTime? updatedAt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    productId: json["product_id"],
    colorId: json["color_id"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "color_id": colorId,
    "image": image,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class InnerCategoryClass {
  InnerCategoryClass({
    this.id,
    this.categoryId,
    this.subCategoryId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.hideProductFromHome,
  });

  String? id;
  String? categoryId;
  String? subCategoryId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? hideProductFromHome;

  factory InnerCategoryClass.fromJson(Map<String, dynamic> json) => InnerCategoryClass(
    id: json["id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"] == null ? null : json["sub_category_id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    hideProductFromHome: json["hide_product_from_home"] == null ? null : json["hide_product_from_home"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "sub_category_id": subCategoryId == null ? null : subCategoryId,
    "name": name,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "hide_product_from_home": hideProductFromHome == null ? null : hideProductFromHome,
  };
}

class Seller {
  Seller({
    this.id,
    this.name,
    this.storeName,
    this.storeSocialLink,
    this.phone,
    this.image,
    this.mobile,
    this.address,
    this.city,
    this.stateId,
    this.zipCode,
    this.countryId,
    this.email,
    this.username,
    this.isActive,
    this.isSeller,
    this.verified,
    this.aboutSeller,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  dynamic? storeName;
  dynamic? storeSocialLink;
  dynamic? phone;
  String ?image;
  dynamic? mobile;
  dynamic? address;
  dynamic? city;
  dynamic? stateId;
  dynamic? zipCode;
  dynamic? countryId;
  String? email;
  dynamic username;
  String? isActive;
  String? isSeller;
  String? verified;
  dynamic aboutSeller;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"],
    name: json["name"],
    storeName: json["store_name"],
    storeSocialLink: json["store_social_link"],
    phone: json["phone"],
    image: json["image"],
    mobile: json["mobile"],
    address: json["address"],
    city: json["city"],
    stateId: json["state_id"],
    zipCode: json["zip_code"],
    countryId: json["country_id"],
    email: json["email"],
    username: json["username"],
    isActive: json["is_active"],
    isSeller: json["is_seller"],
    verified: json["verified"],
    aboutSeller: json["about_seller"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "store_name": storeName,
    "store_social_link": storeSocialLink,
    "phone": phone,
    "image": image,
    "mobile": mobile,
    "address": address,
    "city": city,
    "state_id": stateId,
    "zip_code": zipCode,
    "country_id": countryId,
    "email": email,
    "username": username,
    "is_active": isActive,
    "is_seller": isSeller,
    "verified": verified,
    "about_seller": aboutSeller,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class SizeChart {
  SizeChart({
    this.id,
    this.productId,
    this.col1,
    this.col2,
    this.col3,
    this.col4,
    this.col5,
    this.col6,
    this.col7,
    this.col8,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? productId;
  String? col1;
  String? col2;
  String? col3;
  String? col4;
  String ?col5;
  dynamic col6;
  dynamic col7;
  dynamic col8;
  DateTime ?createdAt;
  DateTime? updatedAt;

  factory SizeChart.fromJson(Map<String, dynamic> json) => SizeChart(
    id: json["id"],
    productId: json["product_id"],
    col1: json["col_1"],
    col2: json["col_2"],
    col3: json["col_3"],
    col4: json["col_4"],
    col5: json["col_5"],
    col6: json["col_6"],
    col7: json["col_7"],
    col8: json["col_8"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "col_1": col1,
    "col_2": col2,
    "col_3": col3,
    "col_4": col4,
    "col_5": col5,
    "col_6": col6,
    "col_7": col7,
    "col_8": col8,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class Size {
  Size({
    this.id,
    this.productId,
    this.sizeId,
    this.createdAt,
    this.updatedAt,
    this.size,
  });

  String? id;
  String? productId;
  String? sizeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  SizeClass? size;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    id: json["id"],
    productId: json["product_id"],
    sizeId: json["size_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    size: SizeClass.fromJson(json["size"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "size_id": sizeId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "size": size!.toJson(),
  };
}

class Slug {
  Slug({
    this.id,
    this.originType,
    this.originId,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? originType;
  String? originId;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Slug.fromJson(Map<String, dynamic> json) => Slug(
    id: json["id"],
    originType: json["origin_type"],
    originId: json["origin_id"],
    slug: json["slug"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "origin_type": originType,
    "origin_id": originId,
    "slug": slug,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
