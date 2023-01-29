


final String tableNotes="fnf_cart_notes";

class CartNoteFields{
  static final List<String> values =[
    id, productId, productName, productRegularPrice, productDiscountedPrice, productPhoto,productQuantity,
    weight,seller,sellerName,slug,colorImage,size,color,sizeId,
  colorId,grocery,tax,shipping,shippingName,width,height,depth,weightOption,commission,commissionType
  ];

  static final String id='_id';
  static final String productId='productId';
  static final String productName='productName';
  static final String productRegularPrice='productRegularPrice';
  static final String productDiscountedPrice='productDiscountedPrice';
  static final String productPhoto='productPhoto';
  static final String productQuantity='productQuantity';

  static final String weight='weight';
  static final String seller='seller';
  static final String sellerName='sellerName';
  static final String slug='slug';
  static final String colorImage='colorImage';
  static final String size='size';
  static final String color='color';
  static final String sizeId='sizeId';
  static final String colorId='colorId';
  static final String grocery='grocery';

  static final String tax='tax';
  static final String shipping='shipping';
  static final String shippingName='shippingName';
  static final String width='width';
  static final String height='height';
  static final String depth='depth';
  static final String weightOption='weightOption';
  static final String commission='commission';
  static final String commissionType='commissionType';


}

class CartNote{

  final int? id;
  final String productId;
  final String productName;
  final String productRegularPrice;
  final String productDiscountedPrice;
  final String productPhoto;
  final String productQuantity;


  final  String weight;
  final  String seller;
  final  String sellerName;
  final  String slug;
  final  String colorImage;
  final  String size;
  final  String color;
  final  String sizeId;
  final  String colorId;
  final  String grocery;

  final  String tax;
  final  String shipping;
  final  String shippingName;
  final  String width;
  final  String height;
  final  String depth;
  final  String weightOption;
  final  String commission;
  final  String commissionType;


  const CartNote({
    this.id,
    required this.productId,
    required this.productName,
    required this.productRegularPrice,
    required this.productDiscountedPrice,
    required this.productPhoto,
    required this.productQuantity,

    required this.weight,
    required this.seller,
    required this.sellerName,
    required this.slug,
    required this.colorImage,
    required this.size,
    required this.color,
    required this.sizeId,
    required this.colorId,
    required this.grocery,
    required this.tax,
    required this.shipping,
    required this.shippingName,
    required this.width,
    required this.height,
    required this.depth,
    required this.weightOption,
    required this.commission,
    required this.commissionType,

});

  CartNote copy({
  int? id,
  String? productId,
  String? productName,
  String? productRegularPrice,
  String? productDiscountedPrice,
  String? productPhoto,
  String? productQuantity,

    String? weight,
    String?seller,
    String? sellerName,
    String? slug,
    String? colorImage,
    String? size,
    String? color,
    String? sizeId,
    String? colorId,
    String? grocery,

    String? tax,
    String? shipping,
    String? shippingName,
    String? width,
    String? height,
    String? depth,
    String? weightOption,
    String? commission,
    String? commissionType

})=>
      CartNote(
           id: id?? this.id,
          productId: productId?? this.productId,
          productName: productName?? this.productName,
          productRegularPrice: productRegularPrice?? this.productRegularPrice,
          productDiscountedPrice: productDiscountedPrice?? this.productDiscountedPrice,
          productPhoto: productPhoto?? this.productPhoto,
          productQuantity: productPhoto?? this.productQuantity,


          weight: weight?? this.weight,
          seller: seller?? this.seller,
          sellerName: sellerName?? this.sellerName,
          slug: slug?? this.slug,
          colorImage: colorImage?? this.colorImage,
          size: size?? this.size,
          color: color?? this.color,
          sizeId: sizeId?? this.sizeId,
          colorId: colorId?? this.colorId,
          grocery: grocery?? this.grocery,


          tax: tax?? this.tax,
          shipping: shipping?? this.shipping,
          shippingName: shippingName?? this.shippingName,
          width: width?? this.width,
          height: height?? this.height,
          depth: depth?? this.depth,
          weightOption: weightOption?? this.weightOption,
          commission: commission?? this.commission,
          commissionType: commissionType?? this.commissionType


  );


static CartNote fromJson(Map<String, Object?> json)=> CartNote(
  id: json[CartNoteFields.id] as int?,
  productId: json[CartNoteFields.productId]as String,
  productName: json[CartNoteFields.productName] as String,
  productRegularPrice: json[CartNoteFields.productRegularPrice] as String,
  productDiscountedPrice: json[CartNoteFields.productDiscountedPrice] as String,
  productPhoto:  json[CartNoteFields.productPhoto] as String,
  productQuantity:  json[CartNoteFields.productQuantity] as String,


  weight:  json[CartNoteFields.weight] as String,
  seller:  json[CartNoteFields.seller] as String,
  sellerName:  json[CartNoteFields.sellerName] as String,
  slug:  json[CartNoteFields.slug] as String,
  colorImage:  json[CartNoteFields.colorImage] as String,
  size:  json[CartNoteFields.size] as String,
  color:  json[CartNoteFields.color] as String,
  sizeId:  json[CartNoteFields.sizeId] as String,
  colorId:  json[CartNoteFields.colorId] as String,
  grocery:  json[CartNoteFields.grocery] as String,


  tax:  json[CartNoteFields.tax] as String,
  shipping:  json[CartNoteFields.shipping] as String,
  shippingName:  json[CartNoteFields.shippingName] as String,
  width:  json[CartNoteFields.width] as String,
  height:  json[CartNoteFields.height] as String,
  depth:  json[CartNoteFields.depth] as String,
  weightOption:  json[CartNoteFields.weightOption] as String,
  commission:  json[CartNoteFields.commission] as String,
  commissionType:  json[CartNoteFields.commissionType] as String



  );

  Map<String,Object?> toJson() =>{
    CartNoteFields.id:id,
    CartNoteFields.productId:productId,
    CartNoteFields.productName:productName,
    CartNoteFields.productRegularPrice:productRegularPrice,
    CartNoteFields.productDiscountedPrice:productDiscountedPrice,
    CartNoteFields.productPhoto:productPhoto,
    CartNoteFields.productQuantity:productQuantity,


    CartNoteFields.weight:weight,
    CartNoteFields.seller:seller,
    CartNoteFields.sellerName:sellerName,
    CartNoteFields.slug:slug,
    CartNoteFields.colorImage:colorImage,
    CartNoteFields.size:size,
    CartNoteFields.color:color,
    CartNoteFields.sizeId:sizeId,
    CartNoteFields.colorId:colorId,
    CartNoteFields.grocery:grocery,

    CartNoteFields.tax:tax,
    CartNoteFields.shipping:shipping,
    CartNoteFields.shippingName:shippingName,
    CartNoteFields.width:width,
    CartNoteFields.height:height,
    CartNoteFields.depth:depth,
    CartNoteFields.weightOption:weightOption,
    CartNoteFields.commission:commission,
    CartNoteFields.commissionType:commissionType

  };


}