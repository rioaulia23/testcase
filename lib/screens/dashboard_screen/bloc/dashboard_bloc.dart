import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testcase/models/product_model.dart';
import 'package:testcase/screens/dashboard_screen/service/dashboard_service.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<GetDashboardEvent>((event, emit) async {
      DashboardState? state = await _mapGetDashboard(event);
      if (state != null) emit(state);
    });
    on<LoadMoreEvent>((event, emit) async {
      DashboardState? state = await _mapLoadMore(event);
      if (state != null) emit(state);
    });
  }

  ProductModel productModel = ProductModel();
  DashboardService homeService = DashboardService();

  Future<DashboardState?> _mapGetDashboard(GetDashboardEvent event) async {
    productModel = await homeService.getDashboard(limit: 10);
    if (productModel != null) {
      if(productModel.products!.isNotEmpty){
        double finalPrice = 0;
        double totalPromo = 0;
        for (Products element in productModel.products!) {
          if(element.discountPercentage! > 0){
            totalPromo = (element.price! * element.discountPercentage!) / 100;
            finalPrice = element.price! - totalPromo;
            element.priceAfterDiscount = finalPrice.round();
          }else{
            element.priceAfterDiscount = element.price;
          }
        }
      }
      return SuccesGetDashboard();
    } else {

    }
    return null;
  }

  Future<DashboardState?> _mapLoadMore(LoadMoreEvent event) async {
    if (productModel.products!.length < 100 &&
        productModel.products!.isNotEmpty) {
      productModel = await homeService.getDashboard(
          limit: productModel.products!.length + 10);

      if (productModel != null) {
        if(productModel.products!.isNotEmpty){
          double finalPrice = 0;
          double totalPromo = 0;
          for (Products element in productModel.products!) {
            if(element.discountPercentage! > 0){
              totalPromo = (element.price! * element.discountPercentage!) / 100;
              finalPrice = element.price! - totalPromo;
              element.priceAfterDiscount = finalPrice.round();
            }else{
              element.priceAfterDiscount = element.price;
            }
          }
        }
        return SuccesGetDashboard();
      } else {

      }
    }
    return null;
  }
}
