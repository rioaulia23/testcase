
import 'package:dio/dio.dart';
import 'package:testcase/models/product_model.dart';

class DashboardService{

  Future<ProductModel> getDashboard({int limit = 0}) async {
    ProductModel productModel = ProductModel();
    try {
      //Dio dio = Dio();
      Future.delayed(Duration(milliseconds: 500));
      print('https://dummyjson.com/products?limit=${limit.toString()}');

      Response response = await Dio().get(
        'https://dummyjson.com/products?limit=${limit.toString()}',
      );

      if (response.data != null) {
        productModel = ProductModel.fromJson(response.data);
        return productModel;
      }
      return productModel;
    } on DioError catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return productModel;
    }
  }

}