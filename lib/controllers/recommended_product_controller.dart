import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/data/api/repository/popular_product_repo.dart';
import 'package:food_delivery_app/data/api/repository/recommended_product_repo.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      // print(_popularProductList);
      update();
    } else {}
  }
}