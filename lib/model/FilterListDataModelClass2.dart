// To parse this JSON data, do
//
//     final filterListDataModelClass = filterListDataModelClassFromJson(jsonString);

import 'dart:convert';

FilterListDataModelClass2 filterListDataModelClass2FromJson(String str) => FilterListDataModelClass2.fromJson(json.decode(str));

String filterListDataModelClass2ToJson(FilterListDataModelClass2 data) => json.encode(data.toJson());

class FilterListDataModelClass2 {
  FilterListDataModelClass2({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory FilterListDataModelClass2.fromJson(Map<String, dynamic> json) => FilterListDataModelClass2(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data!.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.category,
    this.subCategory,
    this.innerCategory,
    this.catArr,
    this.subCatArr,
    this.innerCatArr,
    this.brands,
    this.brandName,
    this.min,
    this.max,
    this.sizeId,
    this.colorId,
    this.sortBy,
    this.search,
    this.categoryName,
    this.products,
  });

  String ? category;
  String ? subCategory;
  dynamic ? innerCategory;
  List<String> ? catArr;
  List<dynamic> ? subCatArr;
  List<dynamic> ? innerCatArr;
  List<dynamic> ? brands;
  dynamic brandName;
  String ? min;
  String ? max;
  List<dynamic> ? sizeId;
  List<dynamic> ? colorId;
  String ? sortBy;
  dynamic ? search;
  Category ? categoryName;
  Products ? products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: json["category"].toString(),
    subCategory: json["sub_category"].toString(),
    innerCategory: json["inner_category"].toString(),
    catArr: List<String>.from(json["cat_arr"].map((x) => x)),
    subCatArr: List<dynamic>.from(json["sub_cat_arr"].map((x) => x)),
    innerCatArr: List<dynamic>.from(json["inner_cat_arr"].map((x) => x)),
    brands: List<dynamic>.from(json["brands"].map((x) => x)),
    brandName: json["brand_name"].toString(),
    min: json["min"].toString(),
    max: json["max"].toString(),
    sizeId: List<dynamic>.from(json["size_id"].map((x) => x)),
    colorId: List<dynamic>.from(json["color_id"].map((x) => x)),
    sortBy: json["sort_by"].toString(),
    search: json["search"].toString(),
    categoryName: Category.fromJson(json["category_name"]),
    products: Products.fromJson(json["products"]),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "sub_category": subCategory,
    "inner_category": innerCategory,
    "cat_arr": List<dynamic>.from(catArr!.map((x) => x)),
    "sub_cat_arr": List<dynamic>.from(subCatArr!.map((x) => x)),
    "inner_cat_arr": List<dynamic>.from(innerCatArr!.map((x) => x)),
    "brands": List<dynamic>.from(brands!.map((x) => x)),
    "brand_name": brandName,
    "min": min,
    "max": max,
    "size_id": List<dynamic>.from(sizeId!.map((x) => x)),
    "color_id": List<dynamic>.from(colorId!.map((x) => x)),
    "sort_by": sortBy,
    "search": search,
    "category_name": categoryName!.toJson(),
    "products": products!.toJson(),
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

  String ? id;
  String ? name;
  String ? position;
  String ? icon;
  String ? showProductBySubcategoryInHome;
  String ? onlyExpressShipping;
  String ? hideCategoryFromHome;
  String ? showFilter;
  String ? createdAt;
  String ? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"].toString(),
    name: json["name"].toString(),
    position: json["position"].toString(),
    icon: json["icon"].toString(),
    showProductBySubcategoryInHome: json["show_product_by_subcategory_in_home"].toString(),
    onlyExpressShipping: json["only_express_shipping"].toString(),
    hideCategoryFromHome: json["hide_category_from_home"].toString(),
    showFilter: json["show_filter"].toString(),
    createdAt:  json["created_at"] .toString(),
    updatedAt:  json["updated_at"].toString() ,
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
    "created_at": createdAt ,
    "updated_at": updatedAt ,
  };
}

