import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2_base_project/core/models/app_user.dart';
import 'package:f2_base_project/core/models/categories.dart';
import 'package:f2_base_project/core/models/faqs.dart';
import 'package:f2_base_project/core/models/helpline.dart';
import 'package:f2_base_project/core/models/notifications.dart';
import 'package:f2_base_project/core/models/offers.dart';
import 'package:f2_base_project/core/models/order.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/models/terms.dart';
import 'package:f2_base_project/core/models/user_address.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  static final DatabaseService _singleton = DatabaseService._internal();

  factory DatabaseService() {
    return _singleton;
  }

  DatabaseService._internal();

  checkUser(AppUser user) async {
    //Todo: Rename getUsers -> getUser
    debugPrint('@getAppUser: id: ${user.id}');
    try {
      final snapshot = await _db.collection('app_user').doc(user.id).get();
      if (snapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUser');
      debugPrint(s.toString());
      return false;
    }
  }

  /// Register app user
  registerAppUser(AppUser user) async {
    debugPrint("User @Id => ${user.id}");
    try {
      await _db
          .collection('app_user')
          .doc(user.id)
          .set(user.toJson())
          .then((value) => debugPrint('user registered successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAppUser');
      debugPrint(s.toString());
      return false;
    }
  }

  /// Get User from database using this funciton
  Future<AppUser> getAppUser(id) async {
    //Todo: Rename getUsers -> getUser
    debugPrint('@getAppUser: id: $id');
    try {
      final snapshot = await _db.collection('app_user').doc(id).get();
      debugPrint('Client Data: ${snapshot.data()}');
      return AppUser.fromJson(snapshot.data()!, snapshot.id);
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUser');
      debugPrint(s.toString());
      return AppUser();
    }
  }

  updateUserFcm(token, id) async {
    await _db.collection("app_user").doc(id).update({'fcmToken': token}).then(
        (value) => debugPrint('fcm updated successfully'));
  }

  updateUser(AppUser appUser, id) async {
    await _db
        .collection("app_user")
        .doc(id)
        .update(appUser.toJson())
        .then((value) => debugPrint('user updated successfully'));
  }

  /// save address
  saveAddress(UserAddress user, String id) async {
    debugPrint("User @Id => $id");
    try {
      await _db
          .collection('app_user')
          .doc(id)
          .collection('addresses')
          .add(user.toJson())
          .then((value) => debugPrint('user address added successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/addingAddress');
      debugPrint(s.toString());
      return false;
    }
  }

  ///
  /// get user addresses
  ///
  Future<List<UserAddress>> getAddresses(String id) async {
    print("@getAllAddresses");
    try {
      List<UserAddress> categories = [];
      QuerySnapshot snapshot = await _db
          .collection('app_user')
          .doc(id)
          .collection('addresses')
          .get();
      if (snapshot.docs.length < 1) {
        print('addresses not found in DB');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        categories.add(
            UserAddress.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      return categories;
    } catch (e, s) {
      print("Exception/gettingAllAddresses=========> $e, $s");
      return [];
    }
  }

  checkout(Orders order) async {
    try {
      await _db
          .collection('orders')
          .add(order.toJson())
          .then((value) => debugPrint('order successfully placed'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/placingOrder $e');
      debugPrint(s.toString());
      return false;
    }
  }

  Future<List<Orders>> getOrders(String id) async {
    print("@getAllOrders");
    try {
      List<Orders> categories = [];
      QuerySnapshot snapshot = await _db
          .collection('orders')
          .where('userId', isEqualTo: id)
          .orderBy('createdAt', descending: true)
          .get();
      if (snapshot.docs.length < 1) {
        print('orders not found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        categories
            .add(Orders.formJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      return categories;
    } catch (e, s) {
      print("Exception/gettingAllCategories=========> $e, $s");
      return [];
    }
  }

  ///
  /// add notificatoin
  ///
  addNotification(Notifications order) async {
    try {
      await _db
          .collection('notifications')
          .add(order.toJson())
          .then((value) => debugPrint('notificaiton successfully placed'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/addingNotificaton');
      debugPrint(s.toString());
      return false;
    }
  }

  ///
  /// get notifications
  ///
  Future<List<Notifications>> getNotifications(String id) async {
    print("@getAllNotifications");
    try {
      List<Notifications> categories = [];
      QuerySnapshot snapshot = await _db
          .collection('notifications')
          .where('userId', isEqualTo: id)
          .orderBy('createdAt', descending: true)
          .get();
      if (snapshot.docs.length < 1) {
        print('notificaitons not found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        categories.add(Notifications.fromJson(
            snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      return categories;
    } catch (e, s) {
      print("Exception/gettingAllNotifications=========> $e, $s");
      return [];
    }
  }

  ///
  /// delete user address
  ///
  deleteAddress(userId, id) async {
    await _db
        .collection("app_user")
        .doc(userId)
        .collection('addresses')
        .doc(id)
        .delete()
        .then((value) => debugPrint('address deleted successfully'));
  }

  Future<List<Categories>> getCategories() async {
    print("@getAllCategories");
    try {
      List<Categories> categories = [];
      QuerySnapshot snapshot = await _db.collection('categories').get();
      if (snapshot.docs.length < 1) {
        print('categories not found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        categories.add(
            Categories.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      // print('Categories :: db => ${categories.length}');

      return categories;
    } catch (e, s) {
      print("Exception/gettingAllCategories=========> $e, $s");
      return [];
    }
  }

  ///
  /// ==================== PRODUCTS =================== ////
  ///

  ///
  /// update product
  ///
  updateProduct(Product product) async {
    debugPrint('@updatingProduct');
    await _db
        .collection("products")
        .doc(product.id)
        .update({'likedUsersIds': product.likedUserIds});
  }

  updateProductStock(Product product) async {
    debugPrint('@updatingProduct');
    await _db
        .collection("products")
        .doc(product.id)
        .update({'stock': product.stock.toString()});
  }

  ///
  /// Get all products
  ///
  Future<List<Product>> getProducts() async {
    debugPrint('@gettingProducts');
    final List<Product> categories = [];
    try {
      final snapshot = await _db.collection("products").get();
      debugPrint('products => ${snapshot.docs.length}');
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          categories.add(Product.fromJson(doc, doc.id));
        }
      }
    } catch (e) {
      debugPrint('Exception @DatabaseService/gettingProducts $e');
    }
    return categories;
  }

  addCartToDB(String id, Orders order) async {
    await _db
        .collection("app_user")
        .doc(id)
        .collection('cart')
        .doc(id)
        .set(order.toJson())
        .then((value) => debugPrint('product added successfully to cart'));
  }

  deleteCartToDB(String id) async {
    await _db
        .collection("app_user")
        .doc(id)
        .collection('cart')
        .doc(id)
        .delete()
        .then((value) => debugPrint('Cart delete success'));
  }

  Future<Orders?> getCartProducts(String id) async {
    debugPrint('@getAppUserCart: id: $id');
    try {
      final snapshot = await _db
          .collection('app_user')
          .doc(id)
          .collection('cart')
          .doc(id)
          .get();
      if (snapshot.exists) {
        return Orders.formJson(snapshot.data()!, snapshot.id);
      } else {
        return null;
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/gettingCart');
      debugPrint(s.toString());
      return null;
    }
  }

  ///
  ///
  /// Get latest products
  ///
  Future<List<Product>> getLatestProducts() async {
    debugPrint('@gettingLatestProducts');
    final List<Product> categories = [];
    try {
      final snapshot = await _db
          .collection("products")
          .orderBy('createdAt', descending: true)
          .limit(30)
          .get();
      // debugPrint('products => ${snapshot.docs.length}');
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          categories.add(Product.fromJson(doc, doc.id));
        }
      }
    } catch (e) {
      debugPrint('Exception @DatabaseService/gettingLatestProducts $e');
    }
    return categories;
  }

  ///
  ///
  /// Get top rated products
  ///
  Future<List<Product>> getTopRatedProducts() async {
    debugPrint('@gettingTopRatedProducts');
    final List<Product> categories = [];
    try {
      final snapshot = await _db
          .collection("products")
          .where('isTopRated', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          categories.add(Product.fromJson(doc, doc.id));
        }
      }
    } catch (e) {
      debugPrint('Exception @DatabaseService/gettingLatestProducts $e');
    }
    return categories;
  }

  ///
  ///
  /// Get related products
  ///
  Future<List<Product>> getRelatedProducts(Product product) async {
    debugPrint('@gettingRelatedProducts');
    final List<Product> categories = [];
    try {
      final snapshot = await _db
          .collection("products")
          .where('category', isEqualTo: product.category)
          .limit(8)
          .get();
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          categories.add(Product.fromJson(doc, doc.id));
        }
      }
      for (var rel in categories) {
        if (product.sku == rel.sku) {
          categories.remove(rel);
        }
      }
    } catch (e) {
      debugPrint('Exception @DatabaseService/gettingRelated $e');
    }
    return categories;
  }

  ///
  ///
  /// Get products of specific cateogry
  ///
  Future<List<Product>> getCategoryProducts(String category) async {
    debugPrint('@gettingCategoryProducts');
    final List<Product> categories = [];
    try {
      final snapshot = await _db
          .collection("products")
          .where('category', isEqualTo: category)
          .get();
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          categories.add(Product.fromJson(doc, doc.id));
        }
      }
    } catch (e) {
      debugPrint('Exception @DatabaseService/gettingCategory $e');
    }
    return categories;
  }

  ///
  /// Get products of specific cateogry
  ///
  Future<List<Offers>> getOffers() async {
    debugPrint('@gettingOffers');
    final List<Offers> categories = [];
    try {
      final snapshot = await _db
          .collection("offers")
          .orderBy('createdAt', descending: true)
          .get();
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          categories.add(Offers.formJson(doc, doc.id));
        }
      }
    } catch (e) {
      debugPrint('Exception @DatabaseService/gettingOffers $e');
    }
    return categories;
  }

  ///
  ///
  /// Get app banners
  ///
  Future<List<String>> getAppBanners() async {
    debugPrint('@gettingAppBanners');
    final List<String> categories = [];
    try {
      final snapshot = await _db
          .collection("banners")
          .orderBy('createdAt', descending: true)
          .limit(5)
          .get();
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          categories.add(doc['imageUrl']);
        }
      }
    } catch (e) {
      debugPrint('Exception @DatabaseService/gettingAppBanners $e');
    }
    return categories;
  }

  //
  ///
  /// Get all app users
  ///
  Future<List<Faqs>> getFaqs() async {
    debugPrint('@gettingAppUsers');
    final List<Faqs> categories = [];
    try {
      final snapshot = await _db
          .collection("faqs")
          .orderBy('createdAt', descending: true)
          .get();
      debugPrint('faqs => ${snapshot.docs.length}');
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          categories.add(Faqs.formJson(doc, doc.id));
        }
      }
    } catch (e) {
      debugPrint('Exception @DatabaseService/gettingAppUsers $e');
    }
    return categories;
  }

  ///
  /// Get terms and conditions
  ///
  Future<Terms> getTerms() async {
    debugPrint('@getterms: id: T7SkD1RwqmWvbgj3yewV');
    try {
      final snapshot =
          await _db.collection('terms').doc('T7SkD1RwqmWvbgj3yewV').get();
      print('terms: ${snapshot.data()}');

      return Terms.fromJson(snapshot.data());
    } catch (e) {
      print('Exception @DatabaseService/getTerms $e');
      return Terms();
    }
  }

  ///
  /// Get helpline
  ///
  Future<HelpLine> getHelpline() async {
    debugPrint('@getHelpline: id: N6agSq0Xxx33F2wUx2Lh');
    try {
      final snapshot =
          await _db.collection('helpline').doc('N6agSq0Xxx33F2wUx2Lh').get();
      print('helpline: ${snapshot.data()}');
      return HelpLine.fromJson(snapshot.data(), snapshot.id);
    } catch (e) {
      print('Exception @DatabaseService/getHelpline $e');
      return HelpLine();
    }
  }
}
