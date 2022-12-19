
import 'dart:convert';

CategoriesData categoriesDataFromJson(String str) => CategoriesData.fromJson(json.decode(str));

String categoriesDataToJson(CategoriesData data) => json.encode(data.toJson());

class CategoriesData {
  CategoriesData({
    required this.success,
    required this.data,
    this.message,
  });

  bool success;
  List<Datum> data;
  String? message;

  factory CategoriesData.fromJson(Map<String, dynamic> json) => CategoriesData(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.categoryName,
    required this.hiddenStatusFromHome,
    required this.categorySlug,
    required this.subCategories,
  });

  int id;
  String? categoryName;
  int ?hiddenStatusFromHome;
  String? categorySlug;
  List<SubCategory>? subCategories;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    categoryName:json["category_name"],
    hiddenStatusFromHome: json["hidden_status_from_home"],
    categorySlug: json["category_slug"],
    subCategories: List<SubCategory>.from(json["sub_categories"].map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name":categoryName,
    "hidden_status_from_home": hiddenStatusFromHome,
    "category_slug": categorySlug,
    "sub_categories": List<dynamic>.from(subCategories!.map((x) => x.toJson())),
  };
}

// enum Catego { FASHION, JEWELLERY, ELECTRONICS, TOYS, HOME_LIVING, PREPARED_FOOD, FAVOURITE_RESTAURANT, GROCERY }

class SubCategory {
  SubCategory({
    required this.id,
    required this.subcategoryName,
    this.hiddenStatusFromHome,
    this.category,
    this.innerCategories,
    this.subCategorySlug,
  });

  int id;
  String subcategoryName;
  int? hiddenStatusFromHome;
  String? category;
  List<InnerCategory>? innerCategories;
  String? subCategorySlug;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    subcategoryName: json["subcategory_name"],
    hiddenStatusFromHome: json["hidden_status_from_home"],
    category: json["category"],
    innerCategories: List<InnerCategory>.from(json["inner_categories"].map((x) => InnerCategory.fromJson(x))),
    subCategorySlug: json["sub_category_slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subcategory_name": subcategoryName,
    "hidden_status_from_home": hiddenStatusFromHome,
    "category":category,
    "inner_categories": List<dynamic>.from(innerCategories!.map((x) => x.toJson())),
    "sub_category_slug": subCategorySlug,
  };
}

class InnerCategory {
  InnerCategory({
    required this.id,
    required this.innerCategoryName,
    this.categoyrName,
    this.innerCategorySlug,
  });

  int id;
  String innerCategoryName;
  String? categoyrName;
  String? innerCategorySlug;

  factory InnerCategory.fromJson(Map<String, dynamic> json) => InnerCategory(
    id: json["id"],
    innerCategoryName: json["inner_category_name"],
    categoyrName:json["categoyr_name"],
    innerCategorySlug: json["inner_category_slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "inner_category_name": innerCategoryName,
    "categoyr_name":categoyrName,
    "inner_category_slug": innerCategorySlug,
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