class Products {
  Products({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  String ? currentPage;
  List<Datum> ? data;
  String ? firstPageUrl;
  String ? from;
  String ? lastPage;
  String ? lastPageUrl;
  List<Link> ? links;
  dynamic ? nextPageUrl;
  String ? path;
  String ? perPage;
  dynamic ? prevPageUrl;
  String ? to;
  String ? total;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    currentPage: json["current_page"].toString(),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"].toString(),
    from: json["from"].toString(),
    lastPage: json["last_page"].toString(),
    lastPageUrl: json["last_page_url"].toString(),
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"].toString(),
    path: json["path"].toString(),
    perPage: json["per_page"].toString(),
    prevPageUrl: json["prev_page_url"].toString(),
    to: json["to"].toString(),
    total: json["total"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
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
  String ? categoryId;
  String ? subCategoryId;
  String ? innerCategoryId;
  String ? sellerId;
  String ? productName;
  String ? price;
  String ? stock;
  String ? discountPercent;
  String ? taxPercent;
  String ? coverImage;
  String ? shortDescription;
  String ? fullDescription;
  dynamic    sizeMeasurement;
  String ? sku;
  String ? commission;
  dynamic   commissionType;
  String ? width;
  String ? height;
  String ? depth;
  String ? weight;
  String ? isHidden;
  String ? grocery;
  String ? status;
  String ? createdAt;
  String ? updatedAt;
  Slug ? slug;
  Category ? category;
  InnerCategoryClass ? subCategory;
  InnerCategoryClass ? innerCategory;
  List<dynamic>?  colors;
  List<dynamic> ? sizes;
  List<Image> ? images;
  List<dynamic> ? sizeCharts;
  Seller ? seller;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"].toString(),
    categoryId: json["category_id"].toString(),
    subCategoryId: json["sub_category_id"].toString(),
    innerCategoryId: json["inner_category_id"].toString(),
    sellerId: json["seller_id"].toString(),
    productName: json["product_name"].toString(),
    price: json["price"].toString(),
    stock: json["stock"].toString(),
    discountPercent: json["discount_percent"].toString(),
    taxPercent: json["tax_percent"].toString(),
    coverImage: json["cover_image"].toString(),
    shortDescription: json["short_description"].toString(),
    fullDescription: json["full_description"].toString(),
    sizeMeasurement: json["size_measurement"].toString(),
    sku: json["sku"].toString(),
    commission: json["commission"].toString(),
    commissionType: json["commission_type"].toString(),
    width: json["width"].toString(),
    height: json["height"].toString(),
    depth: json["depth"].toString(),
    weight: json["weight"].toString(),
    isHidden: json["is_hidden"].toString(),
    grocery: json["grocery"].toString(),
    status: json["status"].toString(),
    createdAt:  json["created_at"].toString()  ,
    updatedAt:  json["updated_at"].toString() ,
    slug: Slug.fromJson(json["slug"]),
    category: Category.fromJson(json["category"]),
    subCategory: InnerCategoryClass.fromJson(json["sub_category"]),
    innerCategory: InnerCategoryClass.fromJson(json["inner_category"]),
    colors: List<dynamic>.from(json["colors"].map((x) => x)),
    sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    sizeCharts: List<dynamic>.from(json["size_charts"].map((x) => x)),
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
    "created_at": createdAt ,
    "updated_at": updatedAt ,
    "slug": slug!.toJson().toString(),
    "category": category!.toJson().toString(),
    "sub_category": subCategory!.toJson().toString(),
    "inner_category": innerCategory!.toJson().toString(),
    "colors": List<dynamic>.from(colors!.map((x) => x)),
    "sizes": List<dynamic>.from(sizes!.map((x) => x)),
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
    "size_charts": List<dynamic>.from(sizeCharts!.map((x) => x)),
    "seller": seller!.toJson(),
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

  String ? id;
  String ? productId;
  String?  colorId;
  String ? image;
  String ? createdAt;
  String ? updatedAt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"].toString(),
    productId: json["product_id"].toString(),
    colorId: json["color_id"].toString(),
    image: json["image"].toString(),
    createdAt: json["created_at"].toString() ,
    updatedAt:  json["updated_at"].toString() ,
  );

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "product_id": productId,
    "color_id": colorId,
    "image": image,
    "created_at": createdAt ,
    "updated_at": updatedAt ,
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

  String ? id;
  String ? categoryId;
  String ? subCategoryId;
  String ? name;
  String? createdAt;
  String ? updatedAt;
  String ? hideProductFromHome;

  factory InnerCategoryClass.fromJson(Map<String, dynamic> json) => InnerCategoryClass(
    id: json["id"].toString(),
    categoryId: json["category_id"].toString(),
    subCategoryId: json["sub_category_id"] == null ? null : json["sub_category_id"],
    name: json["name"].toString(),
    createdAt:  json["created_at"].toString() ,
    updatedAt:  json["updated_at"] .toString(),
    hideProductFromHome: json["hide_product_from_home"] == null ? null : json["hide_product_from_home"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "sub_category_id": subCategoryId == null ? null : subCategoryId,
    "name": name,
    "created_at": createdAt ,
    "updated_at": updatedAt ,
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

  String ? id;
  String ? name;
  dynamic storeName;
  dynamic storeSocialLink;
  dynamic phone;
  String ? image;
  dynamic mobile;
  dynamic address;
  dynamic city;
  dynamic stateId;
  dynamic zipCode;
  dynamic countryId;
  String ? email;
  dynamic username;
  String ? isActive;
  String ? isSeller;
  String ? verified;
  dynamic aboutSeller;
  String ? createdAt;
  String ? updatedAt;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"].toString(),
    name: json["name"].toString(),
    storeName: json["store_name"].toString(),
    storeSocialLink: json["store_social_link"].toString(),
    phone: json["phone"].toString(),
    image: json["image"].toString(),
    mobile: json["mobile"].toString(),
    address: json["address"].toString(),
    city: json["city"].toString(),
    stateId: json["state_id"].toString(),
    zipCode: json["zip_code"].toString(),
    countryId: json["country_id"].toString(),
    email: json["email"] ,
    username: json["username"] ,
    isActive: json["is_active"].toString(),
    isSeller: json["is_seller"].toString(),
    verified: json["verified"].toString(),
    aboutSeller: json["about_seller"] ,
    createdAt:  json["created_at"].toString() ,
    updatedAt:  json["updated_at"].toString() ,
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
    "created_at": createdAt ,
    "updated_at": updatedAt ,
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

  String ? id;
  String ? originType;
  String ? originId;
  String ? slug;
  String ? createdAt;
  String ? updatedAt;

  factory Slug.fromJson(Map<String, dynamic> json) => Slug(
    id: json["id"].toString(),
    originType: json["origin_type"].toString(),
    originId: json["origin_id"].toString(),
    slug: json["slug"].toString(),
    createdAt:  json["created_at"].toString() ,
    updatedAt:  json["updated_at"].toString() ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "origin_type": originType,
    "origin_id": originId,
    "slug": slug,
    "created_at": createdAt ,
    "updated_at": updatedAt ,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String ? url;
  String ? label;
  bool ? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"].toString(),
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}
