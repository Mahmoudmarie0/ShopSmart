import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_smart/models/cart_model.dart';
import 'package:shop_smart/models/product_model.dart';
import 'package:uuid/uuid.dart';

class MainController extends GetxController {
  static const THEME_STATUS = "THEME_STATUS";
  bool _darkTheme = false;

  bool get getIsDarkTheme => _darkTheme;
  User? user = FirebaseAuth.instance.currentUser;
  List<ProductModel> products = [];

  MainController() {
    //to save the theme value

    getTheme();
  }

  Future<void> setDarkTheme({required bool themeValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, themeValue);
    _darkTheme = themeValue;
    update();
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool(THEME_STATUS) ?? false;
    update();
    return _darkTheme;
  }

  ProductModel? productModel;
  final Map<String, CartModel> cartItem = {};

  Map<String, CartModel> get getCartItem => cartItem;

  ProductModel? findByProdId(String prodId) {
    if (products.where((element) => element.productId == prodId).isEmpty) {
      return null;
    }

    return products.firstWhere((element) => element.productId == prodId);
  }

  final productDB = FirebaseFirestore.instance.collection("products");

  Future<List<ProductModel>> fetchProducts() async {
    try {
      await productDB.get().then((productsSnapshot) {
        products.clear();
        for (var element in productsSnapshot.docs) {
          products.insert(
            0,
            ProductModel.fromFirestore(element),
          );
        }
      });
      return products;
    } catch (e) {
      rethrow;
    }
  }

  List<ProductModel> product = []; // Initialize a new list for each snapshot
  Stream<List<ProductModel>> fetchProductsAsStream() {
    return productDB.snapshots().map((snapshot) {
      product.clear();
      for (var element in snapshot.docs) {
        product.insert(
          0,
          ProductModel.fromFirestore(element),
        );
      }
      return product;
    }).handleError((e) {
      // Handle or log the error
      print('Error fetching products: $e');
      return <ProductModel>[]; // Return an empty list on error
    });
  }

  void addToCart({required String productId}) {
    cartItem.putIfAbsent(
        productId,
        () => CartModel(
            cartId: const Uuid().v4(), productId: productId, quantity: 1));
    update();
  }

  bool isAddedToCart(String productId) {
    return cartItem.containsKey(productId);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProducts();
  }
}
