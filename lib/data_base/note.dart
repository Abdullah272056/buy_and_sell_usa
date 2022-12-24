


final String tableNotes="cart_notes";

class CartNoteFields{
  static final List<String> values =[
    id, productId, productName, productRegularPrice, productDiscountedPrice, productPhoto,productQuantity
  ];

  static final String id='_id';
  static final String productId='productId';
  static final String productName='productName';
  static final String productRegularPrice='productRegularPrice';
  static final String productDiscountedPrice='productDiscountedPrice';
  static final String productPhoto='productPhoto';
  static final String productQuantity='productQuantity';


}

class CartNote{

  final int? id;
  final String productId;
  final String productName;
  final String productRegularPrice;
  final String productDiscountedPrice;
  final String productPhoto;
  final String productQuantity;


  const CartNote({
    this.id,
    required this.productId,
    required this.productName,
    required this.productRegularPrice,
    required this.productDiscountedPrice,
    required this.productPhoto,
    required this.productQuantity,
});

  CartNote copy({
  int? id,
  String? productId,
  String? productName,
  String? productRegularPrice,
  String? productDiscountedPrice,
    String? productPhoto,
    String? productQuantity
})=>
      CartNote(
      id: id?? this.id,
          productId: productId?? this.productId,
          productName: productName?? this.productName,
          productRegularPrice: productRegularPrice?? this.productRegularPrice,
          productDiscountedPrice: productDiscountedPrice?? this.productDiscountedPrice,
          productPhoto: productPhoto?? this.productPhoto,
        productQuantity: productPhoto?? this.productQuantity,
  );


static CartNote fromJson(Map<String, Object?> json)=> CartNote(
  id: json[CartNoteFields.id] as int?,
  productId: json[CartNoteFields.productId]as String,
  productName: json[CartNoteFields.productName] as String,
  productRegularPrice: json[CartNoteFields.productRegularPrice] as String,
  productDiscountedPrice: json[CartNoteFields.productDiscountedPrice] as String,
  productPhoto:  json[CartNoteFields.productPhoto] as String,
  productQuantity:  json[CartNoteFields.productQuantity] as String,
  );

  Map<String,Object?> toJson() =>{
    CartNoteFields.id:id,
    CartNoteFields.productId:productId,
    CartNoteFields.productName:productName,
    CartNoteFields.productRegularPrice:productRegularPrice,
    CartNoteFields.productDiscountedPrice:productDiscountedPrice,
    CartNoteFields.productPhoto:productPhoto,
    CartNoteFields.productQuantity:productQuantity,

  };


}