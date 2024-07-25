import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

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

  // List<ProductModel> localProds = [
  //   // Phones
  //   ProductModel(
  //     //1
  //     productId: 'iphone14-128gb-black',
  //     productTitle: "Apple iPhone 14 Pro (128GB) - Black",
  //     productPrice: "1399.99",
  //     productCategory: "Phones",
  //     productDescription:
  //         "6.1-inch Super Retina XDR display with ProMotion and always-on display. Dynamic Island, a new and magical way to interact with your iPhone. 48MP main camera for up to 4x higher resolution. Cinematic mode, now in 4K Dolby Vision up to 30 fps. Action mode, for stable and smooth videos when you're on the move. Accident detection, vital safety technology that calls for help for you. All-day battery life and up to 23 hours of video playback.",
  //     productImage: "https://i.ibb.co/BtMBSgK/1-iphone14-128gb-black.webp",
  //     productQuantity: "10",
  //   ),
  //   ProductModel(
  //     //2
  //     productId: 'iphone13-mini-256gb-midnight',
  //     productTitle:
  //         "iPhone 13 Mini, 256GB, Midnight - Unlocked (Renewed Premium)",
  //     productPrice: "659.99",
  //     productCategory: "Phones",
  //     productDescription:
  //         "5.4 Super Retina XDR display. 5G Superfast downloads, high quality streaming. Cinematic mode in 1080p at 30 fps. Dolby Vision HDR video recording up to 4K at 60 fps. 2X Optical zoom range. A15 Bionic chip. New 6-core CPU with 2 performance and 4 efficiency cores. New 4-core GPU. New 16-core Neural Engine. Up to 17 hours video playback. Face ID. Ceramic Shield front. Aerospace-grade aluminum. Water resistant to a depth of 6 meters for up to 30 minutes. Compatible with MagSafe accessories and wireless chargers.",
  //     productImage:
  //         "https://i.ibb.co/nbwTvXQ/2-iphone13-mini-256gb-midnight.webp",
  //     productQuantity: "15",
  //   ),
  //   ProductModel(
  //     //3
  //     productId: 'Acheter un iPhone 14',
  //     productTitle: "iPhone 14",
  //     productPrice: "1199.99",
  //     productCategory: "Phones",
  //     productDescription:
  //         "Les détails concernant la livraison dans votre région s’afficheront sur la page de validation de la commande.",
  //     productImage: "https://i.ibb.co/G7nXCW4/3-i-Phone-14.jpg",
  //     productQuantity: "144",
  //   ),
  //   ProductModel(
  //     //4
  //     productId: const Uuid().v4(),
  //     productTitle:
  //         "Samsung Galaxy S22 Ultra 5G - 256GB - Phantom Black (Unlocked)",
  //     productPrice: "1199.99",
  //     productCategory: "Phones",
  //     productDescription:
  //         "About this item\n6.8 inch Dynamic AMOLED 2X display with a 3200 x 1440 resolution\n256GB internal storage, 12GB RAM\n108MP triple camera system with 100x Space Zoom and laser autofocus\n40MP front-facing camera with dual pixel AF\n5000mAh battery with fast wireless charging and wireless power share\n5G capable for lightning fast download and streaming",
  //     productImage:
  //         "https://i.ibb.co/z5zMDCx/4-Samsung-Galaxy-S22-Ultra-5-G-256-GB-Phantom-Black-Unlocked.webp",
  //     productQuantity: "2363",
  //   ),
  //   ProductModel(
  //     //5
  //     productId: const Uuid().v4(),
  //     productTitle:
  //         "Samsung Galaxy S21 Ultra 5G | Factory Unlocked Android Cell Phone | US Version 5G Smartphone",
  //     productPrice: "1199.99",
  //     productCategory: "Phones",
  //     productDescription:
  //         "About this item\nPro Grade Camera: Zoom in close with 100X Space Zoom, and take photos and videos like a pro with our easy-to-use, multi-lens camera.\n100x Zoom: Get amazing clarity with a dual lens combo of 3x and 10x optical zoom, or go even further with our revolutionary 100x Space Zoom.\nHighest Smartphone Resolution: Crystal clear 108MP allows you to pinch, crop and zoom in on your photos to see tiny, unexpected details, while lightning-fast Laser Focus keeps your focal point clear\nAll Day Intelligent Battery: Intuitively manages your cellphone’s usage, so you can go all day without charging (based on average battery life under typical usage conditions).\nPower of 5G: Get next-level power for everything you love to do with Samsung Galaxy 5G; More sharing, more gaming, more experiences and never miss a beat",
  //     productImage:
  //         "https://i.ibb.co/ww5WjkV/5-Samsung-Galaxy-S21-Ultra-5-G.png",
  //     productQuantity: "3625",
  //   ),
  //   ProductModel(
  //     //6
  //     productId: const Uuid().v4().toString(),
  //     productTitle:
  //         "OnePlus 9 Pro 5G LE2120 256GB 12GB RAM Factory Unlocked (GSM Only | No CDMA - not Compatible with Verizon/Sprint) International Version - Morning Mist",
  //     productPrice: "1099.99",
  //     productCategory: "Phones",
  //     productDescription:
  //         "About this item\n6.7 inch LTPO Fluid2 AMOLED, 1B colors, 120Hz, HDR10+, 1300 nits (peak)\n256GB internal storage, 12GB RAM\nQuad rear camera: 48MP, 50MP, 8MP, 2MP\n16MP front-facing camera\n4500mAh battery with Warp Charge 65T (10V/6.5A) and 50W Wireless Charging\n5G capable for lightning fast download and streaming",
  //     productImage:
  //         "https://i.ibb.co/0yhgKVv/6-One-Plus-9-Pro-5-G-LE2120-256-GB-12-GB-RAM.png",
  //     productQuantity: "3636",
  //   ),
  //
  //   ProductModel(
  //     //7
  //     productId: const Uuid().v4(),
  //     productTitle: "Samsung Galaxy Z Flip3 5G",
  //     productPrice: "999.99",
  //     productCategory: "Phones",
  //     productDescription:
  //         "About this item\nGet the latest Galaxy experience on your phone.\nFOLDING DISPLAY - Transform the way you capture, share and experience content.\nCAPTURE EVERYTHING - With the wide-angle camera and the front camera, take stunning photos and videos from every angle.\nWATER RESISTANT - Use your Galaxy Z Flip3 5G even when it rains.\nONE UI 3.1 - Enjoy the Galaxy Z Flip3 5G’s sleek, premium design and all the features you love from the latest One UI 3.1. ",
  //     productImage: "https://i.ibb.co/NstFstg/7-Samsung-Galaxy-Z-Flip3-5-G.png",
  //     productQuantity: "525",
  //   ),
  //   ProductModel(
  //     //8
  //     productId: const Uuid().v4(),
  //     productTitle: "Apple introduces iPhone 14 and iPhone 14 Plus",
  //     productPrice: "1199.99",
  //     productCategory: "Phones",
  //     productDescription:
  //         "A new, larger 6.7-inch size joins the popular 6.1-inch design, featuring a new dual-camera system, Crash Detection, a smartphone industry-first safety service with Emergency SOS via satellite, and the best battery life on iPhone",
  //     productImage: "https://i.ibb.co/8P1HBm4/8-iphone14plushereo.jpg",
  //     productQuantity: "2526",
  //   ),
  //   ProductModel(
  //     //9
  //     productId: const Uuid().v4(),
  //     productTitle: "Xiaomi Redmi Note 10 Pro",
  //     productPrice: "249.99",
  //     productCategory: "Phones",
  //     productDescription:
  //         "About this item\n6.67-inch 120Hz AMOLED display with TrueColor\n108MP quad rear camera system with 8K video support\nQualcomm Snapdragon 732G processor\n5020mAh (typ) high-capacity battery\n33W fast charging support and 33W fast charger included in the box",
  //     productImage: "https://i.ibb.co/W3QcVMv/9-Xiaomi-Redmi-Note-10-Pro.png",
  //     productQuantity: "353",
  //   ),
  //   ProductModel(
  //     //10
  //     productId: const Uuid().v4(),
  //     productTitle: "OnePlus 10 Pro 5G",
  //     productPrice: "899.99",
  //     productCategory: "Phones",
  //     productDescription:
  //         "About this item\n6.7 inch Fluid AMOLED Display with LTPO, 120 Hz refresh rate, 10-bit color, HDR10+, and adaptive refresh rate\nQualcomm Snapdragon 8 Gen 1 with Adreno 730 GPU\n4500 mAh battery with Warp Charge 65T (10V/6.5A) + Wireless Warp Charge 50\n256GB Internal Storage | 12GB RAM\nOxygenOS 12 based on Android 12 with Play Store",
  //     productImage: "https://i.ibb.co/9vGVHQk/10-One-Plus-10-Pro-5-G.png",
  //     productQuantity: "3873",
  //   ),
  //   ProductModel(
  //     //11
  //     productId: const Uuid().v4(),
  //     productTitle: "Google Pixel 6",
  //     productPrice: "799.99",
  //     productCategory: "Phones",
  //     productDescription:
  //         "About this item\nPowered by Google Tensor chip, designed for mobile, the Google Pixel 6 delivers exceptional AI-powered experiences.\n6.4-inch Full HD+ display with 90Hz refresh rate and HDR10+.\n50MP + 12MP dual rear camera system, 4K/60fps video recording.\n8MP front camera with Night Sight, portrait mode and more.\nBuilt-in Titan M2 security chip for advanced security.\nAndroid 12 OS with three years of updates and monthly security patches.",
  //     productImage: "https://i.ibb.co/0K8ZxZj/11-Google-Pixel-6.png",
  //     productQuantity: "62332",
  //   ),
  //   // Laptops
  //   // https://i.ibb.co/MDcGHsb/12-ASUS-ROG-Zephyrus-G15.jpg
  //   ProductModel(
  //     //12
  //     productId: const Uuid().v4(),
  //     productTitle: "ASUS ROG Zephyrus G15",
  //     productPrice: "1599.99",
  //     productCategory: "Laptops",
  //     productDescription:
  //         "About this item\nUltra Slim Gaming Laptop, 15.6” 144Hz FHD Display, GeForce GTX 1660 Ti Max-Q, AMD Ryzen 7 4800HS, 16GB DDR4, 512GB PCIe NVMe SSD, Wi-Fi 6, RGB Keyboard, Windows 10 Home, GA502IU-ES76",
  //     productImage: "https://i.ibb.co/kMR5mpR/12-ASUS-ROG-Zephyrus-G15.png",
  //     productQuantity: "525",
  //   ),
  //   ProductModel(
  //     //13
  //     productId: const Uuid().v4(),
  //     productTitle: "Acer Predator Helios 300",
  //     productPrice: "1199.99",
  //     productCategory: "Laptops",
  //     productDescription:
  //         "About this item\n10th Generation Intel Core i7-10750H 6-Core Processor (Up to 5.0 GHz) with Windows 10 Home 64 Bit\nOverclockable NVIDIA GeForce RTX 3060 Laptop GPU with 6 GB of dedicated GDDR6 VRAM, NVIDIA DLSS, NVIDIA Dynamic Boost 2.0, NVIDIA GPU Boost\n15.6\" Full HD (1920 x 1080) Widescreen LED-backlit IPS Display (144Hz Refresh Rate, 3ms Overdrive Response Time & 300nit Brightness)",
  //     productImage: "https://i.ibb.co/tcB3HXJ/13-Acer-Predator-Helios-300.webp",
  //     productQuantity: "5353",
  //   ),
  //   ProductModel(
  //     //14
  //     productId: const Uuid().v4(),
  //     productTitle: "Razer Blade 15 Base",
  //     productPrice: "1599.99",
  //     productCategory: "Laptops",
  //     productDescription:
  //         "About this item\nMore power: The 10th Gen Intel Core i7-10750H processor provides the ultimate level of performance with up to 5.0 GHz max turbo and 6 cores\nSupercharger: NVIDIA GeForce GTX 1660 Ti graphics delivers faster, smoother gameplay\nThin and compact: The CNC aluminum unibody frame houses incredible performance in the most compact footprint possible, while remaining remarkably durable and just 0.78\" thin",
  //     productImage: "https://i.ibb.co/XDtWpXC/14-Razer-Blade-15-Base.png",
  //     productQuantity: "5335",
  //   ),
  //   ProductModel(
  //     //15
  //     productId: const Uuid().v4(),
  //     productTitle: "MSI GS66 Stealth",
  //     productPrice: "1999.99",
  //     productCategory: "Laptops",
  //     productDescription:
  //         "About this item\n15.6\" FHD, Anti-Glare Wide View Angle 240Hz 3ms | NVIDIA GeForce RTX 2070 Max-Q 8G GDDR6\nIntel Core i7-10750H 2.6 - 5.0GHz | Intel Wi-Fi 6 AX201(22 ax)\n16GB (8G2) DDR4 3200MHz | 2 Sockets | Max Memory 64GB\nUSB 3.2 Gen2 3 | Thunderbolt 31 PD charge",
  //     productImage: "https://i.ibb.co/0Q4xHVn/15-MSI-GS66-Stealth.png",
  //     productQuantity: "2599",
  //   ),
  // ];

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
