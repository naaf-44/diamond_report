import 'package:shared_preferences/shared_preferences.dart';

/// preference handler used to store the data locally
class PreferenceHandler {
  late SharedPreferences preferences;

  /// initialization
  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  /// save list of cart
  Future<void> addCart(String lotId) async {
    List<String>? cartList = getCart();
    cartList!.add(lotId);
    await preferences.setStringList("cart", cartList);
  }

  /// get list of cart
  List<String>? getCart() {
    List<String>? cartList = preferences.getStringList("cart") ?? [];
    return cartList;
  }

  /// delete from cart
  Future<void> deleteCart(String lotId) async {
    List<String>? cartList = getCart();
    cartList!.remove(lotId);
    await preferences.setStringList("cart", cartList);
  }
}